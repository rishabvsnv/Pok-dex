import 'dart:ui';

abstract final class AppColors {
  AppColors._();

  // Pokédex brand colors
  static const Color primary = Color(0xFFEF5350); // Pokédex red
  static const Color secondary = Color(0xFFFFCA28); // Pokémon yellow

  // Dashboard / accents
  static const Color ringColor = Color(0xFF42A5F5); // Pokémon blue accent

  // Backgrounds
  static const Color background = Color(0xFFF2F2F2); // Soft Pokédex background
  static const Color surface = Color(0xFFFFFFFF);

  // Text colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // Status colors
  static const Color success = Color(0xFF66BB6A);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF42A5F5);

  // Borders & dividers
  static const Color border = Color(0xFFE0E0E0);
  static const Color darkBorder = Color(0xFF3A3A3A);
  static const Color divider = Color(0xFFD6D6D6);

  // Disabled states
  static const Color disabled = Color(0xFFB0BEC5);
  static const Color disabledBackground = Color(0xFFECEFF1);

  // Shadows
  static const Color shadow = Color(0x1A000000);

  // Dark theme colors
  static const Color darkSurface = Color(0xFF1B1B1B);
  static const Color darkScaffold = Color(0xFF121212);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkCard = Color(0xFF242424);

  // Pokédex special colors
  static const Color pokeballRed = Color(0xFFEF5350);
  static const Color pokeballWhite = Color(0xFFFFFFFF);
  static const Color pokeballBlack = Color(0xFF1A1A1A);

  // Pokémon type-inspired accents
  static const Color fire = Color(0xFFFF7043);
  static const Color water = Color(0xFF42A5F5);
  static const Color grass = Color(0xFF66BB6A);
  static const Color electric = Color(0xFFFFCA28);
  static const Color psychic = Color(0xFFEC407A);
  static const Color dragon = Color(0xFF7E57C2);
}
