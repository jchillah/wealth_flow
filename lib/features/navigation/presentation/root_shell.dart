// features/navigation/presentation/root_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealth_flow/features/crypto/presentation/crypto_screen.dart';
import 'package:wealth_flow/features/dashboard/presentation/dashboard_screen.dart';
import 'package:wealth_flow/features/navigation/presentation/bottom_nav_bar.dart';
import 'package:wealth_flow/features/transactions/data/mock_transaction_repository.dart';
import 'package:wealth_flow/features/transactions/domain/transaction_repository.dart';
import 'package:wealth_flow/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:wealth_flow/features/transactions/presentation/transactions_screen.dart';

/// Feature: navigation – the app shell + THE composition root.
///
/// This is the ONLY place in the whole app that decides which concrete
/// backend serves the data. Swapping MockTransactionRepository for the
/// Hive implementation (M3) or a cloud implementation (optional M7) is a
/// ONE-LINE change – no screen, no bloc, no test needs to know.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TransactionRepository>(
      create: (_) => MockTransactionRepository(),
      child: BlocProvider(
        create: (context) =>
            TransactionBloc(context.read<TransactionRepository>())
              ..add(const TransactionListStarted()),
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: const [
              DashboardScreen(),
              TransactionsScreen(),
              CryptoScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
