import 'package:flutter/material.dart';

import 'package:login_app/screens/map_screen.dart';
import 'package:login_app/net_utils.dart';


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
            title: Text('Favorite video on YouTube'),
            onTap: () => NetUtils.loadWebSite('youtu.be/hA0hrpR-o8U'),
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
}