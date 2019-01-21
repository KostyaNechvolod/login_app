import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:login_app/screens/map_screen.dart';


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