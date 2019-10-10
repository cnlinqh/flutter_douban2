import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/movie/movie_category_search_bar.dart';
import 'package:flutter_douban2/movie/movie_category_sort_bar.dart';
import 'package:flutter_douban2/movie/movie_category_range_bar.dart';

class MovieCategorySearch extends StatefulWidget {
  final String style;
  final String country;
  final String year;
  final String special;
  final String sortBy;
  final int rangeMin;
  final int rangeMax;
  MovieCategorySearch({
    Key key,
    this.style = LabelConstant.MOVIE_CATEGORY_ALL,
    this.country = LabelConstant.MOVIE_CATEGORY_ALL,
    this.year = LabelConstant.MOVIE_CATEGORY_ALL,
    this.special = LabelConstant.MOVIE_CATEGORY_ALL,
    this.sortBy = "U",
    this.rangeMin = 0,
    this.rangeMax = 10,
  }) : super(key: key);

  _MovieCategorySearchState createState() => _MovieCategorySearchState();
}

class _MovieCategorySearchState extends State<MovieCategorySearch> {
  String _selectedStyle;
  String _selectedCountry;
  String _selectedYear;
  String _selectedSpecial;

  String _selectedSortBy;
  int _selectedRangeMin;
  int _selectedRangeMax;

  static const String _loading = "##loading##";
  var _start = 0;
  var _count = 20;
  var _done = false;
  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  @override
  void initState() {
    super.initState();
    this._selectedStyle = widget.style;
    this._selectedCountry = widget.country;
    this._selectedYear = widget.year;
    this._selectedSpecial = widget.special;
    this._selectedSortBy = widget.sortBy;
    this._selectedRangeMin = widget.rangeMin;
    this._selectedRangeMax = widget.rangeMax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LabelConstant.MOVIE_CATEGORY_TITLE),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    MovieCategorySearchBar(
                      LabelConstant.sStyleList,
                      this._selectedStyle,
                      this.onStyleChange,
                    ),
                    MovieCategorySearchBar(
                      LabelConstant.sCountriesList,
                      this._selectedCountry,
                      this.onCountryChange,
                    ),
                    MovieCategorySearchBar(
                      LabelConstant.sYearList,
                      this._selectedYear,
                      this.onYearChange,
                    ),
                    MovieCategorySearchBar(
                      LabelConstant.sSpecialList,
                      this._selectedSpecial,
                      this.onSpecialChange,
                    ),
                    MovieCategorySortBar(
                      onSortByChange,
                      this._selectedSortBy,
                    ),
                    MovieCategoryRangeBar(
                      onRangeChange,
                      this._selectedRangeMin,
                      this._selectedRangeMax,
                    ),
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

  void _retrieveData() async {
    if (_done) {
      return;
    }
    var search = _buildRequestURL();
    var list = await ClientAPI.getInstance().newSearchSubjects(search);
    if (list.length < this._count) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list.toList());
    _start = _start + list.length;
    setState(() {});
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

  void onRangeChange(min, max) {
    this._selectedRangeMin = min;
    this._selectedRangeMax = max;
    _refresh();
  }

  String _buildRequestURL() {
    var search =
        "?start=${this._start}&sort=${this._selectedSortBy}&range=${this._selectedRangeMin.toString()},${this._selectedRangeMax.toString()}";
    if (this._selectedStyle != LabelConstant.MOVIE_CATEGORY_ALL) {
      search = search + "&genres=${this._selectedStyle}";
    }
    if (this._selectedCountry != LabelConstant.MOVIE_CATEGORY_ALL) {
      search = search + "&countries=${this._selectedCountry}";
    }
    if (this._selectedYear != LabelConstant.MOVIE_CATEGORY_ALL) {
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
    var tags = this._selectedSpecial == LabelConstant.MOVIE_CATEGORY_ALL
        ? "电影"
        : "电影,${this._selectedSpecial}";
    search = search + "&tags=$tags";
    return search;
  }
}
