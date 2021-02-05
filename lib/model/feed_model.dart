import 'dart:convert';

import 'package:chinese_food/model/recipe.dart';

class FeedModel {
  bool has_next;
  String next_cursor;
  List<Feed>feedlist;
  factory FeedModel(jsonStr)  {
    if(jsonStr==null){
      return null;
    }
    if(jsonStr is String){
      print("FeedModel jsonStr is String");
      return new FeedModel.fromJson(json.decode(jsonStr));
    }else {
      print("FeedModel jsonStr is not String");
      return new FeedModel.fromJson(jsonStr);
    }
  }

  FeedModel.fromJson(jsonRes) {
    var cursor=jsonRes['content']['cursor'];
    has_next=cursor['has_next'];
    var feeds=jsonRes['content']['feeds'];
    if(feeds==null){
      return;
    }
    feedlist =  [];
    for (var feedItem in  feeds){
      Feed feed=new Feed();
      feed.type=feedItem['type'];
      if(feed.type==Feed.TYPE_REC){
        List<Recipe>recipeList=[];
        for (var recipeItem in  feedItem['data']['recipes']){
          Recipe recipe=new Recipe();
          recipe.name=recipeItem['name'];
          recipe.name_adj=recipeItem['name_adj'];
          recipe.square_image_ident=recipeItem['square_image']['ident'];
          recipe.square_image_url_pattern=recipeItem['square_image']['url_pattern'];
          recipeList.add(recipe);
        }
        feed.data=recipeList;
        feedlist.add(feed);
      }else if(feed.type==Feed.TYPE_STORIES){
        List<Story>storyList=[];
        for (var storyItem in  feedItem['data']['stories']){
          Story story=new Story();
          story.name=storyItem['name'];
          story.cover_image_ident=storyItem['cover_image']['ident'];
          story.cover_image_url_pattern=storyItem['cover_image']['url_pattern'];
          storyList.add(story);
        }
        feed.data=storyList;
        feedlist.add(feed);
      }else if(feed.type==Feed.TYPE_NORMAL){
        var recipeItem=feedItem['data'];
        Recipe recipe=new Recipe();
        recipe.name=recipeItem['name'];
        recipe.id=recipeItem['id'];
        recipe.name_adj=recipeItem['name_adj'];
        recipe.square_image_url_pattern=recipeItem['square_image']['url_pattern'];
        recipe.square_image_ident=recipeItem['square_image']['ident'];
        feed.data=recipe;
        feedlist.add(feed);
      }
    }
  }

}

class Feed {
 static const  int TYPE_REC=5;//今日推荐
 static const  int TYPE_STORIES=11;//合集
 static const  int TYPE_NORMAL=1;//更多美味item
 int type;
  var data;
}

class Story {
  String name;
  String cover_image_url;
  String cover_image_ident;
  String cover_image_url_pattern;
}


