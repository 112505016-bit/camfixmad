import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/constants/complaint_constants.dart';
import '../../shared/widgets/summary_card.dart';
import '../../shared/widgets/status_badge.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.lg, Spacing.md, Spacing.lg, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Good morning, Ramesh', style: AppTypography.h3),
                          const SizedBox(height: 2),
                          Row(children: [
                            Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                            const SizedBox(width: 5),
                            Text('Available', style: AppTypography.bodySm),
                          ]),
                        ],
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 108,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.lg, vertical: Spacing.md),
                  children: const [
                    SummaryCard(label: 'Assigned', value: '6', icon: Icons.assignment_outlined, color: AppColors.primary),
                    SizedBox(width: 10),
                    SummaryCard(label: 'In progress', value: '2', icon: Icons.build_outlined, color: AppColors.accent),
                    SizedBox(width: 10),
                    SummaryCard(label: 'Completed', value: '18', icon: Icons.task_alt_outlined, color: AppColors.success),
                    SizedBox(width: 10),
                    SummaryCard(label: 'Overdue', value: '1', icon: Icons.warning_amber_outlined, color: AppColors.error),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.lg, Spacing.md, Spacing.lg, Spacing.sm),
                child: Row(children: [
                  const Icon(Icons.priority_high, size: 16, color: AppColors.error),
                  const SizedBox(width: 6),
                  Text('Urgent tasks', style: AppTypography.h4),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              sliver: SliverList.separated(
                itemCount: 1,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, __) => const _TaskCard(
                  id: 'CF-2026-000119',
                  title: 'Projector not turning on',
                  location: 'Block A · Room 214',
                  priority: Priority.high,
                  status: ComplaintStatus.assigned,
                  overdue: true,
                  actionLabel: 'Accept task',
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.lg, Spacing.xl, Spacing.lg, Spacing.sm),
                child: Text("Today's tasks", style: AppTypography.h4),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              sliver: SliverList.separated(
                itemCount: 2,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final items = [
                    const _TaskCard(
                      id: 'CF-2026-000124',
                      title: 'Water leakage in laboratory',
                      location: 'Block C · Lab 2',
                      priority: Priority.high,
                      status: ComplaintStatus.inProgress,
                      overdue: false,
                      actionLabel: 'Mark resolved',
                    ),
                    const _TaskCard(
                      id: 'CF-2026-000131',
                      title: 'AC not cooling',
                      location: 'Block B · Room 108',
                      priority: Priority.medium,
                      status: ComplaintStatus.accepted,
                      overdue: false,
                      actionLabel: 'Start work',
                    ),
                  ];
                  return items[i];
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: Spacing.xxxl)),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String id, title, location, priority, status, actionLabel;
  final bool overdue;
  const _TaskCard({
    required this.id,
    required this.title,
    required this.location,
    required this.priority,
    required this.status,
    required this.overdue,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: overdue ? AppColors.error.withValues(alpha: 0.4) : AppColors.border),
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(id, style: AppTypography.complaintId.copyWith(fontSize: 11)),
                    const SizedBox(height: 2),
                    Text(title, style: AppTypography.body(14, weight: FontWeight.w700)),
                  ],
                ),
              ),
              PriorityBadge(priority: priority, dense: true),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.place_outlined, size: 13, color: AppColors.textTertiary),
            const SizedBox(width: 2),
            Text(location, style: AppTypography.caption),
            const Spacer(),
            StatusBadge(status: overdue ? 'OVERDUE' : status, dense: true),
          ]),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(onPressed: () {}, child: Text(actionLabel)),
          ),
        ],
      ),
    );
  }
}
