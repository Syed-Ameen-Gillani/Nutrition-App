import 'package:flutter/material.dart';

extension BuildContextExten on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet => MediaQuery.of(this).size.width >= 600 && MediaQuery.of(this).size.width < 900;
  bool get isDesktop => MediaQuery.of(this).size.width >= 900;

  /// Returns the current theme of the app.
  TextTheme get tTheme => Theme.of(this).textTheme;
  /// Returns the current color scheme of the app.
  ColorScheme get cScheme => Theme.of(this).colorScheme;
}