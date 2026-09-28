import 'package:flutter/material.dart';

/// Feature: crypto – presentation layer (honest placeholder).
/// M4 fills this with live CoinGecko data: dio + Hive cache +
/// Either-based error handling + offline fallback.
class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Krypto-Markt')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.currency_bitcoin,
                size: 72,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Live-Kurse kommen in Sprint 3',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Diese Seite wird echte CoinGecko-Daten zeigen – '
                'mit Offline-Cache und sauberem Error-Handling.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
