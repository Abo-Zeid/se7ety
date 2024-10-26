import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';

class AppTextStyle {
  static getHeadlineTextStyle(
      {double fontSize = 30, fontWeight = FontWeight.normal, Color? color}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.primaryColor,
    );
  }

  static getTtileTextStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 20,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? AppColors.primaryColor,
    );
  }

  static getbodyTextStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.primaryColor,
    );
  }

  static getSmallTextStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w100,
      color: color ?? AppColors.primaryColor,
    );
  }
}
