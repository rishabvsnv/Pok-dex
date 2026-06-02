import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/theme/app_colors.dart';

class AppAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final double elevation;

  const AppAppbar({
    super.key,
    required this.title,
    this.isCenterTitle = false,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final canPop = context.canPop();

    return AppBar(
      elevation: 0,

      toolbarHeight: 78,

      automaticallyImplyLeading: false,

      centerTitle: isCenterTitle,

      backgroundColor: Colors.transparent,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: isDark
                ? [const Color(0xFF1A1A1A), const Color(0xFF111111)]
                : [const Color(0xFFFF5A5F), const Color(0xFFE53935)],
          ),

          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),

            bottomRight: Radius.circular(32),
          ),

          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : AppColors.primary).withValues(
                alpha: 0.24,
              ),

              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),

            bottomRight: Radius.circular(32),
          ),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),

            child: Container(
              color: Colors.white.withValues(alpha: isDark ? 0.02 : 0.04),
            ),
          ),
        ),
      ),

      leading:
          leading ??
          (showBackButton && canPop
              ? Padding(
                  padding: const EdgeInsets.only(left: 14, top: 10, bottom: 10),

                  child: _PremiumIconButton(
                    icon: Icons.arrow_back_rounded,

                    onTap: () {
                      context.pop();
                    },
                  ),
                )
              : null),

      titleSpacing: 20,

      title: Padding(
        padding: const EdgeInsets.only(top: 6),

        child: Row(
          children: [
            // Premium Pokeball
            Container(
              width: 24,
              height: 24,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),

                    blurRadius: 10,
                  ),
                ],
              ),

              child: ClipOval(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,

                      child: Container(
                        height: 12,
                        color: AppColors.pokeballRed,
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,

                      child: Container(
                        height: 12,
                        color: AppColors.pokeballWhite,
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,

                      child: Container(
                        height: 3,
                        color: AppColors.pokeballBlack,
                      ),
                    ),

                    Center(
                      child: Container(
                        width: 10,
                        height: 10,

                        decoration: BoxDecoration(
                          color: AppColors.pokeballWhite,

                          shape: BoxShape.circle,

                          border: Border.all(
                            color: AppColors.pokeballBlack,

                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,

                overflow: TextOverflow.ellipsis,

                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,

                  fontWeight: FontWeight.w900,

                  letterSpacing: -0.4,
                ),
              ),
            ),
          ],
        ),
      ),

      actions: actions != null
          ? [
              Padding(
                padding: const EdgeInsets.only(top: 6),

                child: Row(children: [...actions!, const SizedBox(width: 12)]),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(78);
}

class _PremiumIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _PremiumIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.12),

      shape: const CircleBorder(),

      child: InkWell(
        customBorder: const CircleBorder(),

        onTap: onTap,

        child: SizedBox(
          width: 48,
          height: 48,

          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
