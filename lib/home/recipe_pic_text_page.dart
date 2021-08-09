import 'package:cached_network_image/cached_network_image.dart';
import 'package:chinese_food/config/theme_colors.dart';
import 'package:chinese_food/http/api.dart';
import 'package:chinese_food/http/api_service.dart';
import 'package:chinese_food/model/recipe_detail_model.dart';
import 'package:chinese_food/widgets/floatingActionButton/CustomFloatingActionButtonLocation.dart';
import 'package:chinese_food/widgets/floatingActionButton/NoAnimation.dart';
import 'package:chinese_food/widgets/video_player_recipe.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/screenutil.dart';

class RecipePicTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecipePicTextPageState();
  }
}

class RecipePicTextPageState extends State<RecipePicTextPage> {
  RecipeDetailModel _recipeDetailModel = null;
  ScrollController _scrollController;
  FloatingActionButton _floatingActionButton;
  RecipeVideoPlayer _headVideoPlayer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() => setState(() {
            print(
                'Scroll view Listener is called offset ${_scrollController.offset}');
          }));

    _floatingActionButton = new FloatingActionButton(
        child: Image.asset('images/ic_heart.png',
            width: ScreenUtil().setWidth(20),
            height: ScreenUtil().setWidth(20),
            fit: BoxFit.fill),
        backgroundColor: ThemeColors.colorTheme,
        onPressed: () {});

    getData();
  }

  @override
  void dispose() {
    //  _headVideoPlayer.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          new SliverAppBar(
            // title: Text("标题"),
            expandedHeight: ScreenUtil().screenWidth,
            floating: false,
            pinned: true,
            snap: false,
            backgroundColor: ThemeColors.colorTheme,
            actions: <Widget>[
              new IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  print("更多");
                },
              ),
            ],
            flexibleSpace: new FlexibleSpaceBar(
              background:
              _headVideoPlayer=RecipeVideoPlayer(),

              // Image.asset("images/placeholder_efefef.png",
              //     fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildRecipeInfo(),
                  _buildDivider(),
                  _buildIngredients(),
                  _buildDivider(),
                  _buildDirections(),
                  // _buildDivider(),
                  // RecipeVideoPlayer(),

                ]),
          )
        ],
      ),
      floatingActionButton: Container(
        child: _floatingActionButton,
        height: ScreenUtil().setWidth(56),
        width: ScreenUtil().setWidth(56),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.endTop, 0, ScreenUtil().setWidth(228)),
      floatingActionButtonAnimator: NoScalingAnimation(),
    );
  }

  _buildDivider() {
    return Divider(
      thickness: ScreenUtil().setWidth(1),
      color: ThemeColors.colorDivider,
      indent: ScreenUtil().setWidth(24),
      endIndent: ScreenUtil().setWidth(24),
    );
  }

  _buildRecipeInfo() {
    return new Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _recipeDetailModel != null
                ? _recipeDetailModel.title
                : "Marinated Steak",
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(32),
                fontFamily: 'SFProText',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: ScreenUtil().setWidth(24)),
          Row(
            children: [
              _buildLabelText("15m"),
              SizedBox(width: ScreenUtil().setWidth(8)),
              _buildLabelText("Easy"),
            ],
          ),
          // SizedBox(height: ScreenUtil().setWidth(24)),
          // Text(
          //   "A wonderful flank steak on the grill recipe I invented that friends just love My girls think this is great,and it doesn't take long to girl.This also works great when sliced and used for fajitas",
          //   style: TextStyle(
          //       color: Colors.black,
          //       fontSize: ScreenUtil().setSp(16),
          //       fontFamily: 'SFProText',
          //       fontWeight: FontWeight.normal,
          //       height: 1.5),
          // ),
        ],
      ),
    );
  }

  _buildIngredients() {
    return new Container(
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(24),
          ScreenUtil().setWidth(34),
          ScreenUtil().setWidth(24),
          ScreenUtil().setWidth(32)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _createIngredientsChildren()
          //<Widget>[
          //
          //   SizedBox(height: ScreenUtil().setWidth(16)),
          //   Text(
          //     "1/2 cup vegetable oil\n" +
          //         "1/3 cup soy sauce\n" +
          //         "1/4 cup red wine vinegar\n" +
          //         "1/2 tablespoons Worcestershire sauce\n" +
          //         "1 tablespoon Dijon mustard2 cloves garlic,minced\n" +
          //         "1/2 teaspoon ground black pepper\n" +
          //         "1/2 pounds flank steak",
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontSize: ScreenUtil().setSp(16),
          //         fontFamily: 'SFProText',
          //         fontWeight: FontWeight.normal,
          //         height: 1.5),
          //   ),
          // ],
          ),
    );
  }

  _buildDirections() {
    return new Container(
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(24),
          ScreenUtil().setWidth(34),
          ScreenUtil().setWidth(24),
          ScreenUtil().setWidth(32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _createInstructionChildren(),
      ),
    );
  }

  List<Widget> _createIngredientsChildren() {
    List<Widget> widgets = new List<Widget>();
    if (_recipeDetailModel == null ||
        _recipeDetailModel.ingredientList == null) {
      return widgets;
    }

    widgets.add(Text(
      "Ingredients",
      style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(24),
          fontFamily: 'SFProText',
          fontWeight: FontWeight.bold,
          height: 1.5),
    ));
    widgets.add(SizedBox(height: ScreenUtil().setWidth(16)));
    int ingredientIndex = 0;
    for (Ingredient ingredient in _recipeDetailModel.ingredientList) {
      ingredientIndex++;
      widgets.add(_buildIng(ingredient));
    }
    return widgets;
  }

  List<Widget> _createInstructionChildren() {
    List<Widget> widgets = new List<Widget>();
    if (_recipeDetailModel == null || _recipeDetailModel.stepList == null) {
      return widgets;
    }
    widgets.add(Text(
      "Directions",
      style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(24),
          fontFamily: 'SFProText',
          fontWeight: FontWeight.bold,
          height: 1.5),
    ));

    int stepIndex = 0;
    for (Instruction instruction in _recipeDetailModel.stepList) {
      stepIndex++;
      widgets.add(_buildStep(stepIndex, instruction));
    }
    return widgets;
  }

  _buildLabelText(var text) {
    return Container(
      height: ScreenUtil().setWidth(40),
      width: ScreenUtil().setWidth(64),
      alignment: Alignment.center,
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: ThemeColors.colorLabelBg,
        //设置四周圆角 角度
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setWidth(6))),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(14),
            fontFamily: 'SFProText',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildIng(Ingredient ingredient) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.name,
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(16),
              fontFamily: 'SFProText',
              fontWeight: FontWeight.normal,
              height: 1.5),
        ),
        Text(
          ingredient.amount,
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(16),
              fontFamily: 'SFProText',
              fontWeight: FontWeight.normal,
              height: 1.5),
        ),
      ],
    );
  }

  _buildStep(int index, Instruction instruction) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setWidth(16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipOval(
                child: Container(
                  height: ScreenUtil().setWidth(24),
                  width: ScreenUtil().setWidth(24),
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    //背景
                    color: ThemeColors.colorTheme,
                  ),
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(16),
                        fontFamily: 'SFProText',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(10),
              ),
              Expanded(
                  child: Text(
                // "A wonderful flank steak on the grill recipe I invented that friends just love My girls think this is great,and it doesn't take long to girl.This also works great when sliced and used for fajitas",
                instruction.text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(16),
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.normal,
                    height: 1.5),
              )),
            ],
          ),
          // RecipeVideoPlayer(),
          SizedBox(height: ScreenUtil().setWidth(10)),
          Container(
            width: ScreenUtil().setWidth(343),
            height: ScreenUtil().setWidth(343),
            // padding: EdgeInsets.symmetric(horizontal:  ScreenUtil().setWidth(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: Api.convetChuimgSize500(instruction.img),
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                    'images/placeholder_efefef.png',
                    fit: BoxFit.cover),
                // errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          )
        ]);
  }

  Future<Null> getData() async {
    ApiService().getRecipeDetail((RecipeDetailModel recipeDetailModel) {
      if (recipeDetailModel.stepList != null &&
          recipeDetailModel.ingredientList != null) {
        print("RecipeDetailModel getData ${recipeDetailModel.stepList.length}");
        // showContent();
        setState(() {
          _recipeDetailModel = recipeDetailModel;
          print(
              "RecipeDetailModel getData2 ${_recipeDetailModel.stepList.length}");
        });
      } else {
        // showEmpty();
      }
    }, (DioError error) {
      print(error.response);
      setState(() {
        // showError();
      });
    }, 0);
  }
}
