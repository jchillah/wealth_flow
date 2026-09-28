import 'package:flutter/material.dart';

import 'package:wealth_flow/features/transactions/data/demo_transaction_data.dart';

/// Feature: transactions – presentation layer.
/// M2 makes the FAB alive: bloc + input dialog.
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = DemoTransactionData.transactions;

    return Scaffold(
      appBar: AppBar(title: const Text('Buchungen')),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return ListTile(
            leading: Icon(
              entry.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: entry.isIncome
                  ? theme.colorScheme.primary
                  : theme.colorScheme.error,
            ),
            title: Text(entry.title),
            subtitle: Text(
              '${entry.date.day}.${entry.date.month}.${entry.date.year}',
            ),
            trailing: Text(
              '${entry.isIncome ? '+' : '-'}'
              '${entry.amount.toStringAsFixed(2)} €',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: entry.isIncome
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // M2: opens the "Buchung anlegen" dialog
        child: const Icon(Icons.add),
      ),
    );
  }
}
