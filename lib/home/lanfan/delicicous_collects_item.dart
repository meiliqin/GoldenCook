import 'package:cached_network_image/cached_network_image.dart';
import 'package:chinese_food/config/config.dart';
import 'package:chinese_food/config/theme_styles.dart';
import 'package:chinese_food/http/api_service.dart';
import 'package:chinese_food/model/feed_model.dart';
import 'package:chinese_food/model/recommend_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'dart:convert' as convert;

import '../recipe_pic_text_page.dart';

class DeliciousCollectsItem extends StatelessWidget {
  final List<Story> data;

  const DeliciousCollectsItem({this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(context),
          Container(
            height: ScreenUtil().setWidth(150),
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(33-4), ScreenUtil().setWidth(11), 0, 0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, index);
              },
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
            ),
          )
        ]);
  }
  Widget _buildTitle(BuildContext context) {
    return Container(
        child: new Text(
          "Categories",
          style: ThemeStyles.headline1,
        ),
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(33), ScreenUtil().setWidth(27), 0, 0));
  }
  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new RecipePicTextPage();
        }));
      }, // => _goToRecipeDetail(context, item),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_buildItemImage(index), _buildInfo(index)],
        ),
      ),
    );
  }

  Widget _buildItemImage(int index) {
    String imgUrl = "";
    if (data[index] != null) {
      imgUrl = "http://i2.chuimg.com/" +
          data[index].cover_image_ident +
          "?imageView2/1/w/500/h/500/q/90/format/jpg";
    }
    //推荐图片
    return Container(
      height: ScreenUtil().setWidth(120),
      width: ScreenUtil().setWidth(120),
      // child: ColorFiltered(
      //   colorFilter: ColorFilter.mode(Colors.grey[200], BlendMode.modulate),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Image.asset('images/placeholder_efefef.png', fit: BoxFit.fill),
            // errorWidget: (context, url, error) => Icon(
            //   Icons.error,
            //   color: Colors.white,
            // ),
          ),
      //  ),
      ),
    );
  }

  Widget _buildInfo(int index) {
    //推荐图片的info
    return Container(
        child: Text(
          "Sweet Tooth",
          // overflow: TextOverflow.ellipsis,
          style: ThemeStyles.subheadline1,
        ),
        margin: EdgeInsets.fromLTRB(0, ScreenUtil().setWidth(8), 0, 0));
  }
}
