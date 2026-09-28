// Smoke test: the app boots and shows its navigation shell.
// Runs in seconds – no device or emulator needed.

import 'package:flutter_test/flutter_test.dart';

import 'package:wealth_flow/app.dart';

void main() {
  testWidgets('App startet mit drei Tabs', (tester) async {
    await tester.pumpWidget(const WealthFlowApp());

    // Finders skip "offstage" widgets by default – we only assert
    // what the user actually sees on the first tab:
    expect(find.text('WealthFlow'), findsOneWidget); // AppBar
    expect(find.text('Saldo'), findsOneWidget); // balance card
    expect(find.text('Dashboard'), findsOneWidget); // tab labels
    expect(find.text('Buchungen'), findsOneWidget);
    expect(find.text('Krypto'), findsOneWidget);
  });
}
