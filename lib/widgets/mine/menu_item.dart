import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  MenuItem({Key key, this.iconAddr, this.title, this.onPressed}) : super(key: key);

  final String iconAddr;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              top: 2.0,
              right: 2.0,
              bottom: 2.0,
            ),
            child: new Row(
              children: [
                new Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: new Image.asset(
                    iconAddr,
                    width: 16,
                    height: 16,
                    color: Colors.blueAccent,
                  ),
                ),
                new Expanded(
                  child: new Text(
                    title,
                    style: new TextStyle(color: Colors.black54, fontSize: 14.0),
                  ),
                ),
                /*new Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )*/
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Divider(),
          )
        ],
      ),
    );
  }
}
