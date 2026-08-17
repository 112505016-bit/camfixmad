import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Type system.
///
/// Display face: Space Grotesk — geometric/technical, used sparingly for
/// headings and the complaint-number treatment (echoes a blueprint label).
/// Body face: Inter — neutral, highly legible at small mobile sizes.
/// Utility/mono face: JetBrains Mono — reserved ONLY for complaint IDs,
/// timestamps in the timeline, and data in admin tables, so monospace
/// reads as "this is a machine-generated reference", not decoration.
class AppTypography {
  AppTypography._();

  static TextStyle get _displayBase => GoogleFonts.spaceGrotesk();
  static TextStyle get _bodyBase => GoogleFonts.inter();
  static TextStyle get _monoBase => GoogleFonts.jetBrainsMono();

  static TextStyle display(
    double size, {
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) =>
      _displayBase.copyWith(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing ?? -0.3,
      );

  static TextStyle body(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
  }) =>
      _bodyBase.copyWith(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height ?? 1.4,
      );

  static TextStyle mono(
    double size, {
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.textPrimary,
    double? letterSpacing,
  }) =>
      _monoBase.copyWith(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing ?? 0.4,
      );

  // ---- Named scale ----
  static TextStyle get h1 => display(30, weight: FontWeight.w700);
  static TextStyle get h2 => display(24, weight: FontWeight.w700);
  static TextStyle get h3 => display(20, weight: FontWeight.w600);
  static TextStyle get h4 => display(17, weight: FontWeight.w600);

  static TextStyle get bodyLg => body(16);
  static TextStyle get bodyMd => body(14);
  static TextStyle get bodySm => body(12.5, color: AppColors.textSecondary);

  static TextStyle get label =>
      body(12, weight: FontWeight.w600, color: AppColors.textSecondary)
          .copyWith(letterSpacing: 0.6);

  static TextStyle get button =>
      body(15, weight: FontWeight.w600, color: AppColors.textOnPrimary);

  static TextStyle get complaintId =>
      mono(13, weight: FontWeight.w600, color: AppColors.primary);

  static TextStyle get caption => body(11.5, color: AppColors.textTertiary);
}
