import 'dart:convert' show json;

class RecommendModel {

  String code;
  String msg;
  List<RecommendData> recommendData;

  RecommendModel.fromParams({this.code, this.msg, this.recommendData});

  factory RecommendModel(jsonStr)  {
    if(jsonStr==null){
      return null;
    }

    if(jsonStr is String){
      print("RecommendModel jsonStr is String");
      return new RecommendModel.fromJson(json.decode(jsonStr));
    }else {
      print("RecommendModel jsonStr is not  String");
      return new RecommendModel.fromJson(jsonStr);
    }
  }

  RecommendModel.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    recommendData = jsonRes['data'] == null ? null : [];

    for (var dataItem in  jsonRes['data']){
      if(dataItem['video_info']!=null){
        for (var item in dataItem['video_info']){
          recommendData.add( new RecommendData.fromJson(item));
        }
      }
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $recommendData}';
  }
}

class RecommendData {
  String id;
  String title;
  String date;
  String recommend_title;
  String jump;
  String img;
  String nickname;
  String avatar_url="";

  RecommendData.fromParams({this.id, this.title, this.date, this.recommend_title, this.jump});

  RecommendData.fromJson(jsonRes) {
    id = jsonRes['id'];
    title = jsonRes['title'];
    date = jsonRes['date'];
    recommend_title = jsonRes['recommend_title'];
    jump = jsonRes['jump'];
    if(jsonRes['video']!=null){
      img=jsonRes['video']['img'];
    }
    if(jsonRes['author']!=null){
      nickname=jsonRes['author']['nickname'];
      avatar_url=jsonRes['author']['avatar_url'];
    }
  }

  @override
  String toString() {
    return '{"id": $id,"title": $title,"date": $date,"recommend_title": $recommend_title,"jump": ${jump}';
  }
}

