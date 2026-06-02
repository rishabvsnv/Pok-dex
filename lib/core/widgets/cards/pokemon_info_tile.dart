import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class PokemonInfoTile extends StatelessWidget {
  final String title;
  final String value;

  final IconData? icon;
  final Color? color;

  final bool expanded;

  const PokemonInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.color,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tileColor = color ?? AppColors.primary;

    return Tooltip(
      message: '$title\n$value',
      // message: value,
      triggerMode: TooltipTriggerMode.longPress,
      waitDuration: const Duration(milliseconds: 300),
      showDuration: const Duration(seconds: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w500,
      ),
      child: Container(
        width: expanded ? double.infinity : null,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            if (icon != null)
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: tileColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: tileColor, size: 26),
              ),

            if (icon != null) const SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Value
                  Text(
                    value,
                    maxLines: expanded ? null : 2,
                    overflow: expanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
