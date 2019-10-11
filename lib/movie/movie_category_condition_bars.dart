import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/movie/movie_category_search_bar.dart';
import 'package:flutter_douban2/movie/movie_category_sort_bar2.dart';
import 'package:flutter_douban2/movie/movie_category_range_bar.dart';

class MovieCategoryConditionBars extends StatelessWidget {
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
                    this.style,
                    this.onStyleChange,
                  ),
                  MovieCategorySearchBar(
                    LabelConstant.sCountriesList,
                    this.country,
                    this.onCountryChange,
                  ),
                  MovieCategorySearchBar(
                    LabelConstant.sYearList,
                    this.year,
                    this.onYearChange,
                  ),
                  MovieCategorySearchBar(
                    LabelConstant.sSpecialList,
                    this.special,
                    this.onSpecialChange,
                  ),
                  // MovieCategorySortBar(
                  //   onSortByChange,
                  //   this._selectedSortBy,
                  // ),
                  MovieCategorySortBar2(
                    this.onSortByChange,
                    this.sortBy,
                  ),
                  MovieCategoryRangeBar(
                    this.onRangeChange,
                    this.rangeMin,
                    this.rangeMax,
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
