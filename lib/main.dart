import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/subject_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/navigation_provider.dart';
import 'theme/app_themes.dart';
import 'screens/add_subject_screen.dart';
import 'screens/subject_list_screen.dart';
import 'screens/summary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Student Grade Tracker',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomeShell(),
          );
        },
      ),
    );
  }
}

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  static const _screens = [
    AddSubjectScreenWrapper(),
    SubjectListScreen(),
    SummaryScreen(),
  ];

  static const _titles = ['Add Subject', 'Subject List', 'Summary'];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navProvider, _) {
        return Scaffold(
          body: IndexedStack(
            index: navProvider.currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navProvider.currentIndex,
            onTap: (index) => navProvider.setIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline),
                label: 'Summary',
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Wraps AddSubjectScreen so it can carry a theme toggle in its own AppBar
/// without each screen needing to duplicate the shell scaffold.
class AddSubjectScreenWrapper extends StatelessWidget {
  const AddSubjectScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AddSubjectScreen();
  }
}