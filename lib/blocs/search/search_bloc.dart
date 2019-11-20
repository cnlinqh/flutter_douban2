import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_douban2/util/log_util.dart';
import './bloc.dart';
import 'package:flutter_douban2/util/client_api.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List _searchHistories = [];
  List _searchSuggestions = [];
  List _searchResults = [];

  @override
  SearchState get initialState => SearchInitialState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchTextHistoryEvent) {
      //clear the search text
      if (event.action == 'get') {
        yield SearchTextHistoryState(hisitories: this._searchHistories);
      }
      if (event.action == 'clear') {
        this._searchHistories.clear();
        yield SearchTextHistoryState(hisitories: this._searchHistories);
      }
    } else if (event is SearchTextFireEvent) {
      //fire search event, invoke search API to search
      yield* _mapSearchTextFireEventToState(event);
    } else if (event is SearchTextChangeEvent) {
      //search text change, invoke suggest API to promote suggetions
      yield* _mapSearchTextChangeEventToState(event);
    } else if (event is SearchSuggestionsClearEvent) {
      //clear suggestions
      yield SearchSuggestionsLoadedState(suggestions: []);
    }
  }

  Stream<SearchState> _mapSearchTextFireEventToState(SearchTextFireEvent event) async* {
    yield SearchResultsLoadingState();
    try {
      if (_searchHistories.indexOf(event.searchText) == -1) {
        _searchHistories.insert(0, event.searchText);
        if (_searchHistories.length > 10) {
          _searchHistories = _searchHistories.sublist(0, 10);
        }
      }
      var results = await ClientAPI.getInstance().search(event.searchText);
      this._searchResults = results;
      yield SearchResultsLoadedState(searchText: event.searchText, results: this._searchResults);
    } catch (_) {
      yield SearchErrorState();
    }
  }

  Stream<SearchState> _mapSearchTextChangeEventToState(SearchTextChangeEvent event) async* {
    if (this._searchHistories.length > 0 && this._searchHistories[0] == event.searchText) {
      LogUtil.log('Return empty [] if already search');
      yield SearchSuggestionsLoadedState(suggestions: []);
    } else {
      try {
        var suggestions = await ClientAPI.getInstance().suggest(event.searchText);
        this._searchSuggestions = suggestions;
        yield SearchSuggestionsLoadedState(suggestions: this._searchSuggestions);
      } catch (_) {
        yield SearchErrorState();
      }
    }
  }
}
