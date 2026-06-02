import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color success;

  final Color warning;

  final Color info;

  final Color cardShadow;

  final Color border;

  const AppThemeExtension({
    required this.success,
    required this.warning,
    required this.info,
    required this.cardShadow,
    required this.border,
  });

  @override
  AppThemeExtension copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? cardShadow,
    Color? border,
  }) {
    return AppThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      cardShadow: cardShadow ?? this.cardShadow,
      border: border ?? this.border,
    );
  }

  @override
  AppThemeExtension lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }

  static const light = AppThemeExtension(
    success: AppColors.success,
    warning: AppColors.warning,
    info: AppColors.info,
    cardShadow: AppColors.shadow,
    border: AppColors.border,
  );

  static const dark = AppThemeExtension(
    success: AppColors.success,
    warning: AppColors.warning,
    info: AppColors.info,
    cardShadow: Color(0x33000000),
    border: AppColors.darkBorder,
  );
}
