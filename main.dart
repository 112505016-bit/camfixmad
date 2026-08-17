import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'app_shell.dart';

void main() {
  runApp(const CampFixApp());
}

enum _Stage { splash, onboarding, login, register, app }

class CampFixApp extends StatefulWidget {
  const CampFixApp({super.key});

  @override
  State<CampFixApp> createState() => _CampFixAppState();
}

class _CampFixAppState extends State<CampFixApp> {
  _Stage _stage = _Stage.splash;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampFix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: _buildStage(),
    );
  }

  Widget _buildStage() {
    switch (_stage) {
      case _Stage.splash:
        return SplashScreen(onFinished: () => setState(() => _stage = _Stage.onboarding));
      case _Stage.onboarding:
        return OnboardingScreen(onDone: () => setState(() => _stage = _Stage.login));
      case _Stage.login:
        return LoginScreen(
          onLoggedIn: () => setState(() => _stage = _Stage.app),
          onRegister: () => setState(() => _stage = _Stage.register),
        );
      case _Stage.register:
        return RegisterScreen(
          onRegistered: () => setState(() => _stage = _Stage.app),
          onBackToLogin: () => setState(() => _stage = _Stage.login),
        );
      case _Stage.app:
        // Role is normally read from the authenticated session;
        // defaults to student here. Swap AppRole.staff / .admin to preview.
        return const AppShell(role: AppRole.student);
    }
  }
}
