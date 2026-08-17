import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/constants/complaint_constants.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/status_badge.dart';

class CreateComplaintScreen extends StatefulWidget {
  final VoidCallback onSubmitted;
  final VoidCallback onCancel;
  const CreateComplaintScreen({super.key, required this.onSubmitted, required this.onCancel});

  @override
  State<CreateComplaintScreen> createState() => _CreateComplaintScreenState();
}

class _CreateComplaintScreenState extends State<CreateComplaintScreen> {
  int _step = 0;
  static const int totalSteps = 6; // category, details, location, images, priority, review

  String? _category;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String? _location;
  String _priority = Priority.medium;
  int _imageCount = 0;
  bool _submitted = false;
  bool _submitting = false;

  final _locations = const [
    'Block A', 'Block B', 'Block C', 'Main Building', 'Library',
    'Laboratory', 'Hostel', 'Canteen', 'Auditorium', 'Parking',
  ];

  bool get _canProceed {
    switch (_step) {
      case 0:
        return _category != null;
      case 1:
        return _titleController.text.trim().isNotEmpty && _descController.text.trim().isNotEmpty;
      case 2:
        return _location != null;
      default:
        return true;
    }
  }

  void _next() {
    if (_step < totalSteps - 1) {
      setState(() => _step++);
    } else {
      _submit();
    }
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    await Future.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    setState(() {
      _submitting = false;
      _submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) return _SuccessScreen(onDone: widget.onSubmitted);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => _step == 0 ? widget.onCancel() : setState(() => _step--),
        ),
        title: const Text('Report an issue'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Row(
              children: List.generate(totalSteps, (i) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i == totalSteps - 1 ? 0 : 4),
                    decoration: BoxDecoration(
                      color: i <= _step ? AppColors.accent : AppColors.border,
                      borderRadius: BorderRadius.circular(Radii.pill),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: Spacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Step ${_step + 1} of $totalSteps', style: AppTypography.caption),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Spacing.lg),
              child: _buildStep(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: AppButton(
              label: _step == totalSteps - 1 ? 'Submit complaint' : 'Continue',
              loading: _submitting,
              onPressed: _canProceed ? _next : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _CategoryStep(
          selected: _category,
          onSelect: (c) => setState(() => _category = c),
        );
      case 1:
        return _DetailsStep(titleController: _titleController, descController: _descController);
      case 2:
        return _LocationStep(
          locations: _locations,
          selected: _location,
          onSelect: (l) => setState(() => _location = l),
        );
      case 3:
        return _ImagesStep(
          count: _imageCount,
          onAdd: () => setState(() => _imageCount = (_imageCount + 1).clamp(0, 5)),
          onRemove: (i) => setState(() => _imageCount = (_imageCount - 1).clamp(0, 5)),
        );
      case 4:
        return _PriorityStep(
          selected: _priority,
          onSelect: (p) => setState(() => _priority = p),
        );
      default:
        return _ReviewStep(
          category: _category ?? '—',
          title: _titleController.text,
          description: _descController.text,
          location: _location ?? '—',
          priority: _priority,
          imageCount: _imageCount,
        );
    }
  }
}

class _StepHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _StepHeader({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.h3),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTypography.bodySm),
        ],
      ),
    );
  }
}

