import 'package:wealth_flow/features/transactions/data/demo_transaction_data.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_repository.dart';

/// Feature: transactions – DATA layer.
///
/// A fully working in-memory implementation of the repository contract.
/// Testing vocabulary, strictly speaking: a "Fake" (a mock *verifies*
/// calls, a fake actually *works*) – the naming follows common usage.
///
/// Used for: development (today), unit tests (with custom seeds),
/// and as the blueprint for the Hive implementation in M3.
class MockTransactionRepository implements TransactionRepository {
  MockTransactionRepository({List<TransactionEntry>? seed})
    : _entries = List.of(seed ?? DemoTransactionData.transactions);

  /// Private working copy: nobody outside can mutate our storage.
  final List<TransactionEntry> _entries;

  @override
  Future<List<TransactionEntry>> getTransactions() async =>
      List.unmodifiable(_entries);

  @override
  Future<void> addTransaction(TransactionEntry entry) async =>
      _entries.add(entry);

  @override
  Future<void> removeTransaction(TransactionEntry entry) async =>
      _entries.remove(entry);

  // M3 (Hive):     same contract, but entries survive app restarts.
  // M7 (optional): same contract, but entries sync via Firebase or
  //                Supabase. NOTHING above this layer changes.
}
