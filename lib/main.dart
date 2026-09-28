import 'package:flutter/material.dart';

import 'app.dart';

/// Entry point – Dart starts here, runApp() mounts the widget tree.
///
/// Pro-Habit: main.dart stays minimal. Real configuration lives in app.dart,
/// so bootstrap and composition stay separated.
void main() {
  runApp(const WealthFlowApp());
}
