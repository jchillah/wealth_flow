// Unit tests for TransactionBloc – pure logic, no widgets, milliseconds fast.
// The seam in action: tests inject the repository they want,
// with exactly the seed data they need.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wealth_flow/features/transactions/data/demo_transaction_data.dart';
import 'package:wealth_flow/features/transactions/data/mock_transaction_repository.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';
import 'package:wealth_flow/features/transactions/presentation/bloc/transaction_bloc.dart';

void main() {
  final testEntry = TransactionEntry(
    title: 'Test-Buchung',
    amount: 42.50,
    isIncome: true,
    date: DateTime(2026, 9, 28, 12),
  );

  TransactionBloc blocWith({List<TransactionEntry>? seed}) => TransactionBloc(
    MockTransactionRepository(seed: seed),
  );

  group('TransactionBloc', () {
    test('starts with an empty list', () {
      expect(blocWith().state.transactions, isEmpty);
    });

    blocTest<TransactionBloc, TransactionState>(
      'started loads whatever the repository provides (custom seed)',
      build: () => blocWith(seed: [testEntry]),
      act: (bloc) => bloc.add(const TransactionListStarted()),
      expect: () => [TransactionState(transactions: [testEntry])],
    );

    blocTest<TransactionBloc, TransactionState>(
      'started loads the mock demo data (default seed)',
      build: blocWith,
      act: (bloc) => bloc.add(const TransactionListStarted()),
      expect: () => [
        TransactionState(transactions: DemoTransactionData.transactions),
      ],
    );

    blocTest<TransactionBloc, TransactionState>(
      'added appends the entry',
      build: blocWith,
      act: (bloc) => bloc.add(TransactionAdded(testEntry)),
      expect: () => [TransactionState(transactions: [testEntry])],
    );

    blocTest<TransactionBloc, TransactionState>(
      'removed removes exactly that entry',
      build: blocWith,
      act: (bloc) => bloc
        ..add(const TransactionListStarted())
        ..add(TransactionRemoved(DemoTransactionData.transactions.first)),
      expect: () => [
        TransactionState(transactions: DemoTransactionData.transactions),
        TransactionState(
          transactions: DemoTransactionData.transactions.skip(1).toList(),
        ),
      ],
    );
  });
}
