import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/app_button.dart';

class _OnboardPage {
  final IconData icon;
  final String title;
  final String subtitle;
  const _OnboardPage(this.icon, this.title, this.subtitle);
}

const _pages = [
  _OnboardPage(
    Icons.campaign_outlined,
    'Report campus problems',
    'Snap a photo, pick a location, and file a complaint in under a minute — no forms, no front desk.',
  ),
  _OnboardPage(
    Icons.route_outlined,
    'Track every complaint',
    'Follow your issue along a live status line, from the moment it\'s logged to the moment it\'s fixed.',
  ),
  _OnboardPage(
    Icons.emoji_objects_outlined,
    'Build a better campus',
    'Your reports and ratings shape where maintenance teams focus next.',
  ),
];

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onDone;
  const OnboardingScreen({super.key, required this.onDone});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: TextButton(
                  onPressed: widget.onDone,
                  child: const Text('Skip'),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final p = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.xxl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.07),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(p.icon, size: 52, color: AppColors.primary),
                        ),
                        const SizedBox(height: Spacing.xxl),
                        Text(p.title,
                            textAlign: TextAlign.center, style: AppTypography.h2),
                        const SizedBox(height: Spacing.sm),
                        Text(p.subtitle,
                            textAlign: TextAlign.center,
                            style: AppTypography.body(14,
                                color: AppColors.textSecondary, height: 1.5)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                final active = i == _index;
                return AnimatedContainer(
                  duration: Motion.base,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 22 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: active ? AppColors.accent : AppColors.border,
                    borderRadius: BorderRadius.circular(Radii.pill),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(Spacing.xl),
              child: AppButton(
                label: _index == _pages.length - 1 ? 'Get started' : 'Next',
                icon: _index == _pages.length - 1 ? null : Icons.arrow_forward,
                onPressed: () {
                  if (_index == _pages.length - 1) {
                    widget.onDone();
                  } else {
                    _controller.nextPage(
                        duration: Motion.base, curve: Curves.easeOut);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
