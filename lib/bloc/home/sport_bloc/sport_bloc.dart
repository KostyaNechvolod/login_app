import 'dart:convert';
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:login_app/bloc/home/home.dart';
import 'package:login_app/model/model.dart';

class SportBloc extends Bloc<SportListEvent, SportState> {
  @override
  Stream<SportListEvent> transform(Stream<SportListEvent> events) {
    return (events as Observable<SportListEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => SportState.initial();

  @override
  Stream<SportState> mapEventToState(currentState, event) async* {
    if (event is FetchSport) {
      try {
        final Sport = await _fetchSportElements();
        if (Sport.isEmpty) {
          yield currentState.copyWith(hasReachedMax: true);
        } else {
          yield SportState.success(currentState.listElements + Sport);
        }
      } catch (_) {
        yield SportState.failure();
      }
    }
  }

  Future<List<Sport>> _fetchSportElements() async {
    String latestProductsUrl =
        'https://www.thesportsdb.com/api/v1/json/1/all_sports.php';
    http.Response response = await http.get(latestProductsUrl);
    List popularProductsJson = json.decode(response.body)['sports'];
    List<Sport> products = List();
    popularProductsJson.forEach((json) => products.add(Sport.fromJson(json)));

    print("products = $products");
    return products;
  }
}