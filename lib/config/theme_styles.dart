import 'dart:ui';

import 'package:chinese_food/config/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ThemeStyles {

  static  TextStyle headline1 = TextStyle(
      color: ThemeColors.textColor444444,
      fontSize: ScreenUtil().setSp(17),
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w600);

  static  TextStyle subheadline1 = TextStyle(
      color: ThemeColors.textColor444444,
      fontSize: ScreenUtil().setSp(15),
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w600);

  static  TextStyle caption2 = TextStyle(
      color: ThemeColors.textColor444444,
      fontSize: ScreenUtil().setSp(11),
      fontFamily: 'SFProText',
      fontWeight: FontWeight.w600);
}