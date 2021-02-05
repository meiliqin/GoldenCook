import 'dart:convert';


class SearchHotModel {
  List<HotWord>hotWordList;

  factory SearchHotModel(jsonStr) {
    if (jsonStr == null) {
      return null;
    }
    if (jsonStr is String) {
      print("SearchHotModel jsonStr is String");
      return new SearchHotModel.fromJson(json.decode(jsonStr));
    } else {
      print("SearchHotModel jsonStr is not String");
      return new SearchHotModel.fromJson(jsonStr);
    }
  }

  SearchHotModel.fromJson(jsonRes) {
    var hotWords = jsonRes['content']['keywords'];
    if (hotWords == null) {
      return;
    }
    hotWordList = [];
    for (var hotWordItem in hotWords) {
      HotWord hotWord = new HotWord();
      hotWord.query = hotWordItem['query'];
      hotWord.text = hotWordItem['text'];
      hotWordList.add(hotWord);
    }
  }
}
 class HotWord {
  String query;
  String text;
}




