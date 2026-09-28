// Unit tests for TransactionBloc – pure logic, no widgets, milliseconds fast.
// This is the payoff of the bloc architecture: business logic is
// testable without a single line of UI code.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wealth_flow/features/transactions/data/demo_transaction_data.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';
import 'package:wealth_flow/features/transactions/presentation/bloc/transaction_bloc.dart';

void main() {
  final testEntry = TransactionEntry(
    title: 'Test-Buchung',
    amount: 42.50,
    isIncome: true,
    date: DateTime(2026, 9, 28, 12),
  );

  group('TransactionBloc', () {
    test('starts with an empty list', () {
      expect(TransactionBloc().state.transactions, isEmpty);
    });

    blocTest<TransactionBloc, TransactionState>(
      'TransactionListStarted loads the demo data',
      build: TransactionBloc.new,
      act: (bloc) => bloc.add(const TransactionListStarted()),
      expect: () => [
        TransactionState(transactions: DemoTransactionData.transactions),
      ],
    );

    blocTest<TransactionBloc, TransactionState>(
      'TransactionAdded appends the entry',
      build: TransactionBloc.new,
      act: (bloc) => bloc.add(TransactionAdded(testEntry)),
      expect: () => [
        TransactionState(transactions: [testEntry]),
      ],
    );

    blocTest<TransactionBloc, TransactionState>(
      'TransactionRemoved removes exactly that entry',
      build: TransactionBloc.new,
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
