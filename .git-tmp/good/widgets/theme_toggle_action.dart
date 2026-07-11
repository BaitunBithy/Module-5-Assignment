import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

/// A reusable IconButton for AppBars that toggles between light and dark
/// theme using ThemeProvider. Contains no local state — purely reactive
/// to ThemeProvider via Consumer.
class ThemeToggleAction extends StatelessWidget {
  const ThemeToggleAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return IconButton(
          tooltip: themeProvider.isDarkMode
              ? 'Switch to light mode'
              : 'Switch to dark mode',
          icon: Icon(
            themeProvider.isDarkMode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
          onPressed: () => themeProvider.toggleTheme(),
        );
      },
    );
  }
}
