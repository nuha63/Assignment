import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/subject_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/add_subject_screen.dart';
import 'screens/subject_list_screen.dart';
import 'screens/summary_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const GradeTrackerApp(),
    ),
  );
}

class GradeTrackerApp extends StatelessWidget {
  const GradeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Grade Tracker',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode:
              themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          home: const HomeShell(),
        );
      },
    );
  }
}

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  static const List<Widget> _screens = [
    SingleChildScrollView(child: AddSubjectScreen()),
    SubjectListScreen(),
    SummaryScreen(),
  ];

  static const List<String> _titles = ['Add Subject', 'Subjects', 'Summary'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();
    final navProvider = context.watch<NavigationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[navProvider.currentIndex]),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
              color: colorScheme.onPrimary,
            ),
            tooltip: 'Toggle theme',
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),
      body: IndexedStack(
        index: navProvider.currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) => context.read<NavigationProvider>().setIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
