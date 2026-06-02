import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

abstract final class PokemonColorHelper {
  PokemonColorHelper._();

  static Color getColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return AppColors.fire;

      case 'water':
        return AppColors.water;

      case 'grass':
        return AppColors.grass;

      case 'electric':
        return AppColors.electric;

      case 'psychic':
        return AppColors.psychic;

      case 'dragon':
        return AppColors.dragon;

      default:
        return AppColors.primary;
    }
  }
}
