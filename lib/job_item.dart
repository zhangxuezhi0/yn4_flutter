import 'package:flutter/material.dart';
import 'package:UangDana/model/item.dart';

import 'widgets/home_detail_page.dart';

class JobItem extends StatelessWidget {
  final MainItem mainitem;

  JobItem({Key key, this.mainitem, this.onPressed}) : super(key: key);
  VoidCallback onPressed;

  void whenPress(BuildContext context){
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return new MailDetailPage(mainitem);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new SlideTransition(
                position: new Tween(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child),
          );
        }));
  }


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => whenPress(context),
      child: new Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.only(
            left: 18.0, top: 10.0, right: 18.0, bottom: 10.0),
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: Text(
                    mainitem.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 0.1,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  maxAmt(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            /*new Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(job.amounts),
            ),*/
            new Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(mainitem.iconUrl),
                  radius: 25,
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(mainitem.starRating.toString()),
                ),
                new Image.asset(
                  "images/star_two.png",
                  width: 16,
                  height: 16,
                  color: Colors.deepOrangeAccent,
                )
              ],
            ),
            /*new Container(
              decoration: new BoxDecoration(
                  color: new Color(0xFFF6F6F8),
                  borderRadius: new BorderRadius.all(new Radius.circular(6.0))),
              padding: const EdgeInsets.only(
                  top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
              margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
              child: Text(
                mainitem.description1,
                style: new TextStyle(color: new Color(0xFF9fa3b0)),
              ),
            ),
            new Container(
              decoration: new BoxDecoration(
                  color: new Color(0xFFF6F6F8),
                  borderRadius: new BorderRadius.all(new Radius.circular(6.0))),
              padding: const EdgeInsets.only(
                  top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
              margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
              child: Text(
                mainitem.description2,
                style: new TextStyle(color: new Color(0xFF9fa3b0)),
              ),
            ),
            new Container(
              decoration: new BoxDecoration(
                  color: new Color(0xFFF6F6F8),
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0))),
              padding: const EdgeInsets.only(
                  top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
              margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
              child: Text(
                mainitem.description3,
                style: new TextStyle(color: new Color(0xFF9fa3b0)),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  List amts = new List();

  String maxAmt() {
    if (mainitem != null) {
      amts = mainitem.amounts.split(",");
      return "NGN " + amts[amts.length - 1];
    }
    return "";
  }
}
