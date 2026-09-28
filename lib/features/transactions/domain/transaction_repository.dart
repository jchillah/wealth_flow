import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';

/// Feature: transactions – DOMAIN layer.
///
/// THE CONTRACT. The domain defines WHAT storage must provide –
/// concrete backends (Hive, Firebase, Supabase, REST) implement it.
/// The dependency arrow points INWARD: data depends on the domain,
/// never the other way around (Dependency Inversion Principle).
///
/// Methods are async from day one: real backends are async, and the
/// caller should never care whether the answer comes from memory,
/// a local database or a server round-trip.
abstract interface class TransactionRepository {
  Future<List<TransactionEntry>> getTransactions();

  Future<void> addTransaction(TransactionEntry entry);

  Future<void> removeTransaction(TransactionEntry entry);
}
