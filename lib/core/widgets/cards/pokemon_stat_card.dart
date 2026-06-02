import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class PokemonStatCard extends StatelessWidget {
  final String statName;
  final int value;

  final int maxValue;

  final Color? color;
  final IconData? icon;

  const PokemonStatCard({
    super.key,
    required this.statName,
    required this.value,
    this.maxValue = 255,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final statColor = color ?? _getStatColor();

    final progress = (value / maxValue).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: statColor.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section
          Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: statColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon ?? _getStatIcon(), color: statColor, size: 24),
              ),

              const SizedBox(width: 14),

              // Title & Value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatStatName(statName),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      value.toString(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: statColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Rating Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  _getRatingLabel(value),
                  style: TextStyle(
                    color: statColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: statColor.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(statColor),
            ),
          ),

          const SizedBox(height: 12),

          // Footer info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Base Stat',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                '$value / $maxValue',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatColor() {
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

  String _getRatingLabel(int value) {
    if (value >= 120) return 'Elite';
    if (value >= 90) return 'Strong';
    if (value >= 60) return 'Average';
    return 'Low';
  }

  String _formatStatName(String stat) {
    switch (stat.toLowerCase()) {
      case 'hp':
        return 'HP';

      case 'attack':
        return 'Attack';

      case 'defense':
        return 'Defense';

      case 'special-attack':
        return 'Sp. Attack';

      case 'special-defense':
        return 'Sp. Defense';

      case 'speed':
        return 'Speed';

      default:
        return stat
            .replaceAll('-', ' ')
            .split(' ')
            .map((e) => e[0].toUpperCase() + e.substring(1))
            .join(' ');
    }
  }

  IconData _getStatIcon() {
    switch (statName.toLowerCase()) {
      case 'hp':
        return Icons.favorite_rounded;

      case 'attack':
        return Icons.flash_on_rounded;

      case 'defense':
        return Icons.shield_rounded;

      case 'special-attack':
        return Icons.bolt_rounded;

      case 'special-defense':
        return Icons.security_rounded;

      case 'speed':
        return Icons.speed_rounded;

      default:
        return Icons.bar_chart_rounded;
    }
  }
}
