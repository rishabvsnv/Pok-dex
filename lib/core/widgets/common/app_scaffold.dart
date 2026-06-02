import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/widgets/common/app_loader.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;

  final bool isLoading;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool safeArea;
  final bool dismissKeyboardOnTap;

  final String? loadingMessage;

  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.isLoading = false,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.safeArea = true,
    this.dismissKeyboardOnTap = true,
    this.loadingMessage,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    Widget content = body;

    // Apply padding
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // Apply SafeArea
    if (safeArea) {
      content = SafeArea(child: content);
    }

    // Dismiss keyboard
    if (dismissKeyboardOnTap) {
      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: content,
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,

        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,

        appBar: appBar,

        drawer: drawer,
        endDrawer: endDrawer,

        floatingActionButton: floatingActionButton,

        bottomNavigationBar: bottomNavigationBar,

        bottomSheet: bottomSheet,

        body: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -80,
              right: -80,
              child: _PokeballBackground(
                size: 220,
                opacity: brightness == Brightness.dark ? 0.03 : 0.05,
              ),
            ),

            Positioned(
              bottom: -60,
              left: -60,
              child: _PokeballBackground(
                size: 160,
                opacity: brightness == Brightness.dark ? 0.025 : 0.04,
              ),
            ),

            content,

            // Loading overlay
            if (isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.18),
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: AppLoader(
                    fullscreen: false,
                    message: loadingMessage,
                    size: 90,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PokeballBackground extends StatelessWidget {
  final double size;
  final double opacity;

  const _PokeballBackground({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 8),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(height: 8, color: AppColors.primary),

              Container(
                width: size * 0.22,
                height: size * 0.22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
