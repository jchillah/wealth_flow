import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';
import 'package:wealth_flow/features/transactions/presentation/bloc/transaction_bloc.dart';

/// Feature: dashboard (presentation layer).
/// Reads the SAME bloc as the list – one source of truth, both
/// screens can never disagree about the data.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // context.watch: subscribes THIS build() to the bloc – rebuilds
    // whenever new state arrives. (read = no subscription; for
    // one-shot actions like button callbacks.)
    final transactions = context.watch<TransactionBloc>().state.transactions;

    final income = _sum(transactions, isIncome: true);
    final expenses = _sum(transactions, isIncome: false);
    final balance = income - expenses;

    return Scaffold(
      appBar: AppBar(title: const Text('WealthFlow')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Saldo', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    '${balance.toStringAsFixed(2)} €',
                    // Negative balance → error color, theme-aware.
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: balance < 0
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  icon: Icons.arrow_downward,
                  label: 'Einnahmen',
                  value: income,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryTile(
                  icon: Icons.arrow_upward,
                  label: 'Ausgaben',
                  value: expenses,
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// The Dart standard combo: `where` filters, `fold` accumulates.
  double _sum(List<TransactionEntry> transactions, {required bool isIncome}) {
    return transactions
        .where((entry) => entry.isIncome == isIncome)
        .fold<double>(0, (sum, entry) => sum + entry.amount);
  }
}

/// One of the two summary tiles (income / expenses).
class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(label, style: theme.textTheme.bodySmall),
            Text(
              '${value.toStringAsFixed(2)} €',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
