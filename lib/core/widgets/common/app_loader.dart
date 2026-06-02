import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  final String? message;
  final double size;
  final bool fullscreen;

  const AppLoader({
    super.key,
    this.message,
    this.size = 110,
    this.fullscreen = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final loader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pokéball Loader
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),

              // Rotating Pokéball
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                curve: Curves.linear,
                builder: (context, value, child) {
                  return Transform.rotate(angle: value * 6.3, child: child);
                },
                onEnd: () {},
                child: Container(
                  width: size * 0.82,
                  height: size * 0.82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.pokeballBlack,
                      width: 4,
                    ),
                  ),
                  child: ClipOval(
                    child: Stack(
                      children: [
                        // Top red half
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: (size * 0.82) / 2,
                            color: AppColors.pokeballRed,
                          ),
                        ),

                        // Bottom white half
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: (size * 0.82) / 2,
                            color: AppColors.pokeballWhite,
                          ),
                        ),

                        // Middle black line
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 6,
                            color: AppColors.pokeballBlack,
                          ),
                        ),

                        // Center circle
                        Center(
                          child: Container(
                            width: size * 0.22,
                            height: size * 0.22,
                            decoration: BoxDecoration(
                              color: AppColors.pokeballWhite,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.pokeballBlack,
                                width: 5,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: size * 0.07,
                                height: size * 0.07,
                                decoration: const BoxDecoration(
                                  color: AppColors.pokeballBlack,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Loading text
        Text(
          message ?? 'Loading Pokédex...',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Catching Pokémon data...',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );

    if (!fullscreen) {
      return Center(child: loader);
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(child: Center(child: loader)),
    );
  }
}
