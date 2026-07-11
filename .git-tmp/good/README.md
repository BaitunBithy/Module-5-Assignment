# Student Grade Tracker

A Flutter app that lets a student add subjects, enter marks, view the
grade for each subject, and see a live result summary (total subjects,
average mark, overall grade, and number of passing subjects).

## Features

- **Add Subject** screen with form validation (name not empty, mark between 0–100).
- **Subject List** screen showing all subjects in a `ListView.builder`.
  Each subject is shown in a `Card` with its name, mark, and letter grade.
  Subjects can be removed by swiping them with `Dismissible`.
- **Summary** screen that updates live as subjects are added or removed:
  total subjects, average mark, overall letter grade, and passing count.
- **Light / dark theme** toggle in the AppBar. All UI colors are read from
  `Theme.of(context)`; the app defines its own `ThemeData` for each mode.
- **Bottom navigation** to switch between the three screens.
- **All app state is managed with `provider`** — there are zero `setState`
  calls in the app code.

## Project structure

```
lib/
├── main.dart                       # App entry, MultiProvider, HomeShell
├── models/
│   └── subject.dart                # Subject class with private _mark and grade getter
├── providers/
│   ├── subject_provider.dart       # ChangeNotifier; uses .map() for average, .where() for passing
│   ├── theme_provider.dart         # ChangeNotifier; toggles ThemeMode
│   └── navigation_provider.dart    # ChangeNotifier; bottom-nav index
├── screens/
│   ├── add_subject_screen.dart     # Form screen
│   ├── subject_list_screen.dart    # ListView.builder + Dismissible
│   └── summary_screen.dart         # Live summary stats
├── theme/
│   └── app_themes.dart             # Custom ThemeData for light + dark
└── widgets/
    └── theme_toggle_action.dart    # Reusable AppBar action
```

## Grading rules

| Grade | Mark range |
|-------|-------------|
| **A** | ≥ 80 |
| **B** | ≥ 65 |
| **C** | ≥ 50 |
| **F** | < 50 |

## Requirements

- Flutter SDK 3.12 or newer (Dart 3.12+).
- A device or emulator (Android, iOS, Windows, macOS, Linux, or Web).

## How to run

```bash
# 1. Install dependencies
flutter pub get

# 2. Run the app
flutter run

# Optional: run the unit tests
flutter test
```

You can also target a specific platform:

```bash
flutter run -d chrome        # Web
flutter run -d windows       # Windows desktop
flutter run -d android       # Android emulator/device
flutter run -d ios           # iOS simulator/device
```

## Notes

- `Subject._mark` is private; use the `mark` getter to read it and
  `Subject.grade` to read the computed letter grade.
- The list uses `Subject.id` as the `Dismissible` key so deleting one
  subject never re-orders the others.
- `.map()` is used inside `SubjectProvider.averageMark` and `.where()`
  inside `SubjectProvider.passingSubjects`, satisfying the functional
  collection requirement.
