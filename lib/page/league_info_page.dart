import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:login_app/bloc/home/home.dart';

import 'package:login_app/model/model.dart';
import 'package:login_app/page/team_info_page.dart';

class LeagueListScreen extends StatelessWidget {
  final TeamBloc _teamBloc = TeamBloc();
  final String league;

  LeagueListScreen(this.league) {
    _teamBloc.dispatch(FetchTeam(league));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _teamBloc,
      builder: (BuildContext context, TeamState state) {
        if (state.isInitializing) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.isError) {
          return Center(
            child: Text('failed to fetch Team elements'),
          );
        }
        if (state.listElements.isEmpty) {
          return Center(
            child: Text('no Coctails'),
          );
        }

        return Scaffold(
            appBar: AppBar(
              title: Text('ListTeam'),
            ),
            body: Center(
              child: SizedBox(
                height: 500.0,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.listElements.length
                        ? BottomLoader()
                        : ListElementWidget(
                            listElement: state.listElements[index]);
                  },
                  itemCount: state.hasReachedMax
                      ? state.listElements.length
                      : state.listElements.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
            ));
      },
    );
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
  final Team listElement;

  final _biggerFont =
      const TextStyle(fontSize: 40, fontStyle: FontStyle.italic);

  const ListElementWidget({@required this.listElement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamInfoScreen(team: listElement),
            ),
          );
        },
        child: Card(
          color: Colors.blue,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(
                listElement.strTeam,
                style: _biggerFont,
              ),
              SizedBox(
                height: 80.0,
              ),
              Hero(
                  tag: 'hero${listElement.strTeam}',
                  child: Image.network(listElement.strTeamBadge))
            ],
          ),
        ));
  }
}
