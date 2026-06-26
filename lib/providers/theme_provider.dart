import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF5C6BC0),
          secondary: Color(0xFF26A69A),
          surface: Color(0xFFF5F5F5),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
          onSurface: Color(0xFF212121),
          error: Color(0xFFD32F2F),
          onError: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        // Fixed: Changed AppBarThemeData to AppBarTheme
        appBarTheme: const ThemeData(
          backgroundColor: Color(0xFF5C6BC0),
          foregroundColor: Color(0xFFFFFFFF),
          elevation: 2,
        ),
        // Fixed: Changed CardThemeData to CardTheme
        cardTheme: const CardThemeData(
          color: Color(0xFFFFFFFF),
          elevation: 2,
        ),
        // Fixed: Changed InputDecorationThemeData to InputDecorationTheme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF5C6BC0), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5C6BC0),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFFFFFFF),
          selectedItemColor: Color(0xFF5C6BC0),
          unselectedItemColor: Color(0xFF9E9E9E),
        ),
        useMaterial3: true,
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7986CB),
          secondary: Color(0xFF4DB6AC),
          surface: Color(0xFF1E1E2E),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF000000),
          onSurface: Color(0xFFE0E0E0),
          error: Color(0xFFEF5350),
          onError: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        // Fixed: Changed AppBarThemeData to AppBarTheme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E2E),
          foregroundColor: Color(0xFFE0E0E0),
          elevation: 2,
        ),
        // Fixed: Changed CardThemeData to CardTheme
        cardTheme: const CardThemeData(
          color: Color(0xFF1E1E2E),
          elevation: 2,
        ),
        // Fixed: Changed InputDecorationThemeData to InputDecorationTheme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A3E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF7986CB), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7986CB),
            foregroundColor: const Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E2E),
          selectedItemColor: Color(0xFF7986CB),
          unselectedItemColor: Color(0xFF757575),
        ),
        useMaterial3: true,
      );
}