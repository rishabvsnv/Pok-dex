import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

abstract final class PokemonColorHelper {
  PokemonColorHelper._();

  static Color getColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF7043);

      case 'water':
        return const Color(0xFF42A5F5);

      case 'grass':
        return const Color(0xFF66BB6A);

      case 'electric':
        return const Color(0xFFFFCA28);

      case 'psychic':
        return const Color(0xFFEC407A);

      case 'ice':
        return const Color(0xFF26C6DA);

      case 'dragon':
        return const Color(0xFF7E57C2);

      case 'dark':
        return const Color(0xFF5D4037);

      case 'fairy':
        return const Color(0xFFF48FB1);

      case 'normal':
        return const Color(0xFFBDBDBD);

      case 'fighting':
        return const Color(0xFFE53935);

      case 'flying':
        return const Color(0xFF90CAF9);

      case 'poison':
        return const Color(0xFFAB47BC);

      case 'ground':
        return const Color(0xFFD4A373);

      case 'rock':
        return const Color(0xFFA1887F);

      case 'bug':
        return const Color(0xFF8BC34A);

      case 'ghost':
        return const Color(0xFF7E57C2);

      case 'steel':
        return const Color(0xFF90A4AE);

      default:
        return AppColors.primary;
    }
  }
}
