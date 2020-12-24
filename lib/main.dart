import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:UangDana/config.dart';
import 'package:UangDana/dontknow.dart';
import 'package:UangDana/layout_type.dart';
import 'package:UangDana/model/my_const.dart';
import 'package:UangDana/widgets/about_page.dart';
import 'package:UangDana/widgets/itempage.dart';
import 'package:redux/redux.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  final Store<int> store;
  final String title;

  MainApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: new Color.fromARGB(255, 1, 215, 215),
        accentColor: Colors.cyan[300],
      ),
      home: How2UsePage(),
      // home: new MainPage(title: 'Boss直聘'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LayoutEnums _layoutSelection = LayoutEnums.list;

  Color _colorTabMatching({LayoutEnums layoutSelection}) {
    return _layoutSelection == layoutSelection ? Colors.cyan[300] : Colors.grey;
  }

  BottomNavigationBarItem _buildItem(
      {String icon, LayoutEnums layoutSelection}) {
    String text = layoutName(layoutSelection);
    return BottomNavigationBarItem(
      icon: new Image.asset(
        icon,
        width: 26.0,
        height: 26.0,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(layoutSelection: layoutSelection),
        ),
      ),
    );
  }

  Widget _buildButtonNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(
            icon: _layoutSelection == LayoutEnums.list
                ? "images/tabs.png"
                : "images/tabs.png",
            layoutSelection: LayoutEnums.list),
        _buildItem(
            icon: _layoutSelection == LayoutEnums.about
                ? "images/about_pre.png"
                : "images/about.png",
            layoutSelection: LayoutEnums.about),
      ],
      onTap: _onSelectTab,
    );
  }

  void _onLayoutSelected(LayoutEnums selection) {
    setState(() {
      _layoutSelection = selection;
    });
  }

  void _onSelectTab(int index) {
    switch (index) {
      case 0:
        _onLayoutSelected(LayoutEnums.list);
        break;
    }
  }

  Widget _buildBody() {
    LayoutEnums layoutSelection = _layoutSelection;
    switch (layoutSelection) {
      case LayoutEnums.list:
        return ItemPage();
      case LayoutEnums.about:
        return AboutPage();
    }
  }

  @override
  void initState() {
    super.initState();
    loadDevice();
  }

  void loadDevice() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      MyConst.DEVICE_INFO_ID = androidInfo.androidId;
      try {
        Dio dio = new Dio();
        for (int i = 0; i <= 20; i++) {
          if (MyConst.DEVICE_INFO_ID != null &&
              MyConst.DEVICE_INFO_ID.isNotEmpty) {
            break;
          } else {
            await sleep(const Duration(milliseconds: 108));
          }
        }
        await dio.post(Config.BASE_URL + Config.USER_DATA, data: {
          "deInfoId": MyConst.DEVICE_INFO_ID,
          "login": "1",
          "jobId": 0,
        });
      } catch (e, stack) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildButtonNavBar(),
    );
  }
}
