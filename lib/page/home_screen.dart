import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:login_app/bloc/authentication/autentication.dart';

import 'package:login_app/page/account_screen.dart';
import 'package:login_app/page/sport_page.dart';
import 'package:login_app/page/league_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authenticationBloc.dispatch(Logout());
              },
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

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: FlatButton(
                onPressed: () {
                  loadWebSite();
                },
                child: Text('Favorite video on YouTube')),
          ),
          ListTile(
            title: Text('Open Map'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MapScreen())),
          )
        ],
      ),
    );
  }

  void loadWebSite() async {
    String url = 'youtu.be/hA0hrpR-o8U';
    if (await canLaunch("https://$url")) {
      await launch("https://$url");
    } else {
      throw 'Could not launch $url';
    }
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(50.005758, 36.229163);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(50.005758, 36.229163),
        infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            myLocationEnabled: true,
            compassEnabled: true,
            cameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
      ),
    );
  }
}
