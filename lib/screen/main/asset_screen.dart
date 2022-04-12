import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/model/maintenance_model.dart';
import 'package:sisca_finnet/screen/asset_scan_screen.dart';
import 'package:sisca_finnet/screen/detail/asset_detail_screen.dart';
import 'package:sisca_finnet/util/const.dart';

class AssetScreen extends StatefulWidget {
  @override
  _AssetScreenState createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  bool _isInternetOn = true;
  final _scrollController = ScrollController();
  Future<List<Monitoring>> futureMonitoring;

  @override
  void initState() {
    setState(() {
      getConnect();
      futureMonitoring = postRequestAssetMonitoring();
    });
    super.initState();
  }

  Future getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetOn = false;
        EasyLoading.showError('No Connection');
      });
    } else {
      setState(() {
        _isInternetOn = true;
      });
    }
  }

  Future<void> _refreshAsset() async {
    // await postRequestMaintenance();
    // await Future.delayed(Duration(seconds: 2));
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetOn = false;
      });
    } else {
      await postRequestAssetMonitoring();
      setState(() {
        _isInternetOn = true;
      });
    }
    setState(() {
      futureMonitoring = postRequestAssetMonitoring();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Asset Information',
          style: TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height - 60,
        child: Stack(
          children: [
            Positioned(
              top: -60,
              left: 0,
              child: Container(
                // margin: EdgeInsets.only(bottom: 90),
                width: size.width,
                height: size.height,
                padding: EdgeInsets.only(left: 15, right: 15, top: 100),
                child: RefreshIndicator(
                  onRefresh: _refreshAsset,
                  child: _isInternetOn
                      ? Container(
                          width: size.width,
                          height: size.height,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: FutureBuilder<List<Monitoring>>(
                              future: postRequestAssetMonitoring(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData ||
                                    snapshot.connectionState ==
                                        ConnectionState.active) {
                                  List<Monitoring> data = snapshot.data;
                                  return ListView.builder(
                                      itemCount: data.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssetDetailScreen(
                                                            id: data[index]
                                                                .id)));
                                          },
                                          child: Card(
                                            elevation: 1,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 15),
                                              width: size.width,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data[index].name,
                                                        style: TITLE,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        data[index]
                                                            .serialNumber,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: Color(
                                                                0xFF595D64),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontFamily:
                                                                'Roboto'),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Acqusition value : ',
                                                            style: TextStyle(
                                                                fontSize: 9,
                                                                color: Color(
                                                                    0xFF595D64),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ),
                                                          Text(
                                                            NumberFormat.currency(
                                                                    locale:
                                                                        'id',
                                                                    symbol:
                                                                        'IDR ',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(data[
                                                                        index]
                                                                    .amount)
                                                                .toString(),
                                                            // 'IDR 18.981.000',
                                                            style: TextStyle(
                                                                fontSize: 9,
                                                                color: Color(
                                                                    0xFF595D64),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8),
                                                    ],
                                                  ),
                                                  // Column(
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment.end,
                                                  //   children: [
                                                  //     Text(
                                                  //       data[index].procurement,
                                                  //       style: TextStyle(
                                                  //           fontSize: 8,
                                                  //           color: Color(0xFF9AA1AC),
                                                  //           fontWeight: FontWeight.w400,
                                                  //           fontFamily: 'Roboto'),
                                                  //     ),
                                                  //     SizedBox(height: 8),
                                                  //     Text(
                                                  //       NumberFormat.currency(
                                                  //               locale: 'id',
                                                  //               symbol: 'IDR ',
                                                  //               decimalDigits: 0)
                                                  //           .format(data[index].amount)
                                                  //           .toString(),
                                                  //       // 'IDR 18.981.000',
                                                  //       style: TextStyle(
                                                  //           fontSize: 10,
                                                  //           color: Color(0xFF595D64),
                                                  //           fontWeight: FontWeight.w500,
                                                  //           fontFamily: 'Roboto'),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: size.width,
                                    height: size.height,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Container(
                                    width: size.width,
                                    height: size.height,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/no_connection.png'),
                                          Text('No internet connection',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Roboto')),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: size.width,
                                    height: size.height,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      : ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Container(
                              width: size.width,
                              height: size.height / 1.2,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/images/no_connection.png'),
                                    Text('No internet connection',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF595D64),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Positioned(
              bottom: 17,
              right: 22,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssetScanScreen()));
                },
                child: Icon(Icons.qr_code),
                backgroundColor: Color(0xFFF12A32),
              ),
            ),
            Positioned(
              top: -20,
              left: 0,
              child: Container(
                height: 100,
                child: Image.asset(
                  'assets/images/appbar_icon.png',
                  height: size.height / 5,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
