import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const List<MaterialColor> colors = [
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
  static const List<Color> accents = [
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
  static const Color red = Colors.red;
  static const Color redAccent = Colors.redAccent;
  static const Color orange = Colors.orange;
  static const Color orangeAccent = Colors.orangeAccent;
  static const Color green = Colors.green;
  static const Color blue = Colors.blue;
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  
  static MaterialColor convert2MaterialColor(Color primaryColor) {
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
      index: 0,
      themeData: ThemeData(
        primaryColor: ThemeBloc.colors[0],
      ),
      color: ThemeBloc.colors[0],
      colorAccent: ThemeBloc.accents[0],
    );
  }

  Future<int> getIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var themeIndex = prefs.getInt('themeIndex');
    return themeIndex ?? 0;
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChangeEvent) {
      yield ThemeState(
        index: event.index,
        themeData: ThemeData(
          primarySwatch: ThemeBloc.colors[event.index],
        ),
        color: ThemeBloc.colors[event.index],
        colorAccent: ThemeBloc.accents[event.index],
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('themeIndex', event.index);
    }
  }
}
