import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? description;
  final String? buttonText;

  final IconData? icon;
  final Widget? illustration;

  final VoidCallback? onButtonPressed;

  final double size;
  final EdgeInsetsGeometry? padding;

  const EmptyState({
    super.key,
    required this.title,
    this.description,
    this.buttonText,
    this.icon,
    this.illustration,
    this.onButtonPressed,
    this.size = 180,
    this.padding,
  });

  // Pokémon Not Found State
  factory EmptyState.noPokemon({VoidCallback? onRetry}) {
    return EmptyState(
      title: 'No Pokémon Found',
      description:
          'Looks like this Pokémon is hiding.\nTry searching with another name.',
      buttonText: 'Try Again',
      icon: Icons.search_off_rounded,
      onButtonPressed: onRetry,
    );
  }

  // Favorites Empty State
  factory EmptyState.noFavorites({VoidCallback? onExplore}) {
    return EmptyState(
      title: 'No Favorites Yet',
      description:
          'Your favorite Pokémon will appear here.\nStart building your team.',
      buttonText: 'Explore Pokémon',
      icon: Icons.favorite_border_rounded,
      onButtonPressed: onExplore,
    );
  }

  // Generic Network State
  factory EmptyState.network({VoidCallback? onRetry}) {
    return EmptyState(
      title: 'Connection Lost',
      description:
          'Unable to connect to the Pokédex server.\nCheck your internet and retry.',
      buttonText: 'Retry',
      icon: Icons.wifi_off_rounded,
      onButtonPressed: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration
            illustration ??
                _PokeballIllustration(
                  icon: icon ?? Icons.catching_pokemon_rounded,
                  size: size,
                ),

            const SizedBox(height: 30),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),

            if (description != null) ...[
              const SizedBox(height: 14),

              // Description
              Text(
                description!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ],

            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 30),

              // Action button
              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: onButtonPressed,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(buttonText!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PokeballIllustration extends StatelessWidget {
  final IconData icon;
  final double size;

  const _PokeballIllustration({required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow background
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.14),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Pokéball
        Container(
          width: size * 0.72,
          height: size * 0.72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.pokeballBlack, width: 5),
          ),
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Top red half
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: size * 0.36,
                    color: AppColors.pokeballRed,
                  ),
                ),

                // Bottom white half
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size * 0.36,
                    color: AppColors.pokeballWhite,
                  ),
                ),

                // Middle line
                Container(height: 6, color: AppColors.pokeballBlack),

                // Center button
                Container(
                  width: size * 0.18,
                  height: size * 0.18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.pokeballBlack,
                      width: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Foreground icon
        Container(
          width: size * 0.32,
          height: size * 0.32,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.12),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, size: size * 0.16, color: AppColors.primary),
        ),
      ],
    );
  }
}
