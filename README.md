# Student Grade Tracker

A small Flutter app for tracking marks and grades across subjects. Add a subject and its mark, see the live grade, swipe a subject to delete it, and switch between light and dark themes.

## Features

- **Add subjects** with a name and mark (0-100), validated client-side.
- **Live grade** computed from the mark (`A >= 80`, `B >= 65`, `C >= 50`, else `F`).
- **Subject list** with a colored grade badge per entry; swipe a row to delete.
- **Summary screen** with total subjects, average mark, overall grade, and number of passing subjects - all reactive.
- **Light / dark theme toggle** in the app bar; the choice persists for the session via Provider.
- **Bottom navigation** between Add, Subject List, and Summary tabs using an `IndexedStack`.
- All state managed through `provider` - zero `setState` in widgets.

## Project structure

```
lib/
  main.dart                       # MultiProvider + HomeShell + IndexedStack
  models/
    subject.dart                  # Subject with private _mark and grade getter
  providers/
    navigation_provider.dart      # Bottom-nav index
    subject_provider.dart         # Subject list + computed stats
    theme_provider.dart           # ThemeMode toggle
  screens/
    add_subject_screen.dart       # Form with validation
    subject_list_screen.dart      # Dismissible list
    summary_screen.dart           # Live summary cards
  theme/
    app_themes.dart               # Custom ThemeData for light + dark
  widgets/
    theme_toggle_action.dart      # AppBar action (Consumer<ThemeProvider>)
test/
  subject_provider_test.dart      # Unit tests for Subject + SubjectProvider
```

## Grading rules

| Mark range | Grade |
|-----------:|:-----:|
| 80-100     | A     |
| 65-79.99   | B     |
| 50-64.99   | C     |
| 0-49.99    | F     |

A subject passes with any non-`F` grade. The overall grade follows the same thresholds applied to the average mark.

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```

## Built with

- [Flutter](https://flutter.dev)
- [provider](https://pub.dev/packages/provider)