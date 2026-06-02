import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color withOpacityValue(double opacity) {
    return withValues(alpha: opacity);
  }

  bool get isDark {
    return computeLuminance() < 0.5;
  }

  Color darken([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);

    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  Color lighten([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);

    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }
}
