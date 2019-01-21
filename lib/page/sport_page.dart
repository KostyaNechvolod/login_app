import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/home/home.dart';
import 'package:login_app/model/model.dart';
import 'package:login_app/page/sport_info_page.dart';


class SportList extends StatefulWidget {
  @override
  _SportListState createState() => _SportListState();
}

class _SportListState extends State<SportList> {
  final _scrollController = ScrollController();
  final SportBloc _sportBloc = SportBloc();
  final _scrollThreshold = 200.0;

  _SportListState() {
    _scrollController.addListener(_onScroll);
    _sportBloc.dispatch(FetchSport());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _sportBloc,
      builder: (BuildContext context, SportState state) {
        if (state.isInitializing) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.isError) {
          return Center(
            child: Text('failed to fetch Sport elements'),
          );
        }
        if (state.listElements.isEmpty) {
          return Center(
            child: Text('no Coctails'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8.0),
          separatorBuilder: (BuildContext context, int item) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return index >= state.listElements.length
                ? BottomLoader()
                : ListElementWidget(listElement: state.listElements[index]);
          },
          itemCount: state.hasReachedMax
              ? state.listElements.length
              : state.listElements.length,
        );
      },
    );
  }

  @override
  void dispose() {
    _sportBloc.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _sportBloc.dispatch(FetchSport());
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
  final Sport listElement;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  const ListElementWidget({Key key, @required this.listElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SportInfoScreen(listElement: listElement),
          ),
        );
      },
      child: ListTile(
        leading: Image.network(listElement.strSportThumb, width: 100, height: 50,),
        title: Text(
          listElement.strSport,
          style: _biggerFont,
        ),
        dense: true,
      ),
    );
  }
}