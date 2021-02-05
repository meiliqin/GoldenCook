import 'dart:convert';

import 'package:chinese_food/model/recipe.dart';

class CollectModel {
  bool has_next;
  String next_cursor;
  List<Recipe>recipelist;
  factory CollectModel(jsonStr)  {
    if(jsonStr==null){
      return null;
    }
    if(jsonStr is String){
      print("FeedModel jsonStr is String");
      return new CollectModel.fromJson(json.decode(jsonStr));
    }else {
      print("FeedModel jsonStr is not String");
      return new CollectModel.fromJson(jsonStr);
    }
  }

  CollectModel.fromJson(jsonRes) {
    var cursor=jsonRes['content']['cursor'];
    has_next=cursor['has_next'];
    var recipes=jsonRes['content']['recipes'];
    if(recipes==null){
      return;
    }
    recipelist =  [];
    for (var recipeItem in  recipes){
        Recipe recipe=new Recipe();
        recipe.name=recipeItem['name'];
        recipe.id=recipeItem['id'];
        recipe.name_adj=recipeItem['name_adj'];
        recipe.square_image_url_pattern=recipeItem['square_image']['url_pattern'];
        recipe.square_image_ident=recipeItem['square_image']['ident'];
        recipelist.add(recipe);
      }
    }
  }




