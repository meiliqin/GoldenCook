
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chinese_food/http/api_service.dart';
import 'package:chinese_food/model/collect_model.dart';
import 'package:chinese_food/model/recipe.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CollectPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CollectPageState();
  }

}

class CollectPageState extends State<CollectPage> {

  CollectModel _collectModel = null;

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    if (_collectModel == null || _collectModel.recipelist==null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(24),ScreenUtil().setWidth(16),0,0),
      child: Wrap(
        spacing: ScreenUtil().setWidth(23),
        runSpacing: ScreenUtil().setWidth(20),
        children: _collectModel.recipelist
            .map<Widget>(
              (it) => _buildRecipeItem(context, it),
        )
            .toList(),
      ),
    );
  }

  Widget _buildRecipeItem(BuildContext context, Recipe recipe) {
    return Container(
      width: ScreenUtil().setWidth(152),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
              child: CachedNetworkImage(
                width: ScreenUtil().setWidth(152),
                height: ScreenUtil().setWidth(140),
                imageUrl: recipe.getCover(),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(7)),
            Text(
              " ${recipe.name}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }

  Future<Null> getData() async {
    ApiService().getCollectRecipe((CollectModel collectModel) {
      if (collectModel.recipelist != null) {
        print("CollectModel getData ${collectModel.recipelist.length}");
        // showContent();
        setState(() {
          _collectModel = collectModel;

        });
      } else {
        // showEmpty();
      }
    }, (DioError error) {
      print(error.response);
      setState(() {
        // showError();
      });
    });
  }
}