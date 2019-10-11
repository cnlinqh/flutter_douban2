import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_category_filter_bar.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/movie/movie_category_search_bar.dart';
import 'package:flutter_douban2/movie/movie_category_sort_bar2.dart';
import 'package:flutter_douban2/movie/movie_category_range_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieCategoryConditionBars extends StatefulWidget {
  final String style;
  final String country;
  final String year;
  final String special;
  final String sortBy;
  final int rangeMin;
  final int rangeMax;
  final Function onStyleChange;
  final Function onCountryChange;
  final Function onYearChange;
  final Function onSpecialChange;
  final Function onSortByChange;
  final Function onRangeChange;

  MovieCategoryConditionBars({
    Key key,
    this.style = LabelConstant.MOVIE_CATEGORY_ALL,
    this.country = LabelConstant.MOVIE_CATEGORY_ALL,
    this.year = LabelConstant.MOVIE_CATEGORY_ALL,
    this.special = LabelConstant.MOVIE_CATEGORY_ALL,
    this.sortBy = "U",
    this.rangeMin = 0,
    this.rangeMax = 10,
    this.onStyleChange,
    this.onCountryChange,
    this.onYearChange,
    this.onSpecialChange,
    this.onSortByChange,
    this.onRangeChange,
  }) : super(key: key);

  _MovieCategoryConditionBarsState createState() =>
      _MovieCategoryConditionBarsState();
}

class _MovieCategoryConditionBarsState
    extends State<MovieCategoryConditionBars> {
  String _selectedStyle;
  String _selectedCountry;
  String _selectedYear;
  String _selectedSpecial;
  String _selectedSortBy;
  int _selectedRangeMin;
  int _selectedRangeMax;

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
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MovieCategorySearchBar(
                    LabelConstant.sStyleList,
                    this._selectedStyle,
                    this.widget.onStyleChange,
                  ),
                  MovieCategorySearchBar(
                    LabelConstant.sCountriesList,
                    this._selectedCountry,
                    this.widget.onCountryChange,
                  ),
                  MovieCategorySearchBar(
                    LabelConstant.sYearList,
                    this._selectedYear,
                    this.widget.onYearChange,
                  ),
                  MovieCategorySearchBar(
                    LabelConstant.sSpecialList,
                    this._selectedSpecial,
                    this.widget.onSpecialChange,
                  ),
                  // MovieCategorySortBar(
                  //   onSortByChange,
                  //   this._selectedSortBy,
                  // ),
                  MovieCategorySortBar2(
                    this.widget.onSortByChange,
                    this._selectedSortBy,
                  ),

                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil.getInstance()
                            .setWidth(ScreenSize.padding),
                      ),
                      MovieCategoryRangeBar(
                        this.widget.onRangeChange,
                        this._selectedRangeMin,
                        this._selectedRangeMax,
                      ),
                      Expanded(
                        child: Text(''),
                      ),
                      MovieCategoryFilterBar(),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
