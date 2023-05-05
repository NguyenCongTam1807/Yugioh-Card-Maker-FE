import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'fonts.dart';

final TextStyle kCardNameTextStyle = TextStyle(
    fontSize: 70.sp, fontFamily: FontFamily.matrixSmallCaps);

final TextStyle kMonsterTypeTextStyle = TextStyle(
  fontSize: 21.5.sp,
  fontWeight: FontWeight.bold,
  fontFamily: FontFamily.stoneSerifSmallCapsBold,
);

final TextStyle kCardDescTextStyle = TextStyle(
  fontSize: 24.5.sp,
  fontWeight: FontWeight.w500,
  fontFamily: FontFamily.matrix,
);

TextStyle kAtkDefTextStyle = const TextStyle(
  fontFamily: FontFamily.matrixBoldSmallCaps,
  height: 1.0,
);

TextStyle kUnknownAtkDefTextStyle = const TextStyle(
  fontFamily: FontFamily.stoneSerifBold,
);

final TextStyle kCreatorNameTextStyle = TextStyle(
    fontSize: 28.sp, fontFamily: FontFamily.matrixSmallCaps, height: 1.0);

final kLinkRatingTextStyle = TextStyle(
    fontSize: 18.sp, fontFamily: FontFamily.rogSanSerifStd, height: 1
);
