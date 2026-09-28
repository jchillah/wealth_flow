// features/transactions/presentation/transactions_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_entry.dart';
import 'package:wealth_flow/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:wealth_flow/features/transactions/presentation/widgets/add_transaction_dialog.dart';

/// Feature: transactions – presentation layer.
/// Bloc-driven: state in, widgets out. The screen owns NO data itself.
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Buchungen')),
      // BlocBuilder: rebuilds ONLY this subtree on new state –
      // scoped rebuilds keep the rest of the tree untouched.
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          final entries = state.transactions;

          if (entries.isEmpty) {
            return const Center(child: Text('Noch keine Buchungen.'));
          }

          return ListView.builder(
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final entry = await showDialog<TransactionEntry>(
            context: context,
            builder: (_) => const AddTransactionDialog(),
          );

          if (!context.mounted || entry == null) {
            return;
          }

          context.read<TransactionBloc>().add(TransactionAdded(entry));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
