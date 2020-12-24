import 'package:flutter/material.dart';
import 'package:UangDana/model/my_const.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text('about',
            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              MyConst.APP_ID,
              style: TextStyle(color: Colors.blue, fontSize: 28.0),
            ),
          ],
        ),
      ),
    );
  }
}
