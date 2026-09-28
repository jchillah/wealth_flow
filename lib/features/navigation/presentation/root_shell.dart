import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wealth_flow/features/dashboard/presentation/dashboard_screen.dart';
import 'package:wealth_flow/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:wealth_flow/features/transactions/presentation/transactions_screen.dart';
import 'package:wealth_flow/features/crypto/presentation/crypto_screen.dart';

/// Feature: navigation – the app shell.
///
/// StatefulWidget here is legitimate: the only state is the selected tab
/// (pure UI state). Business state lives in blocs.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // BlocProvider = the composition root: ONE TransactionBloc instance
    // lives ABOVE both screens that need it (dashboard + list).
    // The cascade `..add()` fires its first event immediately after creation.
    return BlocProvider(
      create: (_) => TransactionBloc()..add(const TransactionListStarted()),
      child: Scaffold(
        // IndexedStack: keeps every tab's state alive.
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            DashboardScreen(),
            TransactionsScreen(),
            CryptoScreen(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) =>
              setState(() => _currentIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'Buchungen',
            ),
            NavigationDestination(
              icon: Icon(Icons.currency_bitcoin_outlined),
              selectedIcon: Icon(Icons.currency_bitcoin),
              label: 'Krypto',
            ),
          ],
        ),
      ),
    );
  }
}
