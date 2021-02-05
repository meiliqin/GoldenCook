import 'package:cached_network_image/cached_network_image.dart';
import 'package:chinese_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeItem extends StatelessWidget {
  final Recipe data;

  const RecipeItem({this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapHandler(context, data.id),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(24),
            vertical: ScreenUtil().setWidth(8)),
        child: Stack(
          children: <Widget>[
            _buildImg(context),
            Positioned(
                right: ScreenUtil().setWidth(16),
                bottom: ScreenUtil().setWidth(16),
                child: Image.asset('images/ic_heart_white.png',
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setWidth(24),
                    fit: BoxFit.fill)),
            Positioned(
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
              top: ScreenUtil().setWidth(16),
              child: new Text(
                "spicy chicken cubes with peanuts",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(32),
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.bold),
              ),
            )
            // _buildInfo(data.title, data.avatar_url,data.nickname, data.viewed_amount, data.viewed_amount),
          ],
        ),
      ),
    );
  }

  //点击跳转详情界面
  _onTapHandler(BuildContext context, var id) {
    var data = {"id": id};
    // getDataFromServer(Config.RECIPE_DETAIL_URL, data: data).then((val) {
    //   Routes.navigateTo(context, '/recipeDetail',
    //       params: {'data': convert.jsonEncode(val)});
    // });
  }

  Widget _buildImg(BuildContext context) {
    String imgUrl = "";
    imgUrl = "http://i2.chuimg.com/" +
        data.square_image_ident +
        "?imageView2/1/w/500/h/500/q/90/format/jpg";
    print("recipe ：_buildImg ${imgUrl}");

    return Container(
      width: ScreenUtil().setWidth(343),
      height: ScreenUtil().setWidth(343),
      // padding: EdgeInsets.symmetric(horizontal:  ScreenUtil().setWidth(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Image.asset('images/placeholder_efefef.png', fit: BoxFit.cover),
          // errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }





}
