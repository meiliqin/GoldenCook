import 'dart:convert';

class RecipeDetailModel {
  String title;
  String vurl;
  List<Ingredient>ingredientList;
  List<Instruction>stepList;

  factory RecipeDetailModel(jsonStr) {
    if (jsonStr == null) {
      return null;
    }
    if (jsonStr is String) {
      print("RecipeDetailModel jsonStr is String");
      return new RecipeDetailModel.fromJson(json.decode(jsonStr));
    } else {
      print("RecipeDetailModel jsonStr is not String");
      return new RecipeDetailModel.fromJson(jsonStr);
    }
  }

  RecipeDetailModel.fromJson(jsonRes) {
    print("RecipeDetailModel fromJson0");

    title = jsonRes['title'];
    vurl = jsonRes['vurl'];
    var ingredients = jsonRes['ings'];
    if (ingredients == null) {
      return;
    }
    print("RecipeDetailModel fromJson1");
    ingredientList = [];
    for (var ingredientItem in ingredients) {
      Ingredient ingredient = new Ingredient();
      ingredient.name = ingredientItem['name'];
      ingredient.amount = ingredientItem['amount'];
      ingredientList.add(ingredient);
    }
    print("RecipeDetailModel fromJson2");

    var steps = jsonRes['instructions'];
    if (steps == null) {
      return;
    }
    print("RecipeDetailModel fromJson3");

    stepList = [];
    for (var stepItem in steps) {
      Instruction step = new Instruction();
      step.img = stepItem['img'];
      step.vurl = stepItem['vurl'];
      step.text = stepItem['text'];
      stepList.add(step);
      print("RecipeDetailModel step.text ${step.text}");

    }
  }

}

class Ingredient {
  String name;
  String amount;

}

class Instruction {
  String img;
  String vurl;
  String text;
}


