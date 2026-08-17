import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import 'status_badge.dart';

class ComplaintCard extends StatelessWidget {
  final String complaintNumber;
  final String title;
  final String category;
  final IconData categoryIcon;
  final String status;
  final String priority;
  final String location;
  final String date;
  final bool overdue;
  final VoidCallback? onTap;

  const ComplaintCard({
    super.key,
    required this.complaintNumber,
    required this.title,
    required this.category,
    required this.categoryIcon,
    required this.status,
    required this.priority,
    required this.location,
    required this.date,
    this.overdue = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(Radii.sm),
                    ),
                    child: Icon(categoryIcon, size: 20, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(complaintNumber, style: AppTypography.complaintId.copyWith(fontSize: 11.5)),
                        const SizedBox(height: 2),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.body(14.5, weight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  PriorityBadge(priority: priority, dense: true),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  StatusBadge(status: overdue ? 'OVERDUE' : status, dense: true),
                  const SizedBox(width: 8),
                  Icon(Icons.place_outlined, size: 13, color: AppColors.textTertiary),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption),
                  ),
                  Text(date, style: AppTypography.caption),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
