import 'package:cached_network_image/cached_network_image.dart';
import 'package:chinese_food/base/base_widget.dart';
import 'package:chinese_food/config/theme_colors.dart';
import 'package:chinese_food/http/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:chinese_food/model/search_hot_model.dart';

class SearchPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return SearchPageState();
  }
}

class SearchPageState extends BaseWidgetState<SearchPage> {
  List<HotWord>_hotWordList;
  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("不显示"),
    );
  }

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
    getData();
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSearchBar(),
            _buildHotTitleText(context),
            SizedBox(width: ScreenUtil().setWidth(12)),
            _buildHotWords(context),
          ]),
      backgroundColor: Colors.white,
    );
  }

  _buildSearchBar() {
    return Container(
      height: ScreenUtil().setWidth(48),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(24),
          ScreenUtil().setWidth(16),
          ScreenUtil().setWidth(24),
          ScreenUtil().setWidth(12)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ThemeColors.colorSearchBar),
      child: Row(
        children: <Widget>[
          SizedBox(width: ScreenUtil().setWidth(13)),
          Icon(
            Icons.search,
            color: ThemeColors.color6B6C76,
            size: ScreenUtil().setWidth(18),
          ),
          SizedBox(width: ScreenUtil().setWidth(4)),
          Text(
            "Search for recipes",
            style: TextStyle(
              color: ThemeColors.color898989,
              fontFamily: 'SFProText',
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(16),
            ),
          ),
        ],
      ),
    );
  }

  //热搜关键字
  Widget _buildHotWords(context) {
    if (_hotWordList == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
        alignment: Alignment.centerLeft,
        child: buildChildren(),
    );
  }

  Widget _buildHotTitleText(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(24),0,0,ScreenUtil().setWidth(12)),
      child: Text(
        "Popular searches",
        style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(16),
            fontFamily: 'SFProText',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildChildren() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var item in _hotWordList) {
      tiles.add(
        new Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: ThemeColors.colorTheme,
          label: Text(
            item.text,
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(16),
                fontFamily: 'SFProText',
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    content = Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.start,
        children: tiles);

    return content;
  }


  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
  Future<Null> getData() async {
    ApiService().getHotSearchWord((SearchHotModel searchHotModel) {
      if (searchHotModel.hotWordList != null) {
        setState(() {
          _hotWordList = searchHotModel.hotWordList;

        });
      }
    }, (DioError error) {
      print(error.response);
    });
  }
}
