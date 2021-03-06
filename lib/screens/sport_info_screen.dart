import 'package:flutter/material.dart';
import 'package:login_app/model/model.dart';

class SportInfoScreen extends StatelessWidget {
  final Sport listElement;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  const SportInfoScreen({Key key, @required this.listElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(listElement.strSport),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    listElement.strSportThumb,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    listElement.strSport,
                    style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    listElement.strSportDescription,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
