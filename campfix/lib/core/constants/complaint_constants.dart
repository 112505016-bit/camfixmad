import 'package:flutter/material.dart';

/// Canonical complaint lifecycle, in order. Branch states (REJECTED,
/// CANCELLED, REOPENED, ESCALATED) are handled separately in the UI
/// as banners/badges rather than steps on the main line.
class ComplaintStatus {
  ComplaintStatus._();
  static const String newC = 'NEW';
  static const String acknowledged = 'ACKNOWLEDGED';
  static const String assigned = 'ASSIGNED';
  static const String accepted = 'ACCEPTED';
  static const String inProgress = 'IN_PROGRESS';
  static const String resolved = 'RESOLVED';
  static const String verificationPending = 'VERIFICATION_PENDING';
  static const String closed = 'CLOSED';

  static const List<String> mainFlow = [
    newC,
    acknowledged,
    assigned,
    accepted,
    inProgress,
    resolved,
    verificationPending,
    closed,
  ];

  static String label(String status) {
    switch (status) {
      case newC:
        return 'Submitted';
      case acknowledged:
        return 'Acknowledged';
      case assigned:
        return 'Assigned';
      case accepted:
        return 'Accepted';
      case inProgress:
        return 'In progress';
      case resolved:
        return 'Resolved';
      case verificationPending:
        return 'Verification pending';
      case closed:
        return 'Closed';
      case 'REJECTED':
        return 'Rejected';
      case 'CANCELLED':
        return 'Cancelled';
      case 'REOPENED':
        return 'Reopened';
      case 'ESCALATED':
        return 'Escalated';
      case 'OVERDUE':
        return 'Overdue';
      default:
        return status;
    }
  }

  static IconData icon(String status) {
    switch (status) {
      case newC:
        return Icons.flag_outlined;
      case acknowledged:
        return Icons.visibility_outlined;
      case assigned:
        return Icons.person_add_alt_outlined;
      case accepted:
        return Icons.handshake_outlined;
      case inProgress:
        return Icons.build_outlined;
      case resolved:
        return Icons.task_alt_outlined;
      case verificationPending:
        return Icons.fact_check_outlined;
      case closed:
        return Icons.lock_outline;
      default:
        return Icons.circle_outlined;
    }
  }
}

class Priority {
  Priority._();
  static const String low = 'LOW';
  static const String medium = 'MEDIUM';
  static const String high = 'HIGH';
  static const String critical = 'CRITICAL';
  static const List<String> all = [low, medium, high, critical];
}

class ComplaintCategories {
  ComplaintCategories._();
  static const List<Map<String, dynamic>> all = [
    {'name': 'Electrical', 'icon': Icons.bolt_outlined},
    {'name': 'Plumbing', 'icon': Icons.plumbing_outlined},
    {'name': 'Cleaning', 'icon': Icons.cleaning_services_outlined},
    {'name': 'Furniture', 'icon': Icons.chair_outlined},
    {'name': 'IT / Network', 'icon': Icons.wifi_outlined},
    {'name': 'Classroom', 'icon': Icons.school_outlined},
    {'name': 'Laboratory', 'icon': Icons.science_outlined},
    {'name': 'Hostel', 'icon': Icons.bed_outlined},
    {'name': 'Library', 'icon': Icons.menu_book_outlined},
    {'name': 'Washroom', 'icon': Icons.wc_outlined},
    {'name': 'Drinking Water', 'icon': Icons.water_drop_outlined},
    {'name': 'Air Conditioning', 'icon': Icons.ac_unit_outlined},
    {'name': 'Security', 'icon': Icons.security_outlined},
    {'name': 'Transport', 'icon': Icons.directions_bus_outlined},
    {'name': 'Infrastructure', 'icon': Icons.apartment_outlined},
    {'name': 'Other', 'icon': Icons.more_horiz_outlined},
  ];
}
