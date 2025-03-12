import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    cardColor: AppColors.darkBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: AppColors.darkBlue,
      ),
    ),
    dividerColor: AppColors.dividerColor,
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerColor,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightPrimary,
      selectedItemColor: AppColors.darkBlue,
      selectedLabelStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.darkBlue,
      ),
      selectedIconTheme: IconThemeData(
        color: AppColors.darkBlue,
        size: 22.0,
      ),
      unselectedItemColor: AppColors.lightGrey,
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightGrey,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.lightGrey,
        size: 14.0,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.darkBlue,
      ),
      bodyMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkBlue,
      ),
      bodyLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrey,
      ),
      titleMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: AppColors.red,
      ),
    ),
  );
  static final darkTheme = ThemeData(
    primaryColor: AppColors.lightGrey,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: AppColors.orane,
      ),
    ),
    cardColor: AppColors.whitBac,
    dividerColor: AppColors.dividerColor,
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerColor,
    ),
    scaffoldBackgroundColor: AppColors.lightGrey,
    brightness: Brightness.dark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlue,
      selectedItemColor: AppColors.lightPrimary,
      selectedLabelStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.lightPrimary,
      ),
      selectedIconTheme: IconThemeData(
        color: AppColors.lightPrimary,
        size: 22.0,
      ),
      unselectedItemColor: AppColors.lightGrey,
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightPrimary,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.lightPrimary,
        size: 14.0,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.lightPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: AppColors.lightPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.lightPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: AppColors.red,
      ),
    ),
  );
}
