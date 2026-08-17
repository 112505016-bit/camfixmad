import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/complaint_constants.dart';

/// CampFix's signature UI element.
///
/// The complaint lifecycle is drawn as a single conduit — a physical
/// line, like the pipes and cable runs the app's users repair — with
/// junction nodes at each status. Completed sections of the conduit
/// fill solid; the active node pulses softly like a live line; future
/// sections stay a flat dashed outline. This ties the app's core
/// metaphor (infrastructure) directly to its most-used piece of UI.
class ConduitTimeline extends StatelessWidget {
  final List<String> steps;
  final String currentStatus;
  final Axis direction;

  const ConduitTimeline({
    super.key,
    required this.currentStatus,
    this.steps = ComplaintStatus.mainFlow,
    this.direction = Axis.vertical,
  });

  int get _currentIndex {
    final i = steps.indexOf(currentStatus);
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return _buildHorizontal();
    }
    return _buildVertical();
  }

  Widget _buildVertical() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (i) {
        final done = i < _currentIndex;
        final active = i == _currentIndex;
        final isLast = i == steps.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _Node(done: done, active: active, icon: ComplaintStatus.icon(steps[i])),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2.5,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        color: done
                            ? AppColors.nodeDone
                            : AppColors.nodePending.withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22, top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ComplaintStatus.label(steps[i]),
                        style: AppTypography.body(
                          14,
                          weight: active ? FontWeight.w700 : FontWeight.w600,
                          color: done || active
                              ? AppColors.textPrimary
                              : AppColors.textTertiary,
                        ),
                      ),
                      if (active)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text('In progress now',
                              style: AppTypography.caption
                                  .copyWith(color: AppColors.accent)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHorizontal() {
    return Row(
      children: List.generate(steps.length, (i) {
        final done = i < _currentIndex;
        final active = i == _currentIndex;
        final isLast = i == steps.length - 1;
        return Expanded(
          flex: isLast ? 0 : 1,
          child: Row(
            children: [
              _Node(done: done, active: active, icon: ComplaintStatus.icon(steps[i]), small: true),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2.5,
                    color: done
                        ? AppColors.nodeDone
                        : AppColors.nodePending.withValues(alpha: 0.6),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _Node extends StatelessWidget {
  final bool done;
  final bool active;
  final IconData icon;
  final bool small;
  const _Node({
    required this.done,
    required this.active,
    required this.icon,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = small ? 22.0 : 30.0;
    Color bg;
    Color fg;
    Color ring;
    if (done) {
      bg = AppColors.nodeDone;
      fg = Colors.white;
      ring = AppColors.nodeDone;
    } else if (active) {
      bg = AppColors.nodeActive.withValues(alpha: 0.16);
      fg = AppColors.nodeActive;
      ring = AppColors.nodeActive;
    } else {
      bg = Colors.transparent;
      fg = AppColors.textTertiary;
      ring = AppColors.nodePending;
    }
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: active ? 2 : 1.5),
      ),
      child: done
          ? Icon(Icons.check, size: small ? 12 : 15, color: fg)
          : Icon(icon, size: small ? 12 : 15, color: fg),
    );
  }
}
