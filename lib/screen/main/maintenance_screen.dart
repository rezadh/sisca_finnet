import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sisca_finnet/model/maintenance_model.dart';
import 'package:sisca_finnet/screen/main/test_screen.dart';
import 'package:sisca_finnet/widget/form_maintenance.dart';
import 'package:sisca_finnet/widget/custom_bottom_bar.dart';

import 'account_screen.dart';
import 'asset_screen.dart';
import 'voucher_screen.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

enum BottomIcons { Asset, Maintenance, Voucher, Account }

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  BottomIcons bottomIcons = BottomIcons.Maintenance;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      postRequestMaintenance();
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
          'Maintenance request',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height,
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
                          key: _refreshIndicatorKey,
                          onRefresh: postRequestMaintenance,
                          child: Container(
                            width: size.width,
                            height: size.height,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: FutureBuilder<List<Maintenance>>(
                                future: postRequestMaintenance(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Maintenance> data = snapshot.data;
                                    print(data);
                                    return data.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: data.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                elevation: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  width: size.width,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${data[index].id.substring(data[index].id.length - 4).toUpperCase().toString()} - ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Color(
                                                                        0xFF595D64),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        'Roboto'),
                                                              ),
                                                              Text(
                                                                data[index]
                                                                    .userRequestedBy
                                                                    .username,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
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
                                                          Text(
                                                            data[index]
                                                                .monitoringMaintenance
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Color(
                                                                    0xFF595D64),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            data[index]
                                                                .monitoringMaintenance
                                                                .serialNumber,
                                                            style: TextStyle(
                                                                fontSize: 8,
                                                                color: Color(
                                                                    0xFF595D64),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            data[index]
                                                                .status
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Color(
                                                                    0xFF595D64),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ),
                                                          SizedBox(height: 8),
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
                                                                    .requestedAmount)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 8,
                                                                color: Color(
                                                                    0xFF595D64),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Roboto'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50),
                                            margin: EdgeInsets.only(
                                                top: size.height / 3),
                                            width: size.width,
                                            height: size.height,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                      'assets/images/empty_data.png'),
                                                  Text(
                                                    'No Requests yet..',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFF595D64),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                  } else {
                                    return Text('');
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 77,
                      right: 22,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TestScreen()),
                            // );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => AlertPopUp()),
                            // );
                            // showPopRequestData(context);
                            showDialog(context: context, builder: (context) => FormMaintenance());
                            // FormMaintenance();
                          });
                        },
                        child: Icon(Icons.add),
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
                    Positioned(
                      bottom: -5,
                      left: -5,
                      child: Card(
                        elevation: 1,
                        child: Container(
                          width: size.width,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomBottomBar(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssetScreen()),
                                        (route) => false,
                                      );
                                      bottomIcons = BottomIcons.Asset;
                                    });
                                  },
                                  bottomIcons: bottomIcons == BottomIcons.Asset
                                      ? true
                                      : false,
                                  text: 'Asset',
                                  icons: 'assets/images/box.png'),
                              CustomBottomBar(
                                  onPressed: () {
                                    setState(() {
                                      bottomIcons = BottomIcons.Maintenance;
                                    });
                                  },
                                  bottomIcons:
                                      bottomIcons == BottomIcons.Maintenance
                                          ? true
                                          : false,
                                  text: 'Maintenance',
                                  icons: 'assets/images/tools.png'),
                              CustomBottomBar(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VoucherScreen()),
                                        (route) => false,
                                      );
                                      bottomIcons = BottomIcons.Voucher;
                                    });
                                  },
                                  bottomIcons:
                                      bottomIcons == BottomIcons.Voucher
                                          ? true
                                          : false,
                                  text: 'Voucher',
                                  icons: 'assets/images/voucher.png'),
                              CustomBottomBar(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountScreen()),
                                        (route) => false,
                                      );
                                      bottomIcons = BottomIcons.Account;
                                    });
                                  },
                                  bottomIcons:
                                      bottomIcons == BottomIcons.Account
                                          ? true
                                          : false,
                                  text: 'Account',
                                  icons: 'assets/images/user.png'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

