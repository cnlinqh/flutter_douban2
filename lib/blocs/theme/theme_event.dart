import 'package:equatable/equatable.dart';

class ThemeEvent extends Equatable {
  final int primarySwatchIndex;
  final int brightnessIndex;
  ThemeEvent({
    this.primarySwatchIndex = -1,
    this.brightnessIndex = -1,
  });
  List<Object> get props => [primarySwatchIndex, brightnessIndex];
}
