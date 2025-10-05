import 'package:flutter/material.dart';

class AppTheme {
  static const Color earthyBrown = Color(0xFF6D4C41);
  static const Color beige = Color(0xFFF5F1E9);
  static const Color accent = Color(0xFFB08968);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: earthyBrown),
    primaryColor: earthyBrown,
    scaffoldBackgroundColor: beige,
    appBarTheme: const AppBarTheme(
      backgroundColor: earthyBrown,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: earthyBrown,
      unselectedItemColor: Colors.black54,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: earthyBrown),
    ),
  );
}
