import 'dart:convert';

import 'package:chinese_food/base/base_widget.dart';
import 'package:chinese_food/config/theme_colors.dart';
import 'package:chinese_food/config/theme_styles.dart';
import 'package:chinese_food/home/lanfan/delicicous_collects_item.dart';
import 'package:chinese_food/home/lanfan/today_recommend_item.dart';
import 'package:chinese_food/http/api_service.dart';
import 'package:chinese_food/model/feed_model.dart';
import 'package:chinese_food/widgets/with_status_bar_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:dio/dio.dart';

import 'lanfan/recipe_item.dart';

class DiscoverPage extends  StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DiscoverPageState();
  }
}

class DiscoverPageState extends State<DiscoverPage> {
  List<Feed> _datas = new List();

  //listview控制器
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  int _page = 0;

  @override
  void initState() {
    super.initState();

    getData();

    _scrollController.addListener(() {
      //滑到了底部，加载更多
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }

      //当前位置是否超过屏幕高度
      if (_scrollController.offset < 200 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithStatusBarLayout(
        child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg_main_style.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: RefreshIndicator(
            displacement: 15,
            onRefresh: getData,
            child: ListView.separated(
                itemBuilder: _renderRow,
                physics: new AlwaysScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 0,
                  );
                },
                controller: _scrollController,
                //包含轮播图和加载更多
                itemCount: _datas.length + 3),
          ),
        ),
        layoutOverlapStatus: true,
        // backgroundColor: Colors.white,//不知为何base-widget中设置背景不起作用,应在脚手架中再配置一次
      ),);
  }
  Widget _renderRow(BuildContext context, int index) {
    if (index == 0) {
      return Container(
          child: Row(
            children: <Widget>[
          Image.asset('images/ic_app_gradient.png',
              width: ScreenUtil().setWidth(50),
              height: ScreenUtil().setWidth(50),
              fit: BoxFit.fill),
              SizedBox(width: ScreenUtil().setWidth(13)),
          Text(
            "That Recipe",
            style: TextStyle(
                color: ThemeColors.textColor444444,
                fontSize: ScreenUtil().setSp(32),
                //字体看起来不支持
                fontFamily: 'Gilroy-Bold',
                fontWeight: FontWeight.bold),
          ),
          ]),
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(32), ScreenUtil().setWidth(75), 0, 0));
    }

    if (index == 1 && _datas.length>0) {
      return Container(
        // height: ScreenUtil().setWidth(285),
        child:  TodayRecommendItem(data: _datas[0].data,),
      );
    }


    if (index == 2) {
      return Container(
        // height: ScreenUtil().setWidth(200),
        child:  DeliciousCollectsItem(data: _datas[1].data,),
      );
    }

    if (index == 3) {
      return Container(
          child: new Text(
            "More Delicicous",
            style: ThemeStyles.headline1,
          ),
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(33),
              ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(8)));
    }

    print("recipe ：_renderRow index=${index} _datas.length =${_datas.length}");

    if (index - 2 < _datas.length  && index-2>=0) {
      return RecipeItem(
        data: _datas[index - 2].data,
      );
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }


  //获取菜谱列表数据
  Future<Null> getData() async {
    _page = 0;
    ApiService().getFeedList((FeedModel _feedModel) {
      if (_feedModel.feedlist != null) {
          //有数据
          setState(() {
            _datas.clear();
            _datas.addAll(_feedModel.feedlist);
            print("recipe ：getData datas.length ${_datas.length}");
          });

      } else {
        //没有拿到数据
       // showEmpty();
      }
    }, (DioError error) {
      //发生错误
      print(error.response);
      setState(() {
       // showError();
      });
    }, _page);
  }

  //加载更多的数据
  Future<Null> _getMore() async {
    _page++;
    // ApiService().getRecipeList((RecipeModel _recipeModel) {
    //   if (_recipeModel.code != null) {
    //     //成功
    //     if (_recipeModel.data.length > 0) {
    //       //有数据
    //       showContent();
    //       setState(() {
    //         _datas.addAll(_recipeModel.data);
    //       });
    //     } else {
    //       //数据为空
    //       Fluttertoast.showToast(msg: "没有更多数据了");
    //     }
    //   } else {
    //     Fluttertoast.showToast(msg: _recipeModel.msg);
    //   }
    // }, (DioError error) {
    //   //发生错误
    //   print(error.response);
    //   setState(() {
    //     showError();
    //   });
    // }, _page);
  }

}
