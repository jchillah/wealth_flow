import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/root_shell.dart';

/// Root widget: wires the theme and the first screen together.
/// It draws nothing itself – it *composes*.
class WealthFlowApp extends StatelessWidget {
  const WealthFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WealthFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RootShell(),
    );
  }
}
