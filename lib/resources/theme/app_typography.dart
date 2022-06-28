import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFonts {
  static const String inter = 'Inter';
}

/* Naming convention: Name style with height: 1.0 without height percent.
 Example:
 static TextStyle m16 = _w500ls0.copyWith(
    fontSize: 16.ssp,
 );
*/

class AppTextStyles {
  static TextStyle b12 = _bold.copyWith(
    fontSize: 12.sp,
  );

  static TextStyle b14 = _bold.copyWith(
    fontSize: 14.sp,
  );

  static TextStyle b15 = _bold.copyWith(
    fontSize: 15.sp,
  );

  static TextStyle b16 = _bold.copyWith(
    fontSize: 16.sp,
  );

  static TextStyle b18 = _bold.copyWith(
    fontSize: 18.sp,
  );

  static TextStyle b24 = _bold.copyWith(
    fontSize: 24.sp,
  );

  static TextStyle b36 = _bold.copyWith(
    fontSize: 36.sp,
  );

  static TextStyle m9 = _medium.copyWith(
    fontSize: 9.sp,
  );

  static TextStyle m12 = _medium.copyWith(
    fontSize: 12.sp,
  );

  static TextStyle m14 = _medium.copyWith(
    fontSize: 14.sp,
  );

  static TextStyle m15 = _medium.copyWith(
    fontSize: 15.sp,
  );

  static TextStyle m16 = _medium.copyWith(
    fontSize: 16.sp,
  );

  static TextStyle m18 = _medium.copyWith(
    fontSize: 18.sp,
  );

  static TextStyle m24 = _medium.copyWith(
    fontSize: 24.sp,
  );

  static TextStyle m28 = _medium.copyWith(
    fontSize: 28.sp,
  );

  static TextStyle m32 = _medium.copyWith(
    fontSize: 32.sp,
  );

  static TextStyle m34 = _medium.copyWith(
    fontSize: 34.sp,
  );

  static TextStyle m36 = _medium.copyWith(
    fontSize: 36.sp,
  );

  static TextStyle m56 = _medium.copyWith(
    fontSize: 56.sp,
  );

  static TextStyle r8 = _regular.copyWith(
    fontSize: 8.sp,
  );

  static TextStyle r9 = _regular.copyWith(
    fontSize: 9.sp,
  );

  static TextStyle r12 = _regular.copyWith(
    fontSize: 12.sp,
  );

  static TextStyle r13 = _regular.copyWith(
    fontSize: 13.sp,
  );

  static TextStyle r14 = _regular.copyWith(
    fontSize: 14.sp,
  );

  static TextStyle r15 = _regular.copyWith(
    fontSize: 15.sp,
  );

  static TextStyle r16 = _regular.copyWith(
    fontSize: 16.sp,
  );

  static TextStyle r18 = _regular.copyWith(
    fontSize: 18.sp,
  );

  static TextStyle r24 = _regular.copyWith(
    fontSize: 24.sp,
  );

  static TextStyle r28 = _regular.copyWith(
    fontSize: 28.sp,
  );

  static TextStyle r30 = _regular.copyWith(
    fontSize: 30.sp,
  );

  static TextStyle r34 = _regular.copyWith(
    fontSize: 34.sp,
  );

  static TextStyle r36 = _regular.copyWith(
    fontSize: 36.sp,
  );

  static TextStyle r56 = _regular.copyWith(
    fontSize: 56.sp,
  );

  static const TextStyle _bold = TextStyle(
    fontFamily: AppFonts.inter,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const TextStyle _medium = TextStyle(
    fontFamily: AppFonts.inter,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  static const TextStyle _regular = TextStyle(
    fontFamily: AppFonts.inter,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
}
