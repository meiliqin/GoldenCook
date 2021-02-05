import 'package:chinese_food/config/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';

class WithStatusBarLayout extends StatelessWidget {
   Widget child; //布局
   Color color;//状态栏颜色
   bool layoutOverlapStatus;//布局是否侵入顶部状态栏

  WithStatusBarLayout(
      {@required this.child,
      this.color,this.layoutOverlapStatus=false});


  @override
  Widget build(BuildContext context) {
    //修改状态栏字体颜色
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness:Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    EdgeInsets padding = MediaQuery.of(context).padding;
    double top = math.max(
      padding.top,
      EdgeInsets.zero.top,
    ); //计算状态栏的高度
    print("top1:${padding.top} top2:${EdgeInsets.zero.top}");
    if(top<=0){
      top = ScreenUtil().setHeight(44);
    }
    if(layoutOverlapStatus){
      top=0;
    }

    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: top,
          color: color,
        ),
        Expanded(child: child),
      ],
    );
  }
}
