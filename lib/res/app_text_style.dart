import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static String defaultFontFamily = 'Playfair Display'; //   default font family

  static TextStyle normal(double fontSize, {String? fontFamily, Color? color}) {
    return GoogleFonts.getFont(
      fontFamily ?? defaultFontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: color ?? Colors.black, // Default color is black
    );
  }

  static TextStyle semiBold(double fontSize,
      {String? fontFamily, Color? color}) {
    return GoogleFonts.getFont(
      fontFamily ?? defaultFontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color ?? Colors.black, // Default color is black
    );
  }

  static TextStyle bold(double fontSize, {String? fontFamily, Color? color}) {
    return GoogleFonts.getFont(
      fontFamily ?? defaultFontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black, // Default color is black
    );
  }

  static TextStyle normal12({String? fontFamily, Color? color}) =>
      normal(12, fontFamily: fontFamily, color: color);

  static TextStyle normal14({String? fontFamily, Color? color}) =>
      normal(14, fontFamily: fontFamily, color: color);

  static TextStyle normal16({String? fontFamily, Color? color}) =>
      normal(16, fontFamily: fontFamily, color: color);

  static TextStyle normal18({String? fontFamily, Color? color}) =>
      normal(18, fontFamily: fontFamily, color: color);

  static TextStyle normal20({String? fontFamily, Color? color}) =>
      normal(20, fontFamily: fontFamily, color: color);

  static TextStyle semiBold12({String? fontFamily, Color? color}) =>
      semiBold(12, fontFamily: fontFamily, color: color);

  static TextStyle semiBold14({String? fontFamily, Color? color}) =>
      semiBold(14, fontFamily: fontFamily, color: color);

  static TextStyle semiBold16({String? fontFamily, Color? color}) =>
      semiBold(16, fontFamily: fontFamily, color: color);

  static TextStyle semiBold18({String? fontFamily, Color? color}) =>
      semiBold(18, fontFamily: fontFamily, color: color);

  static TextStyle semiBold20({String? fontFamily, Color? color,double? size=20,}) =>
      semiBold(size!, fontFamily: fontFamily, color: color);

  static TextStyle splashSize({String? fontFamily, Color? color}) =>
      semiBold(38, fontFamily: fontFamily, color: color);

  static TextStyle bold12({String? fontFamily, Color? color}) =>
      bold(12, fontFamily: fontFamily, color: color);

  static TextStyle bold14({String? fontFamily, Color? color}) =>
      bold(14, fontFamily: fontFamily, color: color);

  static TextStyle bold16({String? fontFamily, Color? color}) =>
      bold(16, fontFamily: fontFamily, color: color);

  static TextStyle bold18({String? fontFamily, Color? color}) =>
      bold(18, fontFamily: fontFamily, color: color);

  static TextStyle bold20({String? fontFamily, Color? color}) =>
      bold(20, fontFamily: fontFamily, color: color);

  /// for brandName showCase
  static TextStyle bold30(
          {String? fontFamily, Color? color, double fontSize = 30}) =>
      bold(fontSize, fontFamily: fontFamily, color: color);
}
