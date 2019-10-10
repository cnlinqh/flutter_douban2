import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';

class MovieCategorySearch extends StatefulWidget {
  final String style;
  final String country;
  final String year;
  final String special;
  final String sortBy;
  MovieCategorySearch({
    Key key,
    this.style = "全部",
    this.country = "全部",
    this.year = "全部",
    this.special = "全部",
    this.sortBy = "U",
  }) : super(key: key);

  _MovieCategorySearchState createState() => _MovieCategorySearchState();
}

class _MovieCategorySearchState extends State<MovieCategorySearch> {
  String _selectedStyle;
  String _selectedCountry;
  String _selectedYear;
  String _selectedSpecial;

  String _selectedSortBy = "U";
  String _range = "0,10";
  // String _groupValue = "默认";

  static const String _loading = "##loading##";
  var _start = 0;
  var _count = 20;
  var _done = false;
  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  void _retrieveData() async {
    if (_done) {
      return;
    }

    var search = constructSearchString();
    var list = await ClientAPI.getInstance().newSearchSubjects(search);

    if (list.length < this._count) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list.toList());
    _start = _start + list.length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this._selectedStyle = widget.style;
    this._selectedCountry = widget.country;
    this._selectedYear = widget.year;
    this._selectedSpecial = widget.special;
    this._selectedSortBy = widget.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类找电影"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SearchBar(this.sStyleList, this._selectedStyle,
                        this.onStyleChange),
                    SearchBar(this.sCountriesList, this._selectedCountry,
                        this.onCountryChange),
                    SearchBar(
                        this.sYearList, this._selectedYear, this.onYearChange),
                    SearchBar(this.sSpecialList, this._selectedSpecial,
                        this.onSpecialChange),
                    SortBar(onSortByChange, this._selectedSortBy),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  if (_dataList[index]['title'] == _loading) {
                    _retrieveData();
                    return Container();
                  } else {
                    return Container(
                      child: MovieSubjectGeneral(_dataList[index]),
                    );
                  }
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _refresh() {
    _start = 0;
    _done = false;
    _dataList.removeRange(0, _dataList.length - 1);
    setState(() {});
  }

  void onStyleChange(style) {
    _refresh();
  }

  void onCountryChange(country) {
    this._selectedCountry = country;
    _refresh();
  }

  void onYearChange(year) {
    this._selectedYear = year;
    _refresh();
  }

  void onSpecialChange(special) {
    this._selectedSpecial = special;
    _refresh();
  }

  void onSortByChange(sort) {
    this._selectedSortBy = sort;
    _refresh();
  }

  String constructSearchString() {
    print("==================");
    print(this._selectedStyle);
    print(this._selectedCountry);
    print(this._selectedYear);
    print(this._selectedSpecial);
    var search =
        "?start=${this._start}&sort=${this._selectedSortBy}&range=${this._range}";
    if (this._selectedStyle != "全部") {
      search = search + "&genres=${this._selectedStyle}";
    }
    if (this._selectedCountry != "全部") {
      search = search + "&countries=${this._selectedCountry}";
    }
    if (this._selectedYear != "全部") {
      if (this._selectedYear == "2019") {
        search = search + "&year_range=2019,2019";
      } else if (this._selectedYear == "2018") {
        search = search + "&year_range=2018,2018";
      } else if (this._selectedYear == "2010年代") {
        search = search + "&year_range=2010,2017";
      } else if (this._selectedYear == "2000年代") {
        search = search + "&year_range=2000,2009";
      } else if (this._selectedYear == "90年代") {
        search = search + "&year_range=1990,1999";
      } else if (this._selectedYear == "80年代") {
        search = search + "&year_range=1980,1989";
      } else if (this._selectedYear == "70年代") {
        search = search + "&year_range=1970,1979";
      } else if (this._selectedYear == "60年代") {
        search = search + "&year_range=1960,1969";
      } else if (this._selectedYear == "更早") {
        search = search + "&year_range=1900,1959";
      }
    }
    var tags =
        this._selectedSpecial == "全部" ? "电影" : "电影,${this._selectedSpecial}";
    search = search + "&tags=$tags";
    print(search);
    return search;
  }

  void fileSearch() async {
    var search = constructSearchString();
    var obj = await ClientAPI.getInstance().newSearchSubjects(search);
    print(obj);
  }

  var sStyleList = {
    "label": " 类型",
    "list": [
      "全部",
      "剧情",
      "喜剧",
      "动作",
      "爱情",
      "科幻",
      "动画",
      "悬疑",
      "惊悚",
      "恐怖",
      "犯罪",
      "同性",
      "音乐",
      "歌舞",
      "传记",
      "历史",
      "战争",
      "西部",
      "奇幻",
      "冒险",
      "灾难",
      "武侠",
      "情色"
    ],
  };
  var sCountriesList = {
    "label": "地区",
    "list": [
      "全部",
      "中国大陆",
      "美国",
      "中国香港",
      "中国台湾",
      "日本",
      "韩国",
      "英国",
      "法国",
      "德国",
      "意大利",
      "西班牙",
      "印度",
      "泰国",
      "俄罗斯",
      "伊朗",
      "加拿大",
      "澳大利亚",
      "爱尔兰",
      "瑞典",
      "巴西",
      "丹麦"
    ],
  };
  var sYearList = {
    "label": "年代",
    "list": [
      "全部",
      "2019",
      "2018",
      "2010年代",
      "2000年代",
      "90年代",
      "80年代",
      "70年代",
      "60年代",
      "更早"
    ],
  };
  var sSpecialList = {
    "label": "特色",
    "list": ["全部", "经典", "青春", "文艺", "搞笑", "励志", "魔幻", "感人", "女性", "黑帮"],
  };
}

class SortBar extends StatefulWidget {
  final Function onSelectionChange;
  final String defaultSortBy;
  SortBar(this.onSelectionChange, this.defaultSortBy);

  _SortBarState createState() => _SortBarState();
}

class _SortBarState extends State<SortBar> {
  String _sort;
  @override
  void initState() {
    this._sort = widget.defaultSortBy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      height: ScreenUtil.getInstance()
          .setHeight(ScreenSize.movie_cate_search_bar_hight),
      child: Row(
        children: <Widget>[
          Text(
            "排序",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Radio(
            value: "U",
            groupValue: this._sort,
            onChanged: (v) {
              this._sort = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sort = v;
              });
            },
          ),
          Text("默认"),
          Radio(
            value: "T",
            groupValue: this._sort,
            onChanged: (v) {
              this._sort = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sort = v;
              });
            },
          ),
          Text("热度"),
          Radio(
            value: "S",
            groupValue: this._sort,
            onChanged: (v) {
              this._sort = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sort = v;
              });
            },
          ),
          Text("评分"),
          Radio(
            value: "R",
            groupValue: this._sort,
            onChanged: (v) {
              this._sort = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sort = v;
              });
            },
          ),
          Text("时间"),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final list;
  final String defaultSelected;
  final Function onSelectionChange;
  SearchBar(this.list, this.defaultSelected, this.onSelectionChange);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String selectedItem;
  @override
  void initState() {
    super.initState();
    this.selectedItem = widget.defaultSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance()
          .setHeight(ScreenSize.movie_cate_search_bar_hight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              widget.list['label'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list['list'].length,
              itemBuilder: (context, index) {
                return this._buildItem(widget.list['list'][index]);
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.selectedItem = text;
        });
        widget.onSelectionChange(text);
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2),
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2),
          ),
          padding: EdgeInsets.all(
              ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2)),
          decoration: BoxDecoration(
            color:
                this.selectedItem == text ? Colors.greenAccent : Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
