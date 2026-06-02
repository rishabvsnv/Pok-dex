import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    this.isCenterTitle = true,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final canPop = Navigator.canPop(context);

    return AppBar(
      elevation: elevation,
      centerTitle: isCenterTitle,
      automaticallyImplyLeading: false,

      leading:
          leading ??
          (showBackButton && canPop
              ? Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.white.withValues(alpha: 0.18),
                      foregroundColor: Colors.white,
                    ),
                  ),
                )
              : null),

      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.pokeballWhite,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.pokeballBlack, width: 2),
            ),
            child: Center(
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.pokeballBlack,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: theme.appBarTheme.titleTextStyle?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),

      actions: actions != null
          ? [const SizedBox(width: 4), ...actions!, const SizedBox(width: 10)]
          : null,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: theme.brightness == Brightness.dark
                ? [const Color(0xFF2A2A2A), AppColors.pokeballBlack]
                : [AppColors.primary, const Color(0xFFE53935)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(14),
        child: Container(
          height: 14,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 64,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 14);
}
