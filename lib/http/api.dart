
class Api{
  static const String TODAY_RECOMMEND = "https://newapi.meishi.cc/index/home_recommend_7_1_3?source=android&format=json&fc=msjandroid&lat=22.231348&lon=113.27846&cityCode=140&token=";

  static const String RECIPE_LIST = "http://newapi.meishi.cc/index/home_feeds_7_1_3?source=android&format=json&fc=msjandroid&lat=22.231348&lon=113.27846&cityCode=140";

  // static const String SEARCH_HOT_WORDS = "https://newapi.meishi.cc/search/hot_words?source=android&format=json&fc=msjandroid&lat=22.231214&lon=113.278212&cityCode=140&token=";
  static const String SEARCH_HOT_WORDS="https://lanfanapp.com/api/v1/search/hot_keywords_v2.json?api_key=9481a0b378dab3eea170c8d093b3129a&origin=android&os_version=29&version_code=218&current_user_id=4281235&sk=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MDI0OTY2NjksInNlc3Npb25faWQiOjUyMzkyMjEsInVzZXJfaWQiOjQyODEyMzUsInVzZXJfbmFtZSI6Ilx1Njg4NVx1N2FjYlx1NzQzNCJ9.oCJMX38P02jBxnWN0jZp9JMue-SuEHNFkEfis6pA2pw&webp=1&api_sign=2758ed284c2da9948a83311ff13704ba&version=1.8.5&_ts=1609827265&timestamp=1609827265";

  static const  String LANFAN_FEED="https://lanfanapp.com/api/v1/feed/order_by_release_time.json?origin=android&os_version=29&version_code=216&current_user_id=4331345&webp=1&api_sign=02ff7e81b5f2cf04bad35a2ba55f1545&version=1.8.3&size=10&api_key=9481a0b378dab3eea170c8d093b3129a&sk=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MDMzNTI1MzQsInNlc3Npb25faWQiOjUzMDc2MTUsInVzZXJfaWQiOjQzMzEzNDUsInVzZXJfbmFtZSI6Ilx1NjI0Ylx1NjczYVx1NzUyOFx1NjIzN19NTzBScSJ9.uMdIFuIZDe2kPtaluprOC2SvUUAcG3-kTR6-s1CdMHQ&group=B&_ts=1605183898&timestamp=1605183898";

  static const  String LANFAN_COLLECT="https://lanfanapp.com/api/v1/recipe_collect/page_collected_recipes.json?size=50&api_key=9481a0b378dab3eea170c8d093b3129a&origin=android&os_version=29&version_code=218&current_user_id=4281235&sk=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MDI0OTY2NjksInNlc3Npb25faWQiOjUyMzkyMjEsInVzZXJfaWQiOjQyODEyMzUsInVzZXJfbmFtZSI6Ilx1Njg4NVx1N2FjYlx1NzQzNCJ9.oCJMX38P02jBxnWN0jZp9JMue-SuEHNFkEfis6pA2pw&webp=1&api_sign=8f1e518b8c3909cb7eb30153edc685fa&version=1.8.5&_ts=1609817430&timestamp=1609817430";

  static const String RECIPE_DETAIL = "https://www.cc-cook.com/api/v_recipeinfo.jsp?recipeid=3a21ee96a86e25df";

  static convetChuimgSize500(String url){
    return url+ "?imageView2/1/w/500/h/500/q/90/format/jpg";
  }

}