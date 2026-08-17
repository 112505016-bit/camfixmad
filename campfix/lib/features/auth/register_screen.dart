import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegistered;
  final VoidCallback onBackToLogin;
  const RegisterScreen({super.key, required this.onRegistered, required this.onBackToLogin});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _department;
  bool _loading = false;

  final _departments = const [
    'Computer Applications',
    'Computer Science',
    'Commerce',
    'Management',
    'Mathematics',
    'Physics',
    'Chemistry',
  ];

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _loading = false);
    widget.onRegistered();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: widget.onBackToLogin)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create your account', style: AppTypography.h1),
                const SizedBox(height: 6),
                Text('Register as a student to start reporting issues.',
                    style: AppTypography.bodySm),
                const SizedBox(height: Spacing.xl),
                AppTextField(
                  label: 'Full name',
                  hint: 'Ananya Rao',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: Spacing.lg),
                AppTextField(
                  label: 'Email',
                  hint: 'you@campus.edu',
                  prefixIcon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: Spacing.lg),
                AppTextField(
                  label: 'Phone',
                  hint: '+91 98765 43210',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: Spacing.lg),
                AppTextField(
                  label: 'Student ID',
                  hint: 'CS2023-0142',
                  prefixIcon: Icons.badge_outlined,
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: Spacing.lg),
                Text('Department', style: AppTypography.label),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _department,
                  items: _departments
                      .map((d) => DropdownMenuItem(value: d, child: Text(d, style: AppTypography.bodyMd)))
                      .toList(),
                  onChanged: (v) => setState(() => _department = v),
                  validator: (v) => v == null ? 'Select a department' : null,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.apartment_outlined, size: 20, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(height: Spacing.lg),
                AppTextField(
                  label: 'Password',
                  hint: 'Minimum 6 characters',
                  obscure: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) => (v == null || v.length < 6) ? 'Minimum 6 characters' : null,
                ),
                const SizedBox(height: Spacing.xl),
                AppButton(label: 'Create account', loading: _loading, onPressed: _submit),
                const SizedBox(height: Spacing.lg),
                Center(
                  child: Text(
                    'Staff and admin accounts are created by campus administrators.',
                    textAlign: TextAlign.center,
                    style: AppTypography.caption,
                  ),
                ),
                const SizedBox(height: Spacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
