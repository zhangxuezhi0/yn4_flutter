import 'dart:async';

import 'package:flutter/material.dart';
import 'package:UangDana/main.dart';
import 'package:UangDana/model/my_const.dart';

class How2UsePage extends StatefulWidget {
  @override
  How2State createState() => new How2State();
}

class How2State extends State<How2UsePage> {
  Timer _t;

  @override
  void initState() {
    super.initState();
    _t = new Timer(const Duration(milliseconds: 200), () {
      try {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: new MainPage(title: MyConst.APP_ID),
                    );
                  },
                );
              },
              transitionDuration: Duration(milliseconds: 1000),
            ),
            (Route route) => route == null);
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: new Color.fromARGB(255, 0, 215, 215),
      child: Container(
        alignment: Alignment(0, -0.3),
        child: new Text(
          MyConst.APP_ID,
          style: new TextStyle(
              color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