class _CategoryStep extends StatelessWidget {
  final String? selected;
  final void Function(String) onSelect;
  const _CategoryStep({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeader(title: 'What kind of problem?', subtitle: 'Pick the closest category — this routes it to the right team.'),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ComplaintCategories.all.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.92,
          ),
          itemBuilder: (context, i) {
            final cat = ComplaintCategories.all[i];
            final isSelected = selected == cat['name'];
            return InkWell(
              borderRadius: BorderRadius.circular(Radii.md),
              onTap: () => onSelect(cat['name'] as String),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : AppColors.surface,
                  border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: isSelected ? 1.6 : 1),
                  borderRadius: BorderRadius.circular(Radii.md),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(cat['icon'] as IconData, size: 22, color: isSelected ? AppColors.primary : AppColors.textSecondary),
                    const SizedBox(height: 6),
                    Text(
                      cat['name'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: AppTypography.body(11, weight: FontWeight.w600, color: isSelected ? AppColors.primary : AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DetailsStep extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  const _DetailsStep({required this.titleController, required this.descController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeader(title: 'Describe the problem', subtitle: 'A clear title and a few details help staff resolve it faster.'),
        AppTextField(label: 'Title', hint: 'e.g. Water leakage near sink', controller: titleController),
        const SizedBox(height: Spacing.lg),
        AppTextField(
          label: 'Description',
          hint: 'What\'s wrong, and since when?',
          controller: descController,
          maxLines: 5,
        ),
      ],
    );
  }
}

class _LocationStep extends StatelessWidget {
  final List<String> locations;
  final String? selected;
  final void Function(String) onSelect;
  const _LocationStep({required this.locations, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeader(title: 'Where is it?', subtitle: 'Select the campus location closest to the issue.'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: locations.map((loc) {
            final isSelected = selected == loc;
            return ChoiceChip(
              label: Text(loc),
              selected: isSelected,
              onSelected: (_) => onSelect(loc),
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.surfaceAlt,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
              showCheckmark: false,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ImagesStep extends StatelessWidget {
  final int count;
  final VoidCallback onAdd;
  final void Function(int) onRemove;
  const _ImagesStep({required this.count, required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeader(title: 'Add photos', subtitle: 'Optional, but a photo helps staff prep the right tools. Up to 5.'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...List.generate(count, (i) => Stack(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(Radii.md),
                  ),
                  child: const Icon(Icons.image_outlined, color: AppColors.textTertiary),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: GestureDetector(
                    onTap: () => onRemove(i),
                    child: const CircleAvatar(
                      radius: 11,
                      backgroundColor: AppColors.error,
                      child: Icon(Icons.close, size: 13, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )),
            if (count < 5)
              InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(Radii.md),
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderStrong, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(Radii.md),
                  ),
                  child: const Icon(Icons.add_a_photo_outlined, color: AppColors.textSecondary),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _PriorityStep extends StatelessWidget {
  final String selected;
  final void Function(String) onSelect;
  const _PriorityStep({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeader(title: 'How urgent is it?', subtitle: 'Critical issues are routed to staff immediately.'),
        ...Priority.all.map((p) {
          final isSelected = selected == p;
          final color = AppColors.priorityColor(p);
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(Radii.md),
              onTap: () => onSelect(p),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isSelected ? color.withValues(alpha: 0.08) : AppColors.surface,
                  border: Border.all(color: isSelected ? color : AppColors.border, width: isSelected ? 1.6 : 1),
                  borderRadius: BorderRadius.circular(Radii.md),
                ),
                child: Row(
                  children: [
                    Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(p[0] + p.substring(1).toLowerCase(),
                          style: AppTypography.body(14, weight: FontWeight.w600)),
                    ),
                    if (isSelected) Icon(Icons.check_circle, color: color, size: 20),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _ReviewStep extends StatelessWidget {
  final String category, title, description, location, priority;
  final int imageCount;
  const _ReviewStep({
    required this.category,
    required this.title,
    required this.description,
    required this.location,
    required this.priority,
    required this.imageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeader(title: 'Review & submit', subtitle: 'Double-check the details before sending this to the campus team.'),
        Container(
          padding: const EdgeInsets.all(Spacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(Radii.lg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title.isEmpty ? 'Untitled complaint' : title, style: AppTypography.h4)),
                  PriorityBadge(priority: priority),
                ],
              ),
              const SizedBox(height: 6),
              Text(description.isEmpty ? 'No description provided.' : description, style: AppTypography.bodySm),
              const Divider(height: 28),
              _reviewRow(Icons.category_outlined, 'Category', category),
              const SizedBox(height: 10),
              _reviewRow(Icons.place_outlined, 'Location', location),
              const SizedBox(height: 10),
              _reviewRow(Icons.image_outlined, 'Attachments', '$imageCount photo${imageCount == 1 ? '' : 's'}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reviewRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(label, style: AppTypography.bodySm),
        const Spacer(),
        Text(value, style: AppTypography.body(13, weight: FontWeight.w600)),
      ],
    );
  }
}

class _SuccessScreen extends StatelessWidget {
  final VoidCallback onDone;
  const _SuccessScreen({required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(color: AppColors.successBg, shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, color: AppColors.success, size: 52),
              ),
              const SizedBox(height: Spacing.xl),
              Text('Complaint submitted', style: AppTypography.h2, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text('Your report has been logged and routed to the right team.',
                  style: AppTypography.bodySm, textAlign: TextAlign.center),
              const SizedBox(height: Spacing.xl),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
                child: Text('CF-2026-000124', style: AppTypography.complaintId.copyWith(fontSize: 15)),
              ),
              const SizedBox(height: Spacing.xxxl),
              AppButton(label: 'Done', onPressed: onDone),
            ],
          ),
        ),
      ),
    );
  }
}
