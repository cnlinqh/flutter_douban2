import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static int _primarySwatchIndex = 0;
  static int _accentColorIndex = 0;
  static int _brightnessIndex = 0;
  static const List<MaterialColor> primarySwatchList = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
  ];
  static const List<MaterialAccentColor> accentColorList = [
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.indigoAccent,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.cyanAccent,
    Colors.tealAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.limeAccent,
    Colors.yellowAccent,
    Colors.amberAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
  ];
  static const List<Brightness> brightnessList = [
    Brightness.light,
    Brightness.dark,
  ];

  static const colors = const {
    'red': Colors.red,
    'redAccent': Colors.redAccent,
    'orange': Colors.orange,
    'orangeAccent': Colors.orangeAccent,
    'green': Colors.green,
    'blue': Colors.blue,
    'grey': Colors.grey,
    'white': Colors.white,
    'black': Colors.black,
  };

  static MaterialColor convert2MaterialColor(Color primaryColor) {
    if (primaryColor == null) {
      primaryColor = ThemeBloc.primarySwatchList[ThemeBloc._primarySwatchIndex];
    }
    Map<int, Color> colors = {
      50: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .1),
      100: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .2),
      200: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .3),
      300: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .4),
      400: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .5),
      500: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .6),
      600: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .7),
      700: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .8),
      800: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, .9),
      900: Color.fromRGBO(primaryColor.red, primaryColor.green, primaryColor.blue, 1),
    };
    return MaterialColor(primaryColor.value, colors);
  }

  @override
  ThemeState get initialState {
    return ThemeState(
      primarySwatchIndex: 0,
      accentColorIndex: 0,
      brightnessIndex: 0,
      themeData: ThemeData(
        primaryColor: ThemeBloc.primarySwatchList[0],
        brightness: ThemeBloc.brightnessList[0],
      ),
    );
  }

  Future<void> initialThemeBlocFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.add(
      ThemeEvent(
        primarySwatchIndex: prefs.getInt('_primarySwatchIndex') ?? 0,
        accentColorIndex: prefs.getInt('_accentColorIndex') ?? 0,
        brightnessIndex: prefs.getInt('_brightnessIndex') ?? 0,
      ),
    );
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeEvent) {
      if (event.primarySwatchIndex != -1) {
        _primarySwatchIndex = event.primarySwatchIndex;
      }
      if (event.accentColorIndex != -1) {
        _accentColorIndex = event.accentColorIndex;
      }
      if (event.brightnessIndex != -1) {
        _brightnessIndex = event.brightnessIndex;
      }
      yield ThemeState(
        primarySwatchIndex: _primarySwatchIndex,
        accentColorIndex: _accentColorIndex,
        brightnessIndex: _brightnessIndex,
        themeData: ThemeData(
          primarySwatch: ThemeBloc.primarySwatchList[_primarySwatchIndex],
          accentColor: ThemeBloc.accentColorList[_accentColorIndex],
          brightness: ThemeBloc.brightnessList[_brightnessIndex],
        ),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('_primarySwatchIndex', _primarySwatchIndex);
      prefs.setInt('_accentColorIndex', _accentColorIndex);
      prefs.setInt('_brightnessIndex', _brightnessIndex);
    }
  }
}
