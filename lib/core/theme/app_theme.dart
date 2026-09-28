import 'package:flutter/material.dart';

/// Central theme configuration (core = shared across all features).
///
/// `abstract final class` (Dart 3): a utility class – it can neither be
/// extended nor instantiated. The compiler-enforced version of a class
/// with only static members.
abstract final class AppTheme {
  /// Material 3: one seed color generates the entire coherent color
  /// scheme – buttons, cards, error colors, and later the dark theme.
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B894)),
  );
}
