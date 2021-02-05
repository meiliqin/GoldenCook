import 'dart:convert';

// import 'package:chinese_food/backup/recipe_model.dart';
import 'package:chinese_food/http/user.dart';
import 'package:chinese_food/model/collect_model.dart';
import 'package:chinese_food/model/feed_model.dart';
import 'package:chinese_food/model/recipe_detail_model.dart';
import 'package:chinese_food/model/recommend_model.dart';
import 'package:chinese_food/model/search_hot_model.dart';
import 'package:dio/dio.dart';


import 'api.dart';
import 'dio_manager.dart';

class ApiService {
  void getTodayRecommend(Function callback) async {
    DioManager.singleton.dio
        .get(Api.TODAY_RECOMMEND, options: _getOptions())
        .then((response) {
      callback(RecommendModel(response.data));
    });
  }

  // void getRecipeList(Function callback, Function errorback, int _page) async {
  //   DioManager.singleton.dio
  //       .get(Api.RECIPE_LIST+"&page=$_page", options: _getOptions())
  //       // .get(Api.RECIPE_LIST, options: _getOptions())
  //       .then((response) {
  //     callback(RecipeModel(response.data));
  //   }).catchError((e) {
  //     errorback(e);
  //   });
  // }

  void getFeedList(Function callback, Function errorback,int _page) async {
    DioManager.singleton.dio
        .get(Api.LANFAN_FEED, options: _getOptions())
        .then((response) {
      callback(FeedModel(response.data));
    }).catchError((e) {
      errorback(e);
    });
  }

  void getRecipeDetail(Function callback, Function errorback,int id){
    DioManager.singleton.dio
        .get(Api.RECIPE_DETAIL, options: _getOptions())
        .then((response) {
      callback(RecipeDetailModel(response.data));
    }).catchError((e) {
      errorback(e);
    });
  }

  void getCollectRecipe(Function callback, Function errorback){
    DioManager.singleton.dio
        .get(Api.LANFAN_COLLECT, options: _getOptions())
        .then((response) {
      callback(CollectModel(response.data));
    }).catchError((e) {
      errorback(e);
    });
  }

  void getHotSearchWord(Function callback, Function errorback){
    DioManager.singleton.dio
        .get(Api.SEARCH_HOT_WORDS, options: _getOptions())
        .then((response) {
      callback(SearchHotModel(response.data));
    }).catchError((e) {
      errorback(e);
    });
  }
  // void getHotSearchWord(Function callback)  async{
  //   DioManager.singleton.dio
  //       .get(Api.SEARCH_HOT_WORDS, options: _getOptions())
  //       .then((response) {
  //     var ret;
  //     // print("getHotSearchWord response："+response.toString());
  //     if(response.data is String){
  //           // print("getHotSearchWord jsonStr is String");
  //           ret = json.decode(response.data);
  //         }else{
  //           // print("getHotSearchWord jsonStr is not String");
  //           ret=response.data['data'];
  //         }
  //     callback(ret);
  //   });
  // }

  Options _getOptions() {
    Map<String, String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers: map);
  }



}
