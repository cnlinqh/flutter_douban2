import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_category_condition_bars.dart';
import 'package:flutter_douban2/util/log_util.dart';

class MovieCategoryFilterBar extends StatefulWidget {
  final Function getSelectedInput;
  final Function setSelectedOutput;
  MovieCategoryFilterBar(
      {Key key, this.getSelectedInput, this.setSelectedOutput})
      : super(key: key);
  _MovieCategoryFilterBarState createState() => _MovieCategoryFilterBarState();
}

class _MovieCategoryFilterBarState extends State<MovieCategoryFilterBar> {
  PersistentBottomSheetController<String> controller;
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
    _selectedStyle = widget.getSelectedInput()['style'];
    _selectedCountry = widget.getSelectedInput()['country'];
    _selectedYear = widget.getSelectedInput()['year'];
    _selectedSpecial = widget.getSelectedInput()['special'];
    _selectedSortBy = widget.getSelectedInput()['sortBy'];
    _selectedRangeMin = widget.getSelectedInput()['rangeMin'];
    _selectedRangeMax = widget.getSelectedInput()['rangeMax'];
  }

  void onStyleChange(style) {
    controller.setState(() {
      this._selectedStyle = style;
    });
  }

  void onCountryChange(country) {
    controller.setState(() {
      this._selectedCountry = country;
    });
  }

  void onYearChange(year) {
    controller.setState(() {
      this._selectedYear = year;
    });
  }

  void onSpecialChange(special) {
    controller.setState(() {
      this._selectedSpecial = special;
    });
  }

  void onSortByChange(sort) {
    controller.setState(() {
      this._selectedSortBy = sort;
    });
  }

  void onRangeChange(min, max) {
    controller.setState(() {
      this._selectedRangeMin = min;
      this._selectedRangeMax = max;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedStyle = widget.getSelectedInput()['style'];
            _selectedCountry = widget.getSelectedInput()['country'];
            _selectedYear = widget.getSelectedInput()['year'];
            _selectedSpecial = widget.getSelectedInput()['special'];
            _selectedSortBy = widget.getSelectedInput()['sortBy'];
            _selectedRangeMin = widget.getSelectedInput()['rangeMin'];
            _selectedRangeMax = widget.getSelectedInput()['rangeMax'];
          });
          controller = showBottomSheet(
            context: context,
            builder: (_) => Stack(
              children: <Widget>[
                _buildBottomSheetContent(),
                Positioned(
                  top: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                  right: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      LogUtil.log("Navigator.of(context).pop(input)----------------");
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
          controller.closed.whenComplete(() {
            LogUtil.log("whenComplete----------------");
            var input = {};
            input['style'] = this._selectedStyle;
            input['country'] = this._selectedCountry;
            input['year'] = this._selectedYear;
            input['special'] = this._selectedSpecial;
            input['sortBy'] = this._selectedSortBy;
            input['rangeMin'] = this._selectedRangeMin;
            input['rangeMax'] = this._selectedRangeMax;
            widget.setSelectedOutput(input);
          });
        },
        child: Text("筛选..."),
      ),
    );
  }

  Widget _buildBottomSheetContent() {
    return Container(
      height: ScreenUtil.screenHeight,
      color: ThemeBloc.colors['white'],
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCategoryConditionBars(
              style: this._selectedStyle,
              country: this._selectedCountry,
              year: this._selectedYear,
              special: this._selectedSpecial,
              sortBy: this._selectedSortBy,
              rangeMin: this._selectedRangeMin,
              rangeMax: this._selectedRangeMax,
              onStyleChange: this.onStyleChange,
              onCountryChange: this.onCountryChange,
              onYearChange: this.onYearChange,
              onSpecialChange: this.onSpecialChange,
              onSortByChange: this.onSortByChange,
              onRangeChange: this.onRangeChange,
            )
          ],
        ),
      ),
    );
  }
}
