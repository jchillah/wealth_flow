// Smoke test: the app boots with its bloc wiring and shows the shell.

import 'package:flutter_test/flutter_test.dart';

import 'package:wealth_flow/app.dart';

void main() {
  testWidgets('App startet mit drei Tabs und Saldo aus dem Bloc', (
    tester,
  ) async {
    await tester.pumpWidget(const WealthFlowApp());
    // Bloc events process asynchronously – let the UI settle,
    // then the dashboard shows the numbers computed from bloc state.
    await tester.pumpAndSettle();

    expect(find.text('WealthFlow'), findsOneWidget);
    expect(find.text('Saldo'), findsOneWidget);
    // Proves the whole pipeline: bloc → state → dashboard rendering.
    expect(find.text('1984.78 €'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Buchungen'), findsOneWidget);
    expect(find.text('Krypto'), findsOneWidget);
  });
}
