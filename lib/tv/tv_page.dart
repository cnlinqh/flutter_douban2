import 'package:flutter/material.dart';
import 'package:flutter_douban2/model/tv_list_model.dart';
import 'package:flutter_douban2/tv/tv_list_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';

class TVPage extends StatefulWidget {
  _TVPageState createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> with SingleTickerProviderStateMixin {
  TabController controller;
  var tabs = <Tab>[
    Tab(
      text: "热门",
    ),
    Tab(
      text: "美剧",
    ),
    Tab(
      text: "英剧",
    ),
    Tab(
      text: "韩剧",
    ),
    Tab(
      text: "日剧",
    ),
    Tab(
      text: "国产剧",
    ),
    Tab(
      text: "港剧",
    ),
    Tab(
      text: "日本动画",
    ),
    Tab(
      text: "综艺",
    ),
    Tab(
      text: "纪录片",
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: this.tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("豆瓣电视剧"),
        actions: _buildActions(),
        bottom: new TabBar(
          tabs: this.tabs,
          controller: controller,
          isScrollable: true,
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: _buildViews(),
      ),
    );
  }

  List<Widget> _buildActions() {
    List<Widget> actions = [
      Consumer<TVListModel>(
        builder: (context, model, widget) {
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.only(
                left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
              ),
              child: Icon(model.mode == "ListView" ? Icons.apps : Icons.chrome_reader_mode),
            ),
            onTap: () {
              model.mode = model.mode == "ListView" ? 'GridView' : 'ListView';
            },
          );
        },
      ),
      ScreenSize.buildHDivider(),
      Consumer<TVListModel>(
        builder: (context, model, widget) {
          return Center(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Text("推荐"),
                  value: 'recommend',
                ),
                DropdownMenuItem(
                  child: Text("时间"),
                  value: 'time',
                ),
                DropdownMenuItem(
                  child: Text("评分"),
                  value: 'rank',
                ),
              ],
              value: model.sort,
              onChanged: (sort) {
                if (model.sort != sort) {
                  model.sort = sort;
                }
              },
              elevation: 24,
              isDense: false,
              iconSize: 30,
            ),
          );
        },
      ),
      ScreenSize.buildHDivider(),
      IconButton(
        icon: Icon(Icons.category),
        onPressed: () {
          NavigatorHelper.pushToPage(
            context,
            LabelConstant.MOVIE_CATEGORY_TITLE,
            content: MovieCategorySearchPage(
              tag: '电视剧',
            ),
          );
        },
      ),
      ScreenSize.buildHDivider(),
      IconButton(
        icon: Icon(Icons.sort),
        onPressed: () {
          NavigatorHelper.pushToPage(
            context,
            LabelConstant.TV_ENTRANCE_SELECT_ICON,
          );
        },
      )
    ];
    return actions;
  }

  List<Widget> _buildViews() {
    List<Widget> list = [];
    this.tabs.forEach((tab) {
      list.add(TVListView(tab.text));
    });
    return list;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
