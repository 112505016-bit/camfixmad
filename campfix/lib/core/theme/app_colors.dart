import 'package:flutter/material.dart';

/// CampFix design tokens — colour system.
///
/// Design rationale: CampFix manages physical campus infrastructure
/// (pipes, wiring, buildings), so the palette leans into the language
/// of blueprints and utility maps rather than a generic "SaaS purple"
/// or warm-cream/terracotta look. The core is a deep pine/ink teal
/// (institutional, calm, trustworthy — like a campus estates office),
/// paired with a single warm ochre accent reserved only for the primary
/// call-to-action and "in progress" signal, so it stays meaningful
/// instead of decorative.
class AppColors {
  AppColors._();

  // ---- Brand ----
  static const Color primary = Color(0xFF163832); // deep pine ink
  static const Color primaryLight = Color(0xFF2D8C7F); // signal teal
  static const Color primaryDark = Color(0xFF0D211D);
  static const Color accent = Color(0xFFE8A33D); // ochre — CTA / in-progress

  // ---- Surfaces ----
  static const Color background = Color(0xFFF6F8F6); // soft mineral white
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFEFF3F1);
  static const Color surfaceDark = Color(0xFF10201C); // dark mode base
  static const Color surfaceDarkAlt = Color(0xFF172C27);

  // ---- Text ----
  static const Color textPrimary = Color(0xFF13221F);
  static const Color textSecondary = Color(0xFF5B6B67);
  static const Color textTertiary = Color(0xFF8B9895);
  static const Color textOnPrimary = Color(0xFFF6F8F6);
  static const Color textOnPrimaryDark = Color(0xFFEDEFEC);

  // ---- Borders / dividers ----
  static const Color border = Color(0xFFE1E7E4);
  static const Color borderStrong = Color(0xFFC7D1CD);
  static const Color divider = Color(0xFFE9EDEB);

  // ---- Semantic status ----
  static const Color success = Color(0xFF2E9E6D);
  static const Color successBg = Color(0xFFE4F5EC);
  static const Color warning = Color(0xFFE8A33D);
  static const Color warningBg = Color(0xFFFBF0DC);
  static const Color error = Color(0xFFD6503F);
  static const Color errorBg = Color(0xFFFBE7E4);
  static const Color info = Color(0xFF3B82C4);
  static const Color infoBg = Color(0xFFE4EFF9);

  // ---- Priority scale (also drives the "conduit" timeline colour) ----
  static const Color priorityLow = Color(0xFF6B9E8C);
  static const Color priorityMedium = Color(0xFF3B82C4);
  static const Color priorityHigh = Color(0xFFE8A33D);
  static const Color priorityCritical = Color(0xFFC43D3D);

  // ---- Complaint lifecycle node colours (conduit signature element) ----
  static const Color nodePending = Color(0xFFC7D1CD);
  static const Color nodeActive = Color(0xFFE8A33D);
  static const Color nodeDone = Color(0xFF2D8C7F);

  static Color priorityColor(String priority) {
    switch (priority.toUpperCase()) {
      case 'LOW':
        return priorityLow;
      case 'MEDIUM':
        return priorityMedium;
      case 'HIGH':
        return priorityHigh;
      case 'CRITICAL':
        return priorityCritical;
      default:
        return priorityMedium;
    }
  }

  static Color statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return info;
      case 'ACKNOWLEDGED':
      case 'ASSIGNED':
      case 'ACCEPTED':
        return primaryLight;
      case 'IN_PROGRESS':
        return accent;
      case 'RESOLVED':
      case 'VERIFICATION_PENDING':
        return success;
      case 'CLOSED':
        return textSecondary;
      case 'OVERDUE':
      case 'REJECTED':
        return error;
      case 'REOPENED':
      case 'ESCALATED':
        return priorityCritical;
      case 'CANCELLED':
        return textTertiary;
      default:
        return textSecondary;
    }
  }
}
