import 'package:chinese_food/config/theme_colors.dart';
import 'package:chinese_food/home/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'discover_page.dart';
import 'fav_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  BottomNavigationBar _navigationBar;
  PageView _pageView;
  PageController _pageController;

  // AppBar _appBar;
  int _selectedIndex = 0; //当前选中项的索引

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));

    //选择按下处理 设置当前索引为index值
    _onPageChange(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    _navigationBar = BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: new Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.search), title: new Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), title: new Container()),
      ],
      type: BottomNavigationBarType.fixed,
      //设置显示的模式
      currentIndex: _selectedIndex,
      //当前选中项的索引
      elevation: 4,
      backgroundColor: Colors.white,
      onTap: (index) {
        _pageController.jumpToPage(index);
        //     _onPageChange(index);
      },
      fixedColor: ThemeColors.colorTheme,
    );

    _pageView = new PageView.builder(
      itemBuilder: (context, i) {
        print("home index:${i}");
        switch (i) {
          case 0:
            return DiscoverPage();
            break;
          case 1:
            return SearchPage();
            break;
          case 2:
            return FavPage();
            break;
        }
        return null;
      },
      controller: _pageController,
      onPageChanged: _onPageChange,
      itemCount: 3,
    );

    return new Scaffold(
        bottomNavigationBar: _navigationBar,
        body: _pageView,
        // appBar: _appBar,
        );
  }
}
