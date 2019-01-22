import 'package:flutter/material.dart';

import 'package:login_app/model/team_info.dart';
import 'package:login_app/net_utils.dart';

class TeamInfoScreen extends StatelessWidget {
  final Team team;

  const TeamInfoScreen({@required this.team});

  final _biggerFont =
      const TextStyle(fontSize: 20, fontStyle: FontStyle.italic);

  Widget _getTeamBage(String url, String tag) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: 'hero$tag',
        child: Image.network(url, width: 100, height: 100),
      ),
    );
  }

  Widget _getTeamMainInfo(
      String teamName, String teamFormedYear, String teamLeague) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          child: Text('Team name - $teamName'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          child: Text('Year of foundation - $teamFormedYear'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          child: Text('League - $teamLeague'),
        ),
      ],
    );
  }

  Widget _getTeamStadium(String url, String stadiumLocation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          url != null
              ? Image.network(url, width: 120, height: 120)
              : SizedBox(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Location - $stadiumLocation',
                textAlign: TextAlign.center),
          )),
        ],
      ),
    );
  }

  Widget _getLinks(String url, String iconAssetPath) {
    if (url != null) {
      return ListTile(
        leading: Image.asset(iconAssetPath, height: 20, width: 20),
        title: Text(url),
        onTap: () => NetUtils.loadWebSite(team.strWebsite),
      );
    } else
      SizedBox();
  }

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
                _getTeamBage(team.strTeamBadge, team.strTeam),
                _getTeamMainInfo(
                    team.strTeam, team.intFormedYear, team.strLeague),
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Text('Home stadium', style: _biggerFont),
                _getTeamStadium(team.strStadiumThumb, team.strStadiumLocation),
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Text(
                  'Team Info',
                  style: _biggerFont,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(team.strDescriptionEN),
                ),
              ],
            ),
            Divider(),
            _getLinks(team.strWebsite, 'assets/web.png'),
            _getLinks(team.strFacebook, 'assets/facebook.png'),
            _getLinks(team.strInstagram, 'assets/insta.png'),
            _getLinks(team.strTwitter, 'assets/twitter.png'),
          ],
        ),
      ),
    );
  }
}
