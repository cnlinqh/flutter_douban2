import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final int index;
  final ThemeData themeData;
  final Color color;
  final Color colorAccent;
  ThemeState({
    @required this.index,
    @required this.themeData,
    @required this.color,
    @required this.colorAccent,
  });
  @override
  List<Object> get props => [themeData, color, colorAccent];
}
