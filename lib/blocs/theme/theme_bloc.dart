import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static final List<Color> colors = [
    Colors.cyan,
    Colors.yellow,
    Colors.blue,
    Colors.red,
    Colors.teal,
    Colors.amber,
    Colors.brown,
    Colors.green,
    Colors.indigo,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.purple,
  ];

  @override
  ThemeState get initialState {
    return ThemeState(
      themeData: ThemeData(
        primaryColor: ThemeBloc.colors[0],
      ),
    );
  }

  Future<int> getIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('themeIndex') ?? 0;
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChangeEvent) {
      yield ThemeState(
        themeData: ThemeData(
          primaryColor: ThemeBloc.colors[event.index],
        ),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('themeIndex', event.index);
    }
  }
}
