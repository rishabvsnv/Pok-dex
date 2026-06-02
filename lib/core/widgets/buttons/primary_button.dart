import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class PrimaryButton extends StatefulWidget {
  final String text;

  final VoidCallback? onPressed;

  final bool isLoading;
  final bool enabled;
  final bool expanded;
  final bool outlined;

  final IconData? icon;

  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  final double elevation;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.expanded = true,
    this.outlined = false,
    this.icon,
    this.height = 56,
    this.borderRadius = 20,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.elevation = 0,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
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
      lowerBound: 0.96,
      upperBound: 1,
      value: 1,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  Future<void> _handleTap() async {
    if (widget.onPressed == null || widget.isLoading || !widget.enabled) {
      return;
    }

    setState(() {
      _isPressed = true;
    });

    await _controller.reverse();
    await _controller.forward();

    setState(() {
      _isPressed = false;
    });

    widget.onPressed?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.enabled
        ? (widget.backgroundColor ??
              (widget.outlined ? Colors.transparent : AppColors.primary))
        : AppColors.disabled;

    final fgColor = widget.enabled
        ? (widget.foregroundColor ??
              (widget.outlined ? AppColors.primary : Colors.white))
        : Colors.white.withValues(alpha: 0.7);

    final borderColor =
        widget.borderColor ??
        (widget.outlined ? AppColors.primary : Colors.transparent);

    final button = ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: widget.expanded ? double.infinity : null,
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          gradient: widget.outlined || !widget.enabled
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [bgColor, bgColor.withValues(alpha: 0.86)],
                ),
          color: widget.outlined || widget.enabled ? null : bgColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: borderColor,
            width: widget.outlined ? 1.6 : 1,
          ),
          boxShadow: [
            if (!widget.outlined && widget.enabled)
              BoxShadow(
                color: bgColor.withValues(alpha: 0.22),
                blurRadius: _isPressed ? 10 : 18,
                offset: Offset(0, _isPressed ? 4 : 8),
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pokéball background
            Positioned(
              right: -14,
              child: Opacity(
                opacity: 0.10,
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.outlined ? AppColors.primary : Colors.white,
                      width: 3,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 3,
                        color: widget.outlined
                            ? AppColors.primary
                            : Colors.white,
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.outlined
                                ? AppColors.primary
                                : Colors.white,
                            width: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Button Content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: widget.isLoading
                  ? SizedBox(
                      key: const ValueKey('loading'),
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.6,
                        valueColor: AlwaysStoppedAnimation(fgColor),
                      ),
                    )
                  : Row(
                      key: const ValueKey('content'),
                      mainAxisSize: widget.expanded
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(widget.icon, color: fgColor, size: 22),
                          ),

                        Flexible(
                          child: Text(
                            widget.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: fgColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        onTap: _handleTap,
        child: button,
      ),
    );
  }
}
