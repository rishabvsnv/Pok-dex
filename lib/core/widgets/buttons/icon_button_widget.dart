import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class IconButtonWidget extends StatefulWidget {
  final IconData icon;

  final VoidCallback? onTap;

  final double size;
  final double iconSize;

  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;

  final bool outlined;
  final bool enableShadow;
  final bool enableAnimation;

  final EdgeInsetsGeometry? margin;
  final String? tooltip;

  const IconButtonWidget({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 48,
    this.iconSize = 22,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.outlined = false,
    this.enableShadow = false,
    this.enableAnimation = true,
    this.margin,
    this.tooltip,
  });

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scaleAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      lowerBound: 0.92,
      upperBound: 1,
      value: 1,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  Future<void> _handleTap() async {
    if (widget.onTap == null) return;

    if (widget.enableAnimation) {
      setState(() {
        _isPressed = true;
      });

      await _controller.reverse();
      await _controller.forward();

      setState(() {
        _isPressed = false;
      });
    }

    widget.onTap?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
        widget.backgroundColor ??
        (widget.outlined ? Colors.transparent : AppColors.primary);

    final iconColor =
        widget.iconColor ??
        (widget.outlined ? AppColors.primary : Colors.white);

    final borderColor =
        widget.borderColor ??
        (widget.outlined ? AppColors.primary : Colors.transparent);

    final child = ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        margin: widget.margin,
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: widget.outlined ? 1.6 : 1,
          ),
          boxShadow: [
            if (widget.enableShadow)
              BoxShadow(
                color: bgColor.withValues(alpha: 0.22),
                blurRadius: _isPressed ? 8 : 14,
                offset: Offset(0, _isPressed ? 3 : 6),
              ),
          ],
        ),
        child: Icon(widget.icon, color: iconColor, size: widget.iconSize),
      ),
    );

    return Tooltip(
      message: widget.tooltip ?? '',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.size),
          onTap: _handleTap,
          child: child,
        ),
      ),
    );
  }
}
