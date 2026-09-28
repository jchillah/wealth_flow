import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';

/// Feature: transactions – DATA layer (mock data source).
///
/// Why central? In M3 the real Hive database replaces exactly THIS file,
/// behind a repository interface. Screens and blocs won't notice –
/// they only depend on the abstraction ("Single Source of Truth").
abstract final class DemoTransactionData {
  // `static final` (not const): DateTime has no const constructor.
  static final List<TransactionEntry> transactions = [
    TransactionEntry(
      title: 'Gehalt September',
      amount: 2900,
      isIncome: true,
      date: DateTime(2026, 9, 1, 8),
    ),
    TransactionEntry(
      title: 'Miete',
      amount: 950,
      isIncome: false,
      date: DateTime(2026, 9, 1, 9),
    ),
    TransactionEntry(
      title: 'Verkauf: Rennrad',
      amount: 140,
      isIncome: true,
      date: DateTime(2026, 9, 18, 17),
    ),
    TransactionEntry(
      title: 'Netflix-Abo',
      amount: 12.99,
      isIncome: false,
      date: DateTime(2026, 9, 15, 0),
    ),
    TransactionEntry(
      title: 'Lebensmittel',
      amount: 87.43,
      isIncome: false,
      date: DateTime(2026, 9, 20, 18),
    ),
    TransactionEntry(
      title: 'Café',
      amount: 4.80,
      isIncome: false,
      date: DateTime(2026, 9, 24, 10),
    ),
  ];
}
