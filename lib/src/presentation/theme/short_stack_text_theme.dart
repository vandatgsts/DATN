import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortStackTextTheme {
  ShortStackTextTheme._();

  static const String _fontFamily = "ShortStack";

  static TextStyle? displayLarge(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 57.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? displayMedium(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 45.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? displaySmall(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 36.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? headlineLarge(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 32.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? headlineMedium(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 28.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? headlineSmall(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 24.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? titleLarge(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 22.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    );
  }

  static TextStyle? titleMedium(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 16.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    );
  }

  static TextStyle? titleSmall(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }

  static TextStyle? labelLarge(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 14.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }

  static TextStyle? labelMedium(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 12.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? labelSmall(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 11.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? bodyLarge(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 16.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    );
  }

  static TextStyle? bodyMedium(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 14.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    );
  }

  static TextStyle? bodySmall(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 12.0.sp,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    );
  }
}
