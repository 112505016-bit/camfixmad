import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(Spacing.lg),
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.primaryLight,
                      child: Text('AR', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.edit, size: 14, color: AppColors.primaryDark),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text('Ananya Rao', style: AppTypography.h3),
                const SizedBox(height: 2),
                Text('Student · Computer Applications', style: AppTypography.bodySm),
              ],
            ),
          ),
          const SizedBox(height: Spacing.xl),
          _infoCard([
            _row(Icons.mail_outline, 'Email', 'ananya.rao@campus.edu'),
            _row(Icons.phone_outlined, 'Phone', '+91 98765 43210'),
            _row(Icons.badge_outlined, 'Student ID', 'CS2023-0142'),
          ]),
          const SizedBox(height: Spacing.lg),
          _actionTile(Icons.person_outline, 'Edit profile', () {}),
          _actionTile(Icons.lock_outline, 'Change password', () {}),
          _actionTile(Icons.notifications_outlined, 'Notification settings', () {}),
          _actionTile(Icons.dark_mode_outlined, 'Theme', () {}),
          const SizedBox(height: Spacing.lg),
          _actionTile(Icons.logout, 'Log out', () {}, danger: true),
        ],
      ),
    );
  }

  Widget _infoCard(List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(children: rows),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 17, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Text(label, style: AppTypography.bodySm),
          const Spacer(),
          Text(value, style: AppTypography.body(13, weight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String label, VoidCallback onTap, {bool danger = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(Radii.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.md),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Row(
              children: [
                Icon(icon, size: 19, color: danger ? AppColors.error : AppColors.textSecondary),
                const SizedBox(width: 12),
                Text(label,
                    style: AppTypography.body(14,
                        weight: FontWeight.w600,
                        color: danger ? AppColors.error : AppColors.textPrimary)),
                const Spacer(),
                if (!danger) const Icon(Icons.chevron_right, size: 18, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
