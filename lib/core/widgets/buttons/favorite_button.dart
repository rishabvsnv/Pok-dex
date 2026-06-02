import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;

  final VoidCallback? onTap;
  final ValueChanged<bool>? onChanged;

  final double size;

  final bool filledBackground;
  final bool enableAnimation;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    this.onTap,
    this.onChanged,
    this.size = 48,
    this.filledBackground = true,
    this.enableAnimation = true,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late bool _isFavorite;

  late final AnimationController _controller;

  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _isFavorite = widget.isFavorite;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
      lowerBound: 0.8,
      upperBound: 1.15,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  void _toggleFavorite() async {
    final newValue = !_isFavorite;

    setState(() {
      _isFavorite = newValue;
    });

    widget.onTap?.call();
    widget.onChanged?.call(newValue);

    if (widget.enableAnimation) {
      await _controller.forward();
      await _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isFavorite
        ? AppColors.error.withValues(alpha: 0.14)
        : Colors.white.withValues(alpha: 0.16);

    final iconColor = _isFavorite ? AppColors.error : Colors.white;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _toggleFavorite,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.filledBackground
                ? backgroundColor
                : Colors.transparent,
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            boxShadow: [
              if (_isFavorite)
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
              _isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              key: ValueKey(_isFavorite),
              color: iconColor,
              size: widget.size * 0.52,
            ),
          ),
        ),
      ),
    );
  }
}
