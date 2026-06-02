import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;

  final VoidCallback onTap;

  final double size;

  final bool filledBackground;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
    this.size = 48,
    this.filledBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isFavorite
        ? AppColors.error.withValues(alpha: 0.14)
        : Colors.white.withValues(alpha: 0.16);

    final iconColor = isFavorite ? AppColors.error : Colors.white;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1),

      duration: const Duration(milliseconds: 220),

      curve: Curves.elasticOut,

      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },

      child: GestureDetector(
        onTap: onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),

          curve: Curves.easeOut,

          width: size,
          height: size,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: filledBackground ? backgroundColor : Colors.transparent,

            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),

            boxShadow: [
              if (isFavorite)
                BoxShadow(
                  color: AppColors.error.withValues(alpha: 0.22),

                  blurRadius: 16,

                  offset: const Offset(0, 6),
                ),
            ],
          ),

          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),

            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,

                child: FadeTransition(opacity: animation, child: child),
              );
            },

            child: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,

              key: ValueKey(isFavorite),

              color: iconColor,

              size: size * 0.52,
            ),
          ),
        ),
      ),
    );
  }
}
