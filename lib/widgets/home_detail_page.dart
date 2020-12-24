import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:UangDana/config.dart';
import 'package:UangDana/model/item.dart';
import 'package:UangDana/model/my_const.dart';
import 'package:UangDana/widgets/mine/contact_item.dart';
import 'package:UangDana/widgets/mine/menu_item.dart';
import 'package:UangDana/widgets/mine/req_menu_item.dart';
import 'package:UangDana/widgets/mine/topmenu_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MailDetailPage extends StatefulWidget {
  final MainItem mainItem;

  MailDetailPage(this.mainItem);

  @override
  _MailDetailPageState createState() => _MailDetailPageState(mainItem);
}

class _MailDetailPageState extends State<MailDetailPage>
    with AutomaticKeepAliveClientMixin<MailDetailPage> {
  final MainItem mainItem;

  _MailDetailPageState(this.mainItem);

  final double _barhei = 180.0;

  @override
  bool get wantKeepAlive => true;

  String initAmtVal = "";
  String daysVal = "";

  int pem = 0;
  int bungaAdmin = 0;

  String downloadApiUrl;

  void initVals() {
    if (mainItem == null) {
      return;
    }
    List amtVals = mainItem.amounts.split(",");
    initAmtVal = amtVals[0];

    List dayValList = mainItem.loanPeriods.split(",");
    daysVal = dayValList[0];

    downloadApiUrl = mainItem.downloadUrl;

    reCalAmt();
  }

  void thisPageloaded() async {
    try {
      await dio.post(Config.BASE_URL + Config.USER_DATA, data: {
        "jobId": mainItem.id,
        "turnOnDet": "1",
        "deInfoId": MyConst.DEVICE_INFO_ID,
      });
    } catch (e, stack) {
      print(e);
    }
  }

  Dio dio = Dio();

  void downloadAct() async {
    try {
      Dio dio = Dio();
      await dio.post(Config.BASE_URL + Config.USER_DATA, data: {
        "jobId": mainItem.id,
        "downloadApp": "1",
        "deInfoId": MyConst.DEVICE_INFO_ID,
      });
    } catch (e, stack) {
      print(e);
    }
  }

  void launchDownloadapi() async {
    if (downloadApiUrl != null) {
      if (await canLaunch(downloadApiUrl)) {
        await launch(downloadApiUrl);
      }
    }
  }

  void reCalAmt() {
    double yearlyRate =
        ((mainItem.dailyInterestRate * 100.0 * 365.0)) / 10000.0;
    bungaAdmin =
        (double.parse(daysVal) * yearlyRate * double.parse(initAmtVal) / 365)
            .round();
    pem = bungaAdmin + int.parse(initAmtVal);
  }

  @override
  void initState() {
    super.initState();
    initVals();
    thisPageloaded();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color.fromARGB(254, 245, 245, 248),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _barhei,
            flexibleSpace: new FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Expanded(
                        flex: 5,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Padding(
                              padding: const EdgeInsets.only(
                                top: 53.0,
                                left: 30.0,
                                bottom: 15.0,
                              ),
                              child: new Text(
                                mainItem.name,
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Padding(
                                    padding: EdgeInsets.only(left: 18.0),
                                    child: Text(mainItem.starRating.toString(),
                                        style: new TextStyle(fontSize: 20.0)),
                                  ),
                                  new Image.asset(
                                    "images/star_two.png",
                                    width: 18,
                                    height: 18,
                                    color: Colors.deepOrangeAccent,
                                  )
                                ],
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                left: 30.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  RaisedButton.icon(
                                    onPressed: () {
                                      downloadAct();
                                      launchDownloadapi();
                                    },
                                    // icon: new Icon(Icons.add, color: Colors.white),
                                    icon: new Image.asset(
                                      "images/download.png",
                                      width: 16,
                                      height: 16,
                                      color: Colors.orange,
                                    ),
                                    label: new Text(
                                      "Download",
                                      style: new TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 18),
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Expanded(
                        flex: 2,
                        child: new Padding(
                          padding: const EdgeInsets.only(
                            top: 30.0,
                            right: 20.0,
                          ),
                          child: new CircleAvatar(
                            radius: 45.0,
                            backgroundImage: new NetworkImage(mainItem.iconUrl),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                new Container(
                  color: Colors.white,
                  child: new Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Container(
                                    child: new Text("Jumlah(Rp)",
                                        style: new TextStyle(fontSize: 13.0)),
                                    padding: const EdgeInsets.all(2.0),
                                  ),
                                  new DropdownButton(
                                    value: initAmtVal,
                                    items: mainItem.amounts
                                        .split(",")
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() => initAmtVal = value);
                                      reCalAmt();
                                    },
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Container(
                                    child: new Text("Masa Pinjaman(haris)",
                                        style: new TextStyle(fontSize: 13.0)),
                                    padding: const EdgeInsets.all(2.0),
                                  ),
                                  new DropdownButton(
                                    value: daysVal,
                                    items: mainItem.loanPeriods
                                        .split(",")
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() => daysVal = value);
                                      reCalAmt();
                                    },
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                new Container(
                  color: Colors.white,
                  child: new Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        new DevelopingItem(
                          actualVal: initAmtVal,
                          description: 'Pinjaman',
                        ),
                        new DevelopingItem(
                          actualVal: pem.toString(),
                          description: 'Pembayaran',
                        ),
                        new DevelopingItem(
                          actualVal: bungaAdmin.toString(),
                          description: 'Bunga+admin',
                        ),
                      ],
                    ),
                  ),
                ),
                new Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      new ReqMenuItem(
                        iconAddr: "images/require_line.png",
                        title: 'Tepat 18 tahun + Kartu Bank/KTP/No HP',
                      ),
                      new TopMenuItem(
                        iconAddr: "images/process.png",
                        title: 'Proses pinjaman',
                      ),
                      new MenuItem(
                        iconAddr: "images/download.png",
                        title: 'Download program aplikasi',
                      ),
                      new MenuItem(
                        iconAddr: "images/write.png",
                        title: 'isi informasi pengajuan',
                      ),
                      new MenuItem(
                        iconAddr: "images/confirm_proc.png",
                        title: 'verifikasi informasi',
                      ),
                      new MenuItem(
                        iconAddr: "images/work.png",
                        title: 'Pinjaman masuk ke akun ada',
                      ),
                      new TopMenuItem(
                        iconAddr: "images/process.png",
                        title: 'syarat permohonan',
                      ),
                      new MenuItem(
                        iconAddr: "images/info.png",
                        title: 'INFORMASI IDENTITAS',
                      ),
                      new MenuItem(
                        iconAddr: "images/bank_card.png",
                        title: 'INFORMASI BANK',
                      ),
                      new MenuItem(
                        iconAddr: "images/people.png",
                        title: 'BUKTI PEKERJAAN / USAHA',
                      ),
                      new MenuItem(
                        iconAddr: "images/fill_confirm.png",
                        title: 'NO HP DAN PEKERJAAN YG TETAP',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
