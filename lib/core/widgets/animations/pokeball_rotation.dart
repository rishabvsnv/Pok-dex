import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class PokeballRotation extends StatefulWidget {
  final double size;

  final Duration duration;

  final bool repeat;
  final bool clockwise;

  final Widget? child;

  const PokeballRotation({
    super.key,
    this.size = 120,
    this.duration = const Duration(seconds: 2),
    this.repeat = true,
    this.clockwise = true,
    this.child,
  });

  @override
  State<PokeballRotation> createState() => _PokeballRotationState();
}

class _PokeballRotationState extends State<PokeballRotation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: widget.clockwise ? 1 : -1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    if (widget.repeat) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPokeball() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.pokeballBlack,
          width: widget.size * 0.045,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Top Red Half
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: widget.size / 2,
                color: AppColors.pokeballRed,
              ),
            ),

            // Bottom White Half
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: widget.size / 2,
                color: AppColors.pokeballWhite,
              ),
            ),

            // Middle Divider
            Container(
              height: widget.size * 0.05,
              color: AppColors.pokeballBlack,
            ),

            // Center Circle
            Container(
              width: widget.size * 0.26,
              height: widget.size * 0.26,
              decoration: BoxDecoration(
                color: AppColors.pokeballWhite,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.pokeballBlack,
                  width: widget.size * 0.045,
                ),
              ),
              child: Center(
                child: Container(
                  width: widget.size * 0.08,
                  height: widget.size * 0.08,
                  decoration: const BoxDecoration(
                    color: AppColors.pokeballBlack,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // Optional Child
            if (widget.child != null) widget.child!,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: _buildPokeball(),
    );
  }
}
