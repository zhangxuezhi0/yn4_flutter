import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:UangDana/config.dart';
import 'package:UangDana/model/item.dart';
import 'package:UangDana/model/my_const.dart';
import 'package:http/http.dart' as http;

import 'file:///D:/github/yn4_flutter/lib/job_item.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>
    with AutomaticKeepAliveClientMixin {
  List<MainItem> jobList = List<MainItem>();

  Future<List<MainItem>> _fetchJobList() async {
    final response = await http.get('${Config.BASE_URL + Config.PLATFORM_AD}');
    print("===========list loaded.");
    List<MainItem> jobList = List<MainItem>();

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      for (dynamic data in result['data']) {
        MainItem jobData = MainItem.fromJson(data);
        jobList.add(jobData);
      }
    }
    return jobList;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text(MyConst.APP_ID,
            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
      body: new Center(
        child: FutureBuilder(
          future: _fetchJobList(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return _createListView(context, snapshot);
            }
          },
        ),
      ),
    );
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<MainItem> jobList = snapshot.data;
    return ListView.builder(
      key: new PageStorageKey('item_list'),
      itemCount: jobList.length,
      itemBuilder: (BuildContext context, int index) {
        return new JobItem(onPressed: () {}, mainitem: jobList[index]);
      },
    );
  }
}
