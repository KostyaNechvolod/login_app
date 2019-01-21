import 'dart:convert';
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:login_app/bloc/home/home.dart';
import 'package:login_app/model/model.dart';

class LeagueBloc extends Bloc<LeagueListEvent, LeagueState> {
  String appendUri = 'all_leagues.php';
  String search = 'leagues';

  //search_all_leagues.php?c=$country&s=$sport

  @override
  Stream<LeagueListEvent> transform(Stream<LeagueListEvent> events) {
    return (events as Observable<LeagueListEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => LeagueState.initial();

  @override
  Stream<LeagueState> mapEventToState(currentState, event) async* {
    if (event is FetchLeagueWithParam) {
      if (event.country != '' && event.sport != '') {
        appendUri =
        'search_all_leagues.php?c=${event.country}&s=${event.sport}';
        search = 'countrys';
      } else {
        if (event.country != '' && event.sport == '') {
          appendUri = 'search_all_leagues.php?c=${event.country}';
          search = 'countrys';
        } else {
          if (event.country == '' && event.sport != '') {
            appendUri = 'search_all_leagues.php?&s=${event.sport}';
            search = 'countrys';
          }
        }
      }
      try {
        final League = await _fetchLeagueElements(appendUri, search);
        if (League.isEmpty) {
          yield currentState.copyWith(hasReachedMax: true);
        } else {
          yield LeagueState.success(League);
        }
      } catch (e) {
        print('ERRRRROR = ' + e.toString());
        yield LeagueState.failure();
      }
    }
  }

  Future<List<League>> _fetchLeagueElements(
      String appendURI, String search) async {
    String latestProductsUrl =
        'https://www.thesportsdb.com/api/v1/json/1/$appendURI';
    print('URIIIII = ' + latestProductsUrl + ' ' + search);
    http.Response response = await http.get(latestProductsUrl);
    List popularProductsJson = json.decode(response.body)[search];
    List<League> products = List();
    products.clear();
    popularProductsJson.forEach((json) => products.add(League.fromJson(json)));
    //print("products = $products");
    return products;
  }
}