import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:login_app/model/team_info.dart';

class TeamInfoScreen extends StatelessWidget {
  final Team team;

  const TeamInfoScreen({@required this.team});

  final _biggerFont =
      const TextStyle(fontSize: 20, fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.strTeam),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'hero${team.strTeam}',
                  child: Image.network(
                    team.strTeamBadge,
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Team name - ${team.strTeam}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Year of foundation - ${team.intFormedYear}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('League - ${team.strLeague}'),
                  ],
                )
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Text(
                  'Home stadium',
                  style: _biggerFont,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    team.strStadiumThumb != null
                        ? Image.network(
                            team.strStadiumThumb,
                            width: 120,
                            height: 120,
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                        child: Text('Location - ${team.strStadiumLocation}',
                            textAlign: TextAlign.center)),
                  ],
                ),
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Text(
                  'Team Info',
                  style: _biggerFont,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(team.strDescriptionEN),
              ],
            ),
            Divider(),
            team.strWebsite != null
                ? Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/web.png',
                        height: 20,
                        width: 20,
                      ),
                      FlatButton(
                          onPressed: () {
                            loadWebSite(team.strWebsite);
                          },
                          child: Text(team.strWebsite))
                    ],
                  )
                : SizedBox(),
            team.strFacebook != null
                ? Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/facebook.png',
                        height: 20,
                        width: 20,
                      ),
                      FlatButton(
                          onPressed: () {
                            loadWebSite(team.strFacebook);
                          },
                          child: Text(team.strFacebook))
                    ],
                  )
                : SizedBox(),
            team.strInstagram != null
                ? Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/insta.png',
                        height: 20,
                        width: 20,
                      ),
                      FlatButton(
                          onPressed: () {
                            loadWebSite(team.strInstagram);
                          },
                          child: Text(team.strInstagram))
                    ],
                  )
                : SizedBox(),
            team.strTwitter != null
                ? Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/twitter.png',
                        height: 20,
                        width: 20,
                      ),
                      FlatButton(
                          onPressed: () {
                            loadWebSite(team.strTwitter);
                          },
                          child: Text(team.strTwitter))
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void loadWebSite(String url) async {
    if (await canLaunch("http://$url")) {
      await launch("http://$url");
    } else {
      throw 'Could not launch $url';
    }
  }
}
