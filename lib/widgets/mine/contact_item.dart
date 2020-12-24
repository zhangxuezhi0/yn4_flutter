import 'package:flutter/material.dart';

class DevelopingItem extends StatelessWidget {
  DevelopingItem({Key key, this.actualVal, this.description, this.onPressed})
      : super(key: key);

  final String actualVal;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: new Column(
        children: [
          new Padding(
            padding: const EdgeInsets.only(
              bottom: 4.0,
            ),
            child: new Text(actualVal, style: new TextStyle(fontSize: 18.0, color: Colors.orange)),
          ),
          new Text(description,
              style: new TextStyle(color: Colors.grey, fontSize: 14.0)),
        ],
      ),
    );
  }
}
