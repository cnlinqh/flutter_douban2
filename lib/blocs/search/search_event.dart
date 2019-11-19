import 'package:equatable/equatable.dart';
abstract class SearchEvent extends Equatable {
  const SearchEvent();
  List<Object> get props => [];
}

//clear search text to build search history
class SearchTextHistoryEvent extends SearchEvent {
  final String action;
  SearchTextHistoryEvent(this.action);
  List<Object> get props => [action];
}

//fire search process
class SearchTextFireEvent extends SearchEvent {
  final String searchText;
  SearchTextFireEvent(this.searchText);
  List<Object> get props => [searchText];
}

//search text change to fire suggestions process
class SearchTextChangeEvent extends SearchEvent {
  final String searchText;
  SearchTextChangeEvent(this.searchText);
  List<Object> get props => [searchText];
}

//clear suggestions
class SearchSuggestionsClearEvent extends SearchEvent {}

//clear histories
// class SearchHistoriesClearEvent extends SearchEvent {}
