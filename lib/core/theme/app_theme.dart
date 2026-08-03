import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.lightPrimary,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
        titleTextStyle: AppTextStyles.heading(AppColors.lightTextPrimary).copyWith(fontSize: 20),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        surface: AppColors.lightSurface,
        error: AppColors.lightError,
        onPrimary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge(AppColors.lightTextPrimary),
        titleLarge: AppTextStyles.heading(AppColors.lightTextPrimary),
        bodyLarge: AppTextStyles.bodyLarge(AppColors.lightTextPrimary),
        bodyMedium: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.darkPrimary,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
        titleTextStyle: AppTextStyles.heading(AppColors.darkTextPrimary).copyWith(fontSize: 20),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        surface: AppColors.darkSurface,
        error: AppColors.darkError,
        onPrimary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge(AppColors.darkTextPrimary),
        titleLarge: AppTextStyles.heading(AppColors.darkTextPrimary),
        bodyLarge: AppTextStyles.bodyLarge(AppColors.darkTextPrimary),
        bodyMedium: AppTextStyles.bodyMedium(AppColors.darkTextSecondary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
      ),
    );
  }
}
