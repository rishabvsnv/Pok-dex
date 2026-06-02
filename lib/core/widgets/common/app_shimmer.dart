import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class AppShimmer extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;

  const AppShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
  });

  // Pokémon Card Shimmer
  factory AppShimmer.pokemonCard() {
    return const AppShimmer(
      height: 220,
      borderRadius: BorderRadius.all(Radius.circular(28)),
    );
  }

  // List Tile Shimmer
  factory AppShimmer.listTile() {
    return const AppShimmer(
      height: 80,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }

  // Image Shimmer
  factory AppShimmer.image({double? width, double? height}) {
    return AppShimmer(
      width: width,
      height: height ?? 180,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
    );
  }

  // Text Shimmer
  factory AppShimmer.text({double? width, double height = 16}) {
    return AppShimmer(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(100),
    );
  }

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
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
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.grey.shade300;

    final highlightColor = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : Colors.grey.shade100;

    return Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment(-1 + (_controller.value * 2), 0),
                end: Alignment(1 + (_controller.value * 2), 0),
                colors: [baseColor, highlightColor, baseColor],
                stops: const [0.25, 0.5, 0.75],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
          ),

          // Pokéball background decoration
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Opacity(
                  opacity: 0.08,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 5),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(height: 5, color: AppColors.primary),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 5,
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
      ),
    );
  }
}
