import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import 'package:login_app/bloc/home/home.dart';
import 'package:login_app/model/model.dart';
import 'package:login_app/screens/league_info_screen.dart';

class LeagueList extends StatefulWidget {
  @override
  _LeagueListState createState() => _LeagueListState();
}

class _LeagueListState extends State<LeagueList> {
  final _scrollController = ScrollController();
  final LeagueBloc _leagueBloc = LeagueBloc();
  final SportBloc _sportBloc = SportBloc();
  final _scrollThreshold = 200.0;

  String selectedSport;
  String selectedCountry;

  String _country = '';
  String _sport = '';

  _LeagueListState() {
    _scrollController.addListener(_onScroll);
    _leagueBloc.dispatch(FetchLeagueWithParam(_country, _sport));
    _sportBloc.dispatch(FetchSport());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _leagueBloc,
      builder: (BuildContext context, LeagueState state) {
        if (state.isInitializing) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.isError) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(flex: 6, child: showCountry()),
                  Expanded(flex: 6, child: showSport()),
                ],
              ),
              Center(
                child: Text('failed to fetch League elements'),
              ),
            ],
          );
        }
        if (state.listElements.isEmpty) {
          return Center(
            child: Text('no League'),
          );
        }
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(flex: 6, child: showCountry()),
                Expanded(flex: 6, child: showSport()),
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8.0),
                separatorBuilder: (BuildContext context, int item) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.listElements.length
                      ? BottomLoader()
                      : ListElementWidget(
                          listElement: state.listElements[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.listElements.length
                    : state.listElements.length,
              ),
            )
          ],
        );
      },
    );
  }

  Widget showSport() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: BlocBuilder(
          bloc: _sportBloc,
          builder: (BuildContext context, SportState state) {
            return DropdownButton(
                value: selectedSport,
                hint: Text('Select sport'),
                items: listSportDrop(state.listElements),
                onChanged: (value) {
                  selectedSport = value;
                  _sport = value;
                  print('SPORT = ' + _sport);
                  setState(() {});
                  _leagueBloc.dispatch(FetchLeagueWithParam(_country, _sport));
                });
          }),
    );
  }

  List<DropdownMenuItem<String>> listSportDrop(List<Sport> list) {
    List<DropdownMenuItem<String>> listDrops = [];
    for (var data in list) {
      listDrops.add(DropdownMenuItem(
        child: Row(
          children: <Widget>[
            Text(data.strSport),
          ],
        ),
        value: data.strSport,
      ));
    }
    return listDrops;
  }

  Widget showCountry() {
    return FutureBuilder(
        future: listDrop(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: snapshot.hasData
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: DropdownButton(
                      value: selectedCountry,
                      hint: Text("Select country"),
                      items: snapshot.data,
                      onChanged: (value) {
                        selectedCountry = value;
                        _country = value;
                        print('COUNTRY = ' + _country);
                        setState(() {});
                        _leagueBloc
                            .dispatch(FetchLeagueWithParam(_country, _sport));
                      },
                    ))
                : Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          );
        });
  }

  Future<List<DropdownMenuItem<String>>> listDrop() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString("assets/countries.json");
    var jsonData = json.decode(data);

    List<DropdownMenuItem<String>> listDrops = [];
    for (var data in jsonData) {
      listDrops.add(DropdownMenuItem(
        child: Row(
          children: <Widget>[
            Image.network(
                'https://www.countryflags.io/${data['code']}/flat/64.png'),
            SizedBox(width: 8.0),
            Text(data["name"].toString()),
          ],
        ),
        value: data["name"],
      ));
    }
    return listDrops;
  }

  @override
  void dispose() {
    _sportBloc.dispose();
    _leagueBloc.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _leagueBloc.dispatch(FetchLeagueWithParam(_country, _sport));
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class ListElementWidget extends StatelessWidget {
  final League listElement;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  const ListElementWidget({@required this.listElement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeagueListScreen(listElement.strLeague),
          ),
        );
      },
      child: ListTile(
        title: Text(
          listElement.strLeague,
          style: _biggerFont,
        ),
        dense: true,
      ),
    );
  }
}
