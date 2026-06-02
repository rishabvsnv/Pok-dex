import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class AppLoader extends StatefulWidget {
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
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final loader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,

          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow
              Container(
                width: widget.size,
                height: widget.size,

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

              // Rotating Pokeball
              RotationTransition(
                turns: _controller,

                child: Container(
                  width: widget.size * 0.82,
                  height: widget.size * 0.82,

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
                        Align(
                          alignment: Alignment.topCenter,

                          child: Container(
                            height: (widget.size * 0.82) / 2,

                            color: AppColors.pokeballRed,
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,

                          child: Container(
                            height: (widget.size * 0.82) / 2,

                            color: AppColors.pokeballWhite,
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,

                          child: Container(
                            height: 6,
                            color: AppColors.pokeballBlack,
                          ),
                        ),

                        Center(
                          child: Container(
                            width: widget.size * 0.22,

                            height: widget.size * 0.22,

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
                                width: widget.size * 0.07,

                                height: widget.size * 0.07,

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

        Text(
          widget.message ?? 'Loading Pokédex...',

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

    if (!widget.fullscreen) {
      return Center(child: loader);
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(child: Center(child: loader)),
    );
  }
}
