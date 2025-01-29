import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeData() {
  return ThemeData(
    fontFamily: "Kanit",
    colorScheme: ColorScheme.dark(),
    textTheme: TextTheme(
      /// For large titles
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30.sp),

      /// For Small Titles
      titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w300,fontSize: 16.sp),

      /// For labels on text fields etc.
      labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16.sp),

    )
  );
}