import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_theme_extension.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  AppThemeExtension get appTheme =>
      Theme.of(this).extension<AppThemeExtension>()!;
}
