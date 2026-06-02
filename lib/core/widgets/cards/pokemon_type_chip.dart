import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;

  final double fontSize;
  final EdgeInsetsGeometry? padding;

  final bool outlined;
  final bool compact;

  const PokemonTypeChip({
    super.key,
    required this.type,
    this.fontSize = 13,
    this.padding,
    this.outlined = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor(type);

    return Container(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: compact ? 10 : 14,
            vertical: compact ? 6 : 8,
          ),
      decoration: BoxDecoration(
        gradient: outlined
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withValues(alpha: 0.82)],
              ),
        color: outlined ? color.withValues(alpha: 0.08) : null,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: outlined ? color : Colors.white.withValues(alpha: 0.12),
          width: outlined ? 1.6 : 1,
        ),
        boxShadow: outlined
            ? null
            : [
                BoxShadow(
                  color: color.withValues(alpha: 0.22),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Type icon
          Container(
            width: compact ? 18 : 22,
            height: compact ? 18 : 22,
            decoration: BoxDecoration(
              color: outlined
                  ? color.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTypeIcon(type),
              size: compact ? 11 : 14,
              color: outlined ? color : Colors.white,
            ),
          ),

          SizedBox(width: compact ? 6 : 8),

          // Type text
          Text(
            _capitalize(type),
            style: TextStyle(
              color: outlined ? color : Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: fontSize,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFFA8A77A);

      case 'fire':
        return const Color(0xFFEE8130);

      case 'water':
        return const Color(0xFF6390F0);

      case 'electric':
        return const Color(0xFFF7D02C);

      case 'grass':
        return const Color(0xFF7AC74C);

      case 'ice':
        return const Color(0xFF96D9D6);

      case 'fighting':
        return const Color(0xFFC22E28);

      case 'poison':
        return const Color(0xFFA33EA1);

      case 'ground':
        return const Color(0xFFE2BF65);

      case 'flying':
        return const Color(0xFFA98FF3);

      case 'psychic':
        return const Color(0xFFF95587);

      case 'bug':
        return const Color(0xFFA6B91A);

      case 'rock':
        return const Color(0xFFB6A136);

      case 'ghost':
        return const Color(0xFF735797);

      case 'dragon':
        return const Color(0xFF6F35FC);

      case 'dark':
        return const Color(0xFF705746);

      case 'steel':
        return const Color(0xFFB7B7CE);

      case 'fairy':
        return const Color(0xFFD685AD);

      default:
        return AppColors.primary;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Icons.local_fire_department_rounded;

      case 'water':
        return Icons.water_drop_rounded;

      case 'grass':
        return Icons.eco_rounded;

      case 'electric':
        return Icons.flash_on_rounded;

      case 'ice':
        return Icons.ac_unit_rounded;

      case 'fighting':
        return Icons.sports_mma_rounded;

      case 'poison':
        return Icons.science_rounded;

      case 'ground':
        return Icons.landscape_rounded;

      case 'flying':
        return Icons.air_rounded;

      case 'psychic':
        return Icons.auto_awesome_rounded;

      case 'bug':
        return Icons.pest_control_rounded;

      case 'rock':
        return Icons.terrain_rounded;

      case 'ghost':
        return Icons.nightlight_round_rounded;

      case 'dragon':
        return Icons.whatshot_rounded;

      case 'dark':
        return Icons.dark_mode_rounded;

      case 'steel':
        return Icons.hardware_rounded;

      case 'fairy':
        return Icons.star_rounded;

      case 'normal':
        return Icons.adjust_rounded;

      default:
        return Icons.catching_pokemon_rounded;
    }
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
