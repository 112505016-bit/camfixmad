# CampFix — Flutter UI

Complete UI/design layer for the CampFix Smart Campus Complaint Management
System, built to be dropped straight into the full-stack project (Node/Express
+ Supabase + Cloudinary come later — this package is UI + design system only,
using inline demo data so every screen is viewable immediately).

## Run it

```bash
flutter pub get
flutter run
```

Download the four Space Grotesk font weights from Google Fonts and place
them at `assets/fonts/SpaceGrotesk-*.ttf` (paths referenced in
`pubspec.yaml`), or delete that font block and rely on `google_fonts`
package fetching at runtime (already wired in `app_typography.dart` via
`GoogleFonts.spaceGrotesk()` / `GoogleFonts.inter()` / `GoogleFonts.jetBrainsMono()`).

## Design system

**Why this palette, not the default SaaS look:** CampFix manages physical
campus infrastructure — pipes, wiring, buildings — so the system leans on the
language of blueprints and utility maps instead of a generic purple gradient
or the cream/terracotta look common to AI-generated UI. Core is a deep pine
ink (`#163832`), paired with one warm ochre accent (`#E8A33D`) reserved
strictly for primary CTAs and the "in progress" signal, so the accent stays
meaningful rather than decorative.

| Token | Hex | Use |
|---|---|---|
| `primary` | `#163832` | Brand, primary buttons, headers |
| `primaryLight` | `#2D8C7F` | Secondary brand, links, staff role accent |
| `accent` | `#E8A33D` | CTA, "in progress" state only |
| `background` | `#F6F8F6` | App background |
| `success` / `error` / `info` | `#2E9E6D` / `#D6503F` / `#3B82C4` | Status semantics |

**Type system:** Space Grotesk (display — geometric, technical, used for
headings and the CampFix wordmark), Inter (body — legible at small mobile
sizes), JetBrains Mono (utility — reserved only for complaint IDs like
`CF-2026-000124` and timestamps, so monospace always reads as "machine
reference data").

**Signature element — the Conduit Timeline** (`shared/widgets/conduit_timeline.dart`):
the complaint lifecycle is drawn as a single physical line with junction
nodes, echoing the pipes and cable runs the app's own users repair. Completed
sections fill solid teal, the active node glows ochre, future sections stay
a flat dashed outline. It's used on the complaint detail screen and can
render horizontally for compact list previews.

## Structure

```
lib/
  core/
    theme/        # colors, typography, spacing tokens, ThemeData
    constants/     # status/priority/category enums shared everywhere
  shared/widgets/  # status & priority badges, buttons, text fields,
                   # complaint card, summary card, conduit timeline
  features/
    splash/ onboarding/ auth/            # login, register
    student/                              # home dashboard
    staff/                                 # workload dashboard
    admin/                                 # analytics dashboard (fl_chart)
    complaints/                            # 6-step creation flow + detail
    profile/
  app_shell.dart   # role-aware bottom navigation (student/staff/admin)
  main.dart        # splash → onboarding → auth → role shell
```

## What's wired vs. stubbed

- All screens render with realistic demo data and full interaction states
  (loading, empty, selected, overdue) — no backend calls yet.
- `AppShell(role: ...)` swaps the whole navigation + screen set per role;
  swap to `AppRole.staff` / `AppRole.admin` in `main.dart` to preview those.
- Notifications tab and admin "Manage" screens are intentionally left as
  labeled placeholders — next step is wiring these plus the REST API client
  described in the backend spec (section 38).
- Dark mode theme (`AppTheme.dark`) is defined; flip `themeMode` in
  `main.dart` to preview it.
