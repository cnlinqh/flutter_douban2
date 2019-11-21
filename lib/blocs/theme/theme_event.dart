import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChangeEvent extends ThemeEvent {
  final index;
  ThemeChangeEvent(this.index);
  List<Object> get props => [index];
}
