# 📚 Grade Tracker

A Flutter app where students can add subjects with marks, view their grades, and see a result summary — built for a university Flutter assignment.

## Features

- **Add Subject** — Form with name and mark fields; validates empty name and marks outside 0–100
- **Subject List** — Scrollable list of all subjects showing name, mark, and grade; swipe left to delete
- **Summary** — Live stats: total subjects, passing count, average mark, and overall grade
- **Light / Dark Theme** — Custom `ThemeData` for each mode, toggled via AppBar icon; all colors from `Theme.of(context)`
- **Provider state management** — Zero `setState` calls in any widget

## Grade Scale

| Grade | Mark |
|-------|------|
| A     | ≥ 80 |
| B     | ≥ 65 |
| C     | ≥ 50 |
| F     | < 50 |

## How to Run

### Prerequisites

- Flutter SDK ≥ 3.0.0
- A connected device or emulator

### Steps

```bash
# 1. Clone the repo
git clone https://github.com/nuha63/grade_tracker.git
cd grade_tracker

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

To build a release APK:

```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── main.dart                        # App entry, MultiProvider, HomeShell with BottomNavigationBar
├── models/
│   └── subject.dart                 # Subject class with private _mark and grade getter
├── providers/
│   ├── navigation_provider.dart     # ChangeNotifier: bottom nav tab index
│   ├── subject_provider.dart        # ChangeNotifier: list, add, remove, computed stats
│   └── theme_provider.dart          # ChangeNotifier: isDark toggle, lightTheme/darkTheme
├── screens/
│   ├── add_subject_screen.dart      # Screen 1 — form with validation
│   ├── subject_list_screen.dart     # Screen 2 — ListView.builder + Dismissible
│   └── summary_screen.dart          # Screen 3 — live summary with passing subjects
└── utils/
    └── grade_helpers.dart           # Shared gradeColor helper used across screens
```

## Assignment Requirements Met

- [x] `Subject` class with private `_mark` field and `grade` getter
- [x] `.where()` used in `SubjectProvider.passingSubjects`
- [x] `.map()` used to compute total mark in `averageMark`
- [x] Form validation (empty name, mark 0–100)
- [x] `Dismissible` for swipe-to-delete
- [x] Custom light and dark `ThemeData`, no hardcoded colors
- [x] All state managed via `Provider`; zero `setState` in the entire app
- [x] 3+ meaningful commits (`feat:`, `fix:`, `docs:`)
