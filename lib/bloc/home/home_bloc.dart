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
      if(event.country != '' && event.sport != ''){
        appendUri = 'search_all_leagues.php?c=${event.country}&s=${event.sport}';
        search = 'countrys';
      }else{
        if(event.country != '' && event.sport == ''){
          appendUri = 'search_all_leagues.php?c=${event.country}';
          search = 'countrys';
        }else {
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
          yield LeagueState.success( League);
        }
      } catch (e) {
        print('ERRRRROR = ' + e.toString());
        yield LeagueState.failure();
      }
    }
  }

  Future<List<League>> _fetchLeagueElements(String appendURI, String search) async {
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
          yield TeamState.success( Team);
        }
      } catch (e) {
        print('ERRRRROR = ' + e.toString());
        yield TeamState.failure();
      }
    }else{
      if (event is FetchTeam) {
        try {
          final Team = await _fetchTeamElements(event.leagueName);
          if (Team.isEmpty) {
            yield currentState.copyWith(hasReachedMax: true);
          } else {
            yield TeamState.success( Team);
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