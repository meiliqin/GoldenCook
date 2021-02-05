import 'package:chinese_food/config/theme_colors.dart';
import 'package:chinese_food/home/collect_page.dart';
import 'package:chinese_food/home/history_page.dart';
import 'package:chinese_food/widgets/with_status_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class FavPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavPageState();
  }
}

class FavPageState extends State<FavPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  int _selectedIndex = 0; //当前选中项的索引

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _pageController = new PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithStatusBarLayout(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // _buildSearchBar(),
              // SizedBox(width: ScreenUtil().setWidth(12)),
              _buildTabBar(),
              Expanded(
                child: _buildTabView(),
              )
            ]),
      ),
      backgroundColor: Colors.white,
    );
  }


  _buildTabBar() {
    List<Widget> tabs = [
      _renderTab(0,"Collect"),
      _renderTab(1,"History"),
    ];

    return TabBar(
      tabs:  tabs,
      controller: _tabController,
      indicatorColor: ThemeColors.colorTheme,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
              width: ScreenUtil().setWidth(3), color: ThemeColors.colorTheme),
          insets: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24))),
      onTap: (index) {
        //点击标签切换页面
        _pageController.jumpToPage(index);
      },
    );
  }

  _buildTabView() {
    return new PageView(
      //页面控制器
      controller: _pageController,
      //具体的页面集合
      children: [new CollectPage(), new HistoryPage()],
      onPageChanged: _onPageChange,
    );
  }
  _onPageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
_renderTab(int index,String text) {
  //返回一个标签
  return new Tab(
      child: new Container(
    //设置paddingTop为6
    padding: new EdgeInsets.only(top: 6),
    //一个列控件
    child:
        new Text(
          text,
          style: TextStyle(
              color: index==_selectedIndex?ThemeColors.colorTheme:ThemeColors.textColorA9ABB1,
              fontSize: ScreenUtil().setSp(16),
              fontFamily: 'SFProText',
              fontWeight: FontWeight.bold),
    ),
  ));
}
}
