import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/screen/main/account_screen.dart';
import 'package:sisca_finnet/screen/main/voucher_screen.dart';
import 'package:sisca_finnet/screen/main/maintenance_screen.dart';
import 'package:sisca_finnet/widget/custom_bottom_bar.dart';

class AssetScreen extends StatefulWidget {
  @override
  _AssetScreenState createState() => _AssetScreenState();
}

enum BottomIcons { Asset, Maintenance, Voucher, Account }

class _AssetScreenState extends State<AssetScreen> {
  BottomIcons bottomIcons = BottomIcons.Asset;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    setState(() {
      postRequestAsset();
    });
    super.initState();
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
              fontSize: 18,
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
                  onRefresh: postRequestAssetMonitoring,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: FutureBuilder<List<Monitoring>>(
                      future: postRequestAssetMonitoring(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Monitoring> data = snapshot.data;
                          return ListView.builder(
                              itemCount: data.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    width: size.width,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                data[index].serialNumber,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            Text(
                                                    NumberFormat.currency(
                                                            locale: 'id',
                                                            symbol: 'IDR ',
                                                            decimalDigits: 0)
                                                        .format(data[index].currentBudget)
                                                        .toString(),
                                                    // 'IDR 18.981.000',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xFF595D64),
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                            SizedBox(height: 8),
                                            // Row(
                                            //   children: [
                                            //     Column(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.start,
                                            //       children: [
                                            //         Text(
                                            //           '${data[index].pic.firstName} ${data[index].pic.lastName}',
                                            //           style: TextStyle(
                                            //               fontSize: 10,
                                            //               color:
                                            //                   Color(0xFF595D64),
                                            //               fontWeight:
                                            //                   FontWeight.w400,
                                            //               fontFamily: 'Roboto'),
                                            //         ),
                                            //         Text(
                                            //           '${data[index].pic.level == null ? '' : data[index].pic.level} ${data[index].pic.department == null ? '' : data[index].pic.department}',
                                            //           style: TextStyle(
                                            //               fontSize: 8,
                                            //               color:
                                            //                   Color(0xFF595D64),
                                            //               fontWeight:
                                            //                   FontWeight.w400,
                                            //               fontFamily: 'Roboto'),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ],
                                            // ),
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
                                );
                              });
                        } else {
                          return Text('');
                        }
                      },
                    ),
                  ),
                ),
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
                              bottomIcons = BottomIcons.Asset;
                            });
                          },
                          bottomIcons:
                              bottomIcons == BottomIcons.Asset ? true : false,
                          text: 'Asset',
                          icons: 'assets/images/box.png'),
                      CustomBottomBar(
                          onPressed: () {
                            setState(() {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MaintenanceScreen()),
                                (route) => false,
                              );
                              bottomIcons = BottomIcons.Maintenance;
                            });
                          },
                          bottomIcons: bottomIcons == BottomIcons.Maintenance
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
                                    builder: (context) => VoucherScreen()),
                                    (route) => false,
                              );
                              bottomIcons = BottomIcons.Voucher;
                            });
                          },
                          bottomIcons:
                          bottomIcons == BottomIcons.Voucher ? true : false,
                          text: 'Voucher',
                          icons: 'assets/images/voucher.png'),
                      CustomBottomBar(
                          onPressed: () {
                            setState(() {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountScreen()),
                                (route) => false,
                              );
                              bottomIcons = BottomIcons.Account;
                            });
                          },
                          bottomIcons:
                              bottomIcons == BottomIcons.Account ? true : false,
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
    );
  }
}
