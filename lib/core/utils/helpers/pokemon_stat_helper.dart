import 'package:flutter/material.dart';

abstract final class PokemonStatHelper {
  PokemonStatHelper._();

  static Color getStatColor(int value) {
    if (value >= 120) {
      return const Color(0xFF00C853);
    }

    if (value >= 90) {
      return const Color(0xFF42A5F5);
    }

    if (value >= 60) {
      return const Color(0xFFFFB300);
    }

    return const Color(0xFFEF5350);
  }

  static String getRating(int value) {
    if (value >= 120) {
      return 'Elite';
    }

    if (value >= 90) {
      return 'Strong';
    }

    if (value >= 60) {
      return 'Average';
    }

    return 'Low';
  }
}
