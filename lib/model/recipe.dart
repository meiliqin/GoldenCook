class Recipe {
  String name;
  int id;
  String square_image_url;
  String square_image_ident;
  String square_image_url_pattern;
  String name_adj;

  String getCover() {
    String imgUrl = "http://i2.chuimg.com/" +
        square_image_ident +
        "?imageView2/1/w/500/h/500/q/90/format/jpg";
    return imgUrl;
  }
}
