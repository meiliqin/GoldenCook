import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chinese_food/config/theme_colors.dart';
import 'package:chinese_food/config/theme_styles.dart';
import 'package:chinese_food/model/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TodayRecommendItem extends StatelessWidget {

  final List<Recipe>  data;

  const TodayRecommendItem({this.data});



  @override
  Widget build(BuildContext context) {
    // print("TodayRecommendWidget build");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(context),
        Container(
          height: ScreenUtil().setWidth(285),
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(16),ScreenUtil().setWidth(14), 0, 0),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(context, index);
            },
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
        child: new Text(
          "Featured Recipes",
          style: ThemeStyles.headline1,
        ),
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(33), ScreenUtil().setWidth(22), 0, 0));
  }
  // Widget _buildIndicator(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment:MainAxisAlignment.center ,
  //       children: [
  //     Image.asset('images/ic_banner_dot_select.png', fit: BoxFit.fill,width: ScreenUtil().setWidth(8),height:  ScreenUtil().setWidth(8)),
  //     SizedBox(width: 12.0),
  //     Image.asset('images/ic_banner_dot_unselect.png', fit: BoxFit.fill,width: ScreenUtil().setWidth(8),height:  ScreenUtil().setWidth(8)),
  //     SizedBox(width: 12.0),
  //     Image.asset('images/ic_banner_dot_unselect.png', fit: BoxFit.fill,width: ScreenUtil().setWidth(8),height:  ScreenUtil().setWidth(8)),
  //   ]);
  // }

  Widget _buildItem(BuildContext context, int index) {
    // String recommendTitle = "";
    // if (data[index] != null) {
    //   recommendTitle = data[index].name;
    // }

    return GestureDetector(
      onTap: () {
      //   Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      //   return new VideoList();
      // }));
        },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(4)),
        child: Stack(
          children: <Widget>[
            _buildItemImage(index),
            Positioned(
              top: ScreenUtil().setWidth(16),
              left: ScreenUtil().setWidth(16),
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(75),
                height: ScreenUtil().setWidth(32),
                decoration: new BoxDecoration(
                  //背景
                  color: ThemeColors.colorWhite,
                  //设置四周圆角 角度
                  borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(6))),
                ),
                    child:Row(
                        children: <Widget>[
                          Image.asset('images/ic_pro_tag.png',
                              width: ScreenUtil().setWidth(16),
                              height: ScreenUtil().setWidth(16),
                              fit: BoxFit.fill),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text(
                            "Pro Only",
                            style: ThemeStyles.caption2
                          ),
                        ]
                    )

              ),
            ),
            Positioned(
              top: ScreenUtil().setWidth(99),
              left: ScreenUtil().setWidth(24),
              child: Container(
                width: ScreenUtil().setWidth(105),
                height: ScreenUtil().setWidth(73),
                child: Text(
                  "Apple Pastry",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(32),
                      fontFamily: 'SFProText',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemImage(int index) {
    String imgUrl = "";
    if (data[index] != null) {
      imgUrl = "http://i2.chuimg.com/"+data[index].square_image_ident+"?imageView2/1/w/500/h/500/q/90/format/jpg";
    }

    //推荐图片
    return Container(
      height: ScreenUtil().setWidth(285),
      width: ScreenUtil().setWidth(285),
      child:  ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            // placeholder: (context, url) =>
            //     Image.asset('images/placeholder.png', fit: BoxFit.cover),
            // errorWidget: (context, url, error) => Icon(
            //   Icons.error,
            // ),
          ),
        ),
    );
  }
}
