import 'package:flutter/material.dart';
import 'package:flutter_douban2/tv/tv_list_view.dart';

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
