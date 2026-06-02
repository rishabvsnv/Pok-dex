import 'package:flutter/material.dart';

class PokemonTypeData {
  final String type;
  final Color color;
  final IconData icon;

  const PokemonTypeData({
    required this.type,
    required this.color,
    required this.icon,
  });
}

abstract final class PokemonTypes {
  PokemonTypes._();

  static const Map<String, PokemonTypeData> types = {
    'normal': PokemonTypeData(
      type: 'normal',
      color: Color(0xFFA8A77A),
      icon: Icons.adjust_rounded,
    ),

    'fire': PokemonTypeData(
      type: 'fire',
      color: Color(0xFFEE8130),
      icon: Icons.local_fire_department_rounded,
    ),

    'water': PokemonTypeData(
      type: 'water',
      color: Color(0xFF6390F0),
      icon: Icons.water_drop_rounded,
    ),

    'electric': PokemonTypeData(
      type: 'electric',
      color: Color(0xFFF7D02C),
      icon: Icons.flash_on_rounded,
    ),

    'grass': PokemonTypeData(
      type: 'grass',
      color: Color(0xFF7AC74C),
      icon: Icons.eco_rounded,
    ),

    'ice': PokemonTypeData(
      type: 'ice',
      color: Color(0xFF96D9D6),
      icon: Icons.ac_unit_rounded,
    ),

    'fighting': PokemonTypeData(
      type: 'fighting',
      color: Color(0xFFC22E28),
      icon: Icons.sports_mma_rounded,
    ),

    'poison': PokemonTypeData(
      type: 'poison',
      color: Color(0xFFA33EA1),
      icon: Icons.science_rounded,
    ),

    'ground': PokemonTypeData(
      type: 'ground',
      color: Color(0xFFE2BF65),
      icon: Icons.landscape_rounded,
    ),

    'flying': PokemonTypeData(
      type: 'flying',
      color: Color(0xFFA98FF3),
      icon: Icons.air_rounded,
    ),

    'psychic': PokemonTypeData(
      type: 'psychic',
      color: Color(0xFFF95587),
      icon: Icons.auto_awesome_rounded,
    ),

    'bug': PokemonTypeData(
      type: 'bug',
      color: Color(0xFFA6B91A),
      icon: Icons.pest_control_rounded,
    ),

    'rock': PokemonTypeData(
      type: 'rock',
      color: Color(0xFFB6A136),
      icon: Icons.terrain_rounded,
    ),

    'ghost': PokemonTypeData(
      type: 'ghost',
      color: Color(0xFF735797),
      icon: Icons.nightlight_round_rounded,
    ),

    'dragon': PokemonTypeData(
      type: 'dragon',
      color: Color(0xFF6F35FC),
      icon: Icons.whatshot_rounded,
    ),

    'dark': PokemonTypeData(
      type: 'dark',
      color: Color(0xFF705746),
      icon: Icons.dark_mode_rounded,
    ),

    'steel': PokemonTypeData(
      type: 'steel',
      color: Color(0xFFB7B7CE),
      icon: Icons.hardware_rounded,
    ),

    'fairy': PokemonTypeData(
      type: 'fairy',
      color: Color(0xFFD685AD),
      icon: Icons.star_rounded,
    ),
  };
}
