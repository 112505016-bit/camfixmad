import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/summary_card.dart';
import '../../shared/widgets/complaint_card.dart';
import '../../core/constants/complaint_constants.dart';

class StudentHomeScreen extends StatelessWidget {
  final VoidCallback onCreateComplaint;
  final void Function(int index) onOpenComplaint;
  const StudentHomeScreen({
    super.key,
    required this.onCreateComplaint,
    required this.onOpenComplaint,
  });

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
                          Text('Good morning 👋', style: AppTypography.bodySm),
                          const SizedBox(height: 2),
                          Text('Ananya Rao', style: AppTypography.h3),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        _iconButton(Icons.notifications_outlined, () {}),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: AppColors.error, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryLight,
                      child: Text('AR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Material(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(Radii.xl),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Radii.xl),
                    onTap: onCreateComplaint,
                    child: Container(
                      padding: const EdgeInsets.all(Spacing.xl),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Radii.xl),
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Spotted a problem?',
                                    style: AppTypography.body(13,
                                        color: Colors.white.withValues(alpha: 0.75))),
                                const SizedBox(height: 4),
                                Text('Report an issue',
                                    style: AppTypography.display(19,
                                        weight: FontWeight.w700, color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(Radii.md),
                            ),
                            child: const Icon(Icons.add, color: AppColors.primaryDark),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 108,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                  children: const [
                    SummaryCard(label: 'Total', value: '12', icon: Icons.list_alt_outlined, color: AppColors.primary),
                    SizedBox(width: 10),
                    SummaryCard(label: 'Pending', value: '3', icon: Icons.schedule_outlined, color: AppColors.priorityHigh),
                    SizedBox(width: 10),
                    SummaryCard(label: 'In progress', value: '4', icon: Icons.build_outlined, color: AppColors.accent),
                    SizedBox(width: 10),
                    SummaryCard(label: 'Resolved', value: '5', icon: Icons.task_alt_outlined, color: AppColors.success),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.lg, Spacing.xl, Spacing.lg, Spacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent complaints', style: AppTypography.h4),
                    TextButton(onPressed: () {}, child: const Text('See all')),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              sliver: SliverList.separated(
                itemCount: _demo.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final c = _demo[i];
                  return ComplaintCard(
                    complaintNumber: c['id'] as String,
                    title: c['title'] as String,
                    category: c['category'] as String,
                    categoryIcon: c['icon'] as IconData,
                    status: c['status'] as String,
                    priority: c['priority'] as String,
                    location: c['location'] as String,
                    date: c['date'] as String,
                    overdue: c['overdue'] as bool,
                    onTap: () => onOpenComplaint(i),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: Spacing.xxxl)),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.sm),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onTap,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

final _demo = [
  {
    'id': 'CF-2026-000124',
    'title': 'Water leakage in laboratory',
    'category': 'Plumbing',
    'icon': Icons.plumbing_outlined,
    'status': ComplaintStatus.inProgress,
    'priority': Priority.high,
    'location': 'Block C · Lab 2',
    'date': '2h ago',
    'overdue': false,
  },
  {
    'id': 'CF-2026-000119',
    'title': 'Projector not turning on',
    'category': 'IT / Network',
    'icon': Icons.wifi_outlined,
    'status': ComplaintStatus.assigned,
    'priority': Priority.medium,
    'location': 'Block A · Room 214',
    'date': 'Yesterday',
    'overdue': true,
  },
  {
    'id': 'CF-2026-000108',
    'title': 'Broken chair, hostel common room',
    'category': 'Furniture',
    'icon': Icons.chair_outlined,
    'status': ComplaintStatus.resolved,
    'priority': Priority.low,
    'location': 'Hostel Block 2',
    'date': '3 days ago',
    'overdue': false,
  },
];
