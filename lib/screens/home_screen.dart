import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_app/bloc/authentication/autentication.dart';

import 'package:login_app/screens/account_screen.dart';
import 'package:login_app/screens/sport_screen.dart';
import 'package:login_app/screens/league_screen.dart';
import 'package:login_app/screens/about_us_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  List<Widget> page = [SportList(), LeagueList()];

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountScreen()));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('User name'),
                accountEmail: Text('email@email.com'),
                currentAccountPicture: CircleAvatar(
                  child: FlutterLogo(
                    size: 42.0,
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
              ListTile(
                title: Text('About us'),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AboutUsScreen())),
              ),
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  authenticationBloc.dispatch(Logout());
                },
              )
            ],
          ),
        ),
        body: page[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (page) => setState(() {
                _currentPage = page;
              }),
          currentIndex: _currentPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_new), title: Text('Sport')),
            BottomNavigationBarItem(
                icon: Icon(Icons.clear_all), title: Text('Leagues'))
          ],
        ));
  }
}
