import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final int primarySwatchIndex;
  final int brightnessIndex;
  final ThemeData themeData;
  ThemeState({
    @required this.primarySwatchIndex,
    @required this.brightnessIndex,
    @required this.themeData,
  });
  @override
  List<Object> get props => [primarySwatchIndex, brightnessIndex, themeData];
}
