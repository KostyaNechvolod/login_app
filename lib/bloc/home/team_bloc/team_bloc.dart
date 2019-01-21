import 'dart:convert';
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:login_app/bloc/home/home.dart';
import 'package:login_app/model/model.dart';

class TeamBloc extends Bloc<TeamListEvent, TeamState> {
  @override
  Stream<TeamListEvent> transform(Stream<TeamListEvent> events) {
    return (events as Observable<TeamListEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => TeamState.initial();

  @override
  Stream<TeamState> mapEventToState(currentState, event) async* {
    if (event is FetchTeamByName) {
      try {
        final Team = await _fetchTeamByNameElements(event.teamName);
        if (Team.isEmpty) {
          yield currentState.copyWith(hasReachedMax: true);
        } else {
          yield TeamState.success(Team);
        }
      } catch (e) {
        print('ERRRRROR = ' + e.toString());
        yield TeamState.failure();
      }
    } else {
      if (event is FetchTeam) {
        try {
          final Team = await _fetchTeamElements(event.leagueName);
          if (Team.isEmpty) {
            yield currentState.copyWith(hasReachedMax: true);
          } else {
            yield TeamState.success(Team);
          }
        } catch (e) {
          print('ERRRRROR = ' + e.toString());
          yield TeamState.failure();
        }
      }
    }
  }

  Future<List<Team>> _fetchTeamElements(String leagueName) async {
    String latestProductsUrl =
        'https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=$leagueName';
    http.Response response = await http.get(latestProductsUrl);
    List popularProductsJson = json.decode(response.body)['teams'];
    List<Team> products = List();
    products.clear();
    popularProductsJson.forEach((json) => products.add(Team.fromJson(json)));
    //print("products = $products");
    return products;
  }

  Future<List<Team>> _fetchTeamByNameElements(String teamName) async {
    String latestProductsUrl =
        'https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$teamName';
    http.Response response = await http.get(latestProductsUrl);
    List popularProductsJson = json.decode(response.body)['teams'];
    List<Team> products = List();
    products.clear();
    popularProductsJson.forEach((json) => products.add(Team.fromJson(json)));
    //print("products = $products");
    return products;
  }
}