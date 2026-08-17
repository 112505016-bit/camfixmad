import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/constants/complaint_constants.dart';
import '../../shared/widgets/status_badge.dart';
import '../../shared/widgets/conduit_timeline.dart';
import '../../shared/widgets/app_button.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final VoidCallback onBack;
  const ComplaintDetailScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    const status = ComplaintStatus.inProgress;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: onBack),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Spacing.lg, 0, Spacing.lg, Spacing.xxxl),
        children: [
          Text('CF-2026-000124', style: AppTypography.complaintId.copyWith(fontSize: 13)),
          const SizedBox(height: 4),
          Text('Water leakage in laboratory', style: AppTypography.h2),
          const SizedBox(height: 10),
          const Row(children: [
            StatusBadge(status: status),
            SizedBox(width: 8),
            PriorityBadge(priority: Priority.high),
          ]),

          const SizedBox(height: Spacing.xl),
          _SectionCard(
            title: 'Complaint information',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'There is continuous water leakage under the sink in Lab 2. '
                  'Floor is getting slippery and equipment nearby is at risk.',
                  style: AppTypography.body(13.5, height: 1.55),
                ),
                const SizedBox(height: Spacing.lg),
                _infoRow(Icons.category_outlined, 'Category', 'Plumbing'),
                _infoRow(Icons.apartment_outlined, 'Department', 'Computer Applications'),
                _infoRow(Icons.place_outlined, 'Location', 'Block C · Laboratory 2'),
                _infoRow(Icons.event_outlined, 'Reported', 'Aug 15, 2026 · 9:40 AM'),
                _infoRow(Icons.person_outline, 'Reported by', 'Ananya Rao'),
              ],
            ),
          ),

          const SizedBox(height: Spacing.lg),
          _SectionCard(
            title: 'Attachments',
            child: SizedBox(
              height: 76,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => Container(
                  width: 76,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(Radii.sm),
                  ),
                  child: const Icon(Icons.image_outlined, color: AppColors.textTertiary),
                ),
              ),
            ),
          ),

          const SizedBox(height: Spacing.lg),
          _SectionCard(
            title: 'Assignment',
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primaryLight,
                  child: Icon(Icons.plumbing_outlined, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ramesh Kumar', style: AppTypography.body(14, weight: FontWeight.w700)),
                      Text('Plumber · Campus Maintenance', style: AppTypography.bodySm),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(Radii.sm)),
                  child: const Icon(Icons.call_outlined, size: 18, color: AppColors.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: Spacing.lg),
          _SectionCard(
            title: 'Timeline',
            child: const ConduitTimeline(currentStatus: status),
          ),

          const SizedBox(height: Spacing.lg),
          _SectionCard(
            title: 'Comments',
            child: Column(
              children: [
                _CommentBubble(name: 'Ananya Rao', message: 'Water leakage is increasing.', isMe: true, time: '9:41 AM'),
                const SizedBox(height: 10),
                _CommentBubble(name: 'Ramesh Kumar', message: 'I have reached the location.', isMe: false, time: '11:02 AM'),
                const SizedBox(height: 10),
                _CommentBubble(name: 'Ramesh Kumar', message: 'Pipe replacement in progress.', isMe: false, time: '11:20 AM'),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add a comment…',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(Radii.pill)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white, size: 18),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: Spacing.xl),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Verify resolution',
                  icon: Icons.fact_check_outlined,
                  variant: AppButtonVariant.secondary,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  label: 'Reopen',
                  icon: Icons.replay_outlined,
                  variant: AppButtonVariant.danger,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Text(label, style: AppTypography.bodySm),
          const Spacer(),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.right,
                style: AppTypography.body(13, weight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.label),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _CommentBubble extends StatelessWidget {
  final String name, message, time;
  final bool isMe;
  const _CommentBubble({required this.name, required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.primary : AppColors.surfaceAlt,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(Radii.md),
                    topRight: const Radius.circular(Radii.md),
                    bottomLeft: Radius.circular(isMe ? Radii.md : 2),
                    bottomRight: Radius.circular(isMe ? 2 : Radii.md),
                  ),
                ),
                child: Text(message,
                    style: AppTypography.body(13, color: isMe ? Colors.white : AppColors.textPrimary)),
              ),
              const SizedBox(height: 3),
              Text('$name · $time', style: AppTypography.caption),
            ],
          ),
        ),
      ],
    );
  }
}
