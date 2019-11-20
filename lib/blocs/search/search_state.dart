import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:math';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchTextHistoryState extends SearchState {
  final hisitories;
  const SearchTextHistoryState({@required this.hisitories}) : assert(hisitories != null);
  @override
  //make sure every SearchTextHistoryState instance unique to avoid debounce outgoing state
  List<Object> get props => [Random().nextDouble().toString()];
}

class SearchResultsLoadingState extends SearchState {}

class SearchResultsLoadedState extends SearchState {
  final searchText;
  final results;
  const SearchResultsLoadedState({@required this.searchText, @required this.results})
      : assert(searchText != null && results != null);
  @override
  List<Object> get props => results;
}

class SearchSuggestionsLoadedState extends SearchState {
  final suggestions;
  const SearchSuggestionsLoadedState({@required this.suggestions}) : assert(suggestions != null);
  @override
  List<Object> get props => suggestions;
}

class SearchErrorState extends SearchState {}
