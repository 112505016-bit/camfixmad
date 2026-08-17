import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoggedIn;
  final VoidCallback onRegister;
  const LoginScreen({super.key, required this.onLoggedIn, required this.onRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _loading = false);
    widget.onLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xl, vertical: Spacing.xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Spacing.xl),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(Radii.md),
                  ),
                  child: const Icon(Icons.hub_outlined, color: AppColors.accent, size: 26),
                ),
                const SizedBox(height: Spacing.xl),
                Text('Welcome back', style: AppTypography.h1),
                const SizedBox(height: 6),
                Text('Sign in to keep tracking your campus reports.',
                    style: AppTypography.bodySm),
                const SizedBox(height: Spacing.xxl),
                AppTextField(
                  label: 'Email or ID',
                  hint: 'you@campus.edu',
                  controller: _email,
                  prefixIcon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter your email or ID' : null,
                ),
                const SizedBox(height: Spacing.lg),
                AppTextField(
                  label: 'Password',
                  hint: '••••••••',
                  controller: _password,
                  obscure: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) => (v == null || v.length < 6) ? 'Minimum 6 characters' : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                AppButton(label: 'Sign in', loading: _loading, onPressed: _submit),
                const SizedBox(height: Spacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: AppTypography.bodySm),
                    GestureDetector(
                      onTap: widget.onRegister,
                      child: Text('Register',
                          style: AppTypography.body(12.5,
                              weight: FontWeight.w700, color: AppColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.xl),
                Row(children: [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Staff & admin sign in with the same form',
                        style: AppTypography.caption),
                  ),
                  Expanded(child: Divider(color: AppColors.border)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
