import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'features/student/student_home_screen.dart';
import 'features/staff/staff_dashboard_screen.dart';
import 'features/admin/admin_dashboard_screen.dart';
import 'features/complaints/create_complaint_screen.dart';
import 'features/complaints/complaint_detail_screen.dart';
import 'features/profile/profile_screen.dart';

enum AppRole { student, staff, admin }

/// Bottom-navigation shell. Which tabs appear depends on the signed-in
/// role, per the role-based access control described in the spec.
class AppShell extends StatefulWidget {
  final AppRole role;
  const AppShell({super.key, this.role = AppRole.student});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tab = 0;
  bool _creating = false;
  bool _viewingDetail = false;

  @override
  Widget build(BuildContext context) {
    if (_creating) {
      return CreateComplaintScreen(
        onSubmitted: () => setState(() => _creating = false),
        onCancel: () => setState(() => _creating = false),
      );
    }
    if (_viewingDetail) {
      return ComplaintDetailScreen(onBack: () => setState(() => _viewingDetail = false));
    }

    final tabs = _tabsForRole(widget.role);

    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: tabs.map((t) => t.screen).toList(),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primary.withValues(alpha: 0.1),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? AppColors.primary : AppColors.textTertiary,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (i) => setState(() => _tab = i),
          destinations: tabs
              .map((t) => NavigationDestination(icon: Icon(t.icon), label: t.label))
              .toList(),
        ),
      ),
    );
  }

  List<_TabDef> _tabsForRole(AppRole role) {
    switch (role) {
      case AppRole.student:
        return [
          _TabDef('Home', Icons.home_outlined, StudentHomeScreen(
            onCreateComplaint: () => setState(() => _creating = true),
            onOpenComplaint: (_) => setState(() => _viewingDetail = true),
          )),
          _TabDef('Complaints', Icons.list_alt_outlined, StudentHomeScreen(
            onCreateComplaint: () => setState(() => _creating = true),
            onOpenComplaint: (_) => setState(() => _viewingDetail = true),
          )),
          _TabDef('Notifications', Icons.notifications_outlined, const _PlaceholderScreen(title: 'Notifications')),
          _TabDef('Profile', Icons.person_outline, const ProfileScreen()),
        ];
      case AppRole.staff:
        return [
          _TabDef('Dashboard', Icons.dashboard_outlined, const StaffDashboardScreen()),
          _TabDef('Tasks', Icons.assignment_outlined, const StaffDashboardScreen()),
          _TabDef('Notifications', Icons.notifications_outlined, const _PlaceholderScreen(title: 'Notifications')),
          _TabDef('Profile', Icons.person_outline, const ProfileScreen()),
        ];
      case AppRole.admin:
        return [
          _TabDef('Overview', Icons.dashboard_outlined, const AdminDashboardScreen()),
          _TabDef('Complaints', Icons.list_alt_outlined, const _PlaceholderScreen(title: 'All complaints')),
          _TabDef('Manage', Icons.settings_outlined, const _PlaceholderScreen(title: 'Users, staff, departments')),
          _TabDef('Profile', Icons.person_outline, const ProfileScreen()),
        ];
    }
  }
}

class _TabDef {
  final String label;
  final IconData icon;
  final Widget screen;
  _TabDef(this.label, this.icon, this.screen);
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('$title screen', style: const TextStyle(color: AppColors.textTertiary)),
      ),
    );
  }
}
