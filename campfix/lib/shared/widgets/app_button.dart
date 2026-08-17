import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool expand;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || loading;

    Color bg;
    Color fg;
    BoxBorder? border;
    switch (variant) {
      case AppButtonVariant.primary:
        bg = disabled ? AppColors.borderStrong : AppColors.primary;
        fg = Colors.white;
        border = null;
        break;
      case AppButtonVariant.secondary:
        bg = AppColors.surfaceAlt;
        fg = AppColors.primary;
        border = Border.all(color: AppColors.border);
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = AppColors.primary;
        border = null;
        break;
      case AppButtonVariant.danger:
        bg = disabled ? AppColors.borderStrong : AppColors.error;
        fg = Colors.white;
        border = null;
        break;
    }

    final child = loading
        ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2.2, color: fg),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: fg),
                const SizedBox(width: 8),
              ],
              Text(label, style: AppTypography.button.copyWith(color: fg)),
            ],
          );

    return SizedBox(
      width: expand ? double.infinity : null,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.md),
          onTap: disabled ? null : onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.md),
              border: border,
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
