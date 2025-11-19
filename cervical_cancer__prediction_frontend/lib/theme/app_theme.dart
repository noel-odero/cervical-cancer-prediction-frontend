import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPink = Color(0xFFFF0080); // Bright magenta/pink
  static const Color darkBackground = Color(0xFF0A0A1F); // Very dark blue-black
  static const Color cardBackground = Color(
    0xFF1A1A3E,
  ); // Slightly lighter dark
  static const Color accentPink = Color(0xFFFF1493); // Deep pink
  static const Color lightPink = Color(0xFFFFB6D9); // Light pink for accents
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFFB0B0C8);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color dangerRed = Color(0xFFF44336);
  static const Color highRisk = Color(0xFFFF1744);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,

      colorScheme: ColorScheme.dark(
        primary: primaryPink,
        secondary: accentPink,
        surface: cardBackground,
        error: dangerRed,
        onPrimary: textWhite,
        onSecondary: textWhite,
        onSurface: textWhite,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: textWhite),
      ),

      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPink,
          foregroundColor: textWhite,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 8,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: textGrey.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: textGrey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryPink, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: dangerRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: dangerRed, width: 2),
        ),
        labelStyle: TextStyle(color: textGrey),
        hintStyle: TextStyle(color: textGrey.withOpacity(0.6)),
        errorStyle: TextStyle(color: dangerRed),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textWhite,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textWhite,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textWhite,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textWhite,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textWhite,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textWhite),
        bodyMedium: TextStyle(fontSize: 14, color: textGrey),
      ),

      iconTheme: IconThemeData(color: primaryPink, size: 24),

      dividerTheme: DividerThemeData(
        color: textGrey.withOpacity(0.2),
        thickness: 1,
      ),
    );
  }

  // Helper method to get risk level color
  static Color getRiskColor(String riskLevel) {
    switch (riskLevel.toUpperCase()) {
      case 'VERY LOW':
      case 'LOW':
        return successGreen;
      case 'MEDIUM':
      case 'MODERATE':
        return warningOrange;
      case 'HIGH':
      case 'VERY HIGH':
        return highRisk;
      default:
        return textGrey;
    }
  }
}
