/// Feature: transactions – DOMAIN layer.
///
/// A domain entity: pure data with business meaning. It knows NOTHING
/// about Flutter widgets or databases – that is the core idea of
/// Clean Architecture. `final` fields = immutable (bloc-friendly).
class TransactionEntry {
  const TransactionEntry({
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.date,
  });

  final String title;

  /// Amount is ALWAYS positive – the direction lives in [isIncome].
  /// That makes sign errors impossible.
  ///
  /// Pro note: real money should be stored as `int` cents (minor units),
  /// because `double` rounds (0.1 + 0.2 != 0.3). We refactor this in M3.
  final double amount;

  final bool isIncome;
  final DateTime date;
}
