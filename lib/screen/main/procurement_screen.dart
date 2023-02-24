import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sisca_finnet/screen/main/office_supply_screen.dart';
import 'package:sisca_finnet/screen/main/trip_screen.dart';
import 'package:sisca_finnet/screen/main/voucher_screen.dart';


class ProcurementScreen extends StatefulWidget {

  @override
  State<ProcurementScreen> createState() => _ProcurementScreenState();
}

class _ProcurementScreenState extends State<ProcurementScreen> {
  // bool _isInternetOn = true;
  // final _scrollController = ScrollController();
  // int _value = 0;
  Future getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        // _isInternetOn = false;
        EasyLoading.showError('No Connection');
      });
    } else {
      setState(() {
        // _isInternetOn = true;
      });
    }
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
          'Procurement',
          style: TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       // Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(
          //       //         builder: (context) => SearchAssetScreen()));
          //     },
          //     icon: Icon(Icons.search)),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height - 60,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: -20,
              left: 0,
              child: Container(
                width: size.width,
                height: size.height + 100,
                padding: EdgeInsets.only(left: 15, right: 15, top: 100),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VoucherScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),

                        child: Card(
                           child: Row(
                             children: [
                               Container(
                                   padding: EdgeInsets.all(18),
                                   child: FaIcon(FontAwesomeIcons.ticketAlt, color: Colors.red,),),
                               Container(
                                 child: Text('Voucher'),
                               ),
                             ],
                           ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TripScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(18),
                                child: FaIcon(FontAwesomeIcons.car, color: Colors.red,),),
                              Container(
                                child: Text('Trip'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OfficeSupplyScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(18),
                                child: FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.red,),),
                              Container(
                                child: Text('Office Supplies'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible: _value == 0 ? true : false,
                    //   child: RefreshIndicator(
                    //     onRefresh: _refreshAsset,
                    //     child: _isInternetOn
                    //         ? Container(
                    //       width: size.width,
                    //       height: size.height,
                    //       color: Colors.white,
                    //       child: SingleChildScrollView(
                    //         physics: const BouncingScrollPhysics(
                    //             parent: AlwaysScrollableScrollPhysics()),
                    //         child: FutureBuilder<List<Monitoring>>(
                    //           future: getRequestAssetMonitoring(),
                    //           builder: (context, snapshot) {
                    //             if (snapshot.hasData ||
                    //                 snapshot.connectionState ==
                    //                     ConnectionState.active) {
                    //               List<Monitoring> data = snapshot.data;
                    //               return ListView.builder(
                    //                   itemCount: data.length,
                    //                   physics:
                    //                   NeverScrollableScrollPhysics(),
                    //                   shrinkWrap: true,
                    //                   itemBuilder: (context, index) {
                    //                     return GestureDetector(
                    //                       onTap: () async {
                    //                         SharedPreferences prefs = await SharedPreferences.getInstance();
                    //                         prefs.setString('asset_detail_id', data[index].id);
                    //                         Navigator.push(
                    //                             context,
                    //                             MaterialPageRoute(
                    //                                 builder: (context) =>
                    //                                     AssetDetailScreen(
                    //                                         id: data[
                    //                                         index]
                    //                                             .id)));
                    //                       },
                    //                       child: Card(
                    //                         elevation: 1,
                    //                         child: Container(
                    //                           padding:
                    //                           EdgeInsets.symmetric(
                    //                               horizontal: 15,
                    //                               vertical: 15),
                    //                           width: size.width,
                    //                           child: Row(
                    //                             crossAxisAlignment:
                    //                             CrossAxisAlignment
                    //                                 .start,
                    //                             mainAxisAlignment:
                    //                             MainAxisAlignment
                    //                                 .spaceBetween,
                    //                             children: [
                    //                               Column(
                    //                                 crossAxisAlignment:
                    //                                 CrossAxisAlignment
                    //                                     .start,
                    //                                 children: [
                    //                                   Text(
                    //                                     data[index].name,
                    //                                     style: TITLE,
                    //                                   ),
                    //                                   SizedBox(height: 5),
                    //                                   Text(
                    //                                     data[index]
                    //                                         .serialNumber,
                    //                                     style: TextStyle(
                    //                                         fontSize: 11,
                    //                                         color: Color(
                    //                                             0xFF595D64),
                    //                                         fontWeight:
                    //                                         FontWeight
                    //                                             .w300,
                    //                                         fontFamily:
                    //                                         'Roboto'),
                    //                                   ),
                    //                                   SizedBox(height: 5),
                    //                                   Row(
                    //                                     children: [
                    //                                       Text(
                    //                                         'Acqusition value : ',
                    //                                         style: TextStyle(
                    //                                             fontSize:
                    //                                             9,
                    //                                             color: Color(
                    //                                                 0xFF595D64),
                    //                                             fontWeight:
                    //                                             FontWeight
                    //                                                 .w600,
                    //                                             fontFamily:
                    //                                             'Roboto'),
                    //                                       ),
                    //                                       Text(
                    //                                         NumberFormat.currency(
                    //                                             locale:
                    //                                             'id',
                    //                                             symbol:
                    //                                             'IDR ',
                    //                                             decimalDigits:
                    //                                             0)
                    //                                             .format(data[
                    //                                         index]
                    //                                             .amount)
                    //                                             .toString(),
                    //                                         // 'IDR 18.981.000',
                    //                                         style: TextStyle(
                    //                                             fontSize:
                    //                                             9,
                    //                                             color: Color(
                    //                                                 0xFF595D64),
                    //                                             fontWeight:
                    //                                             FontWeight
                    //                                                 .w500,
                    //                                             fontFamily:
                    //                                             'Roboto'),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   SizedBox(height: 8),
                    //                                 ],
                    //                               ),
                    //                               // Column(
                    //                               //   crossAxisAlignment:
                    //                               //       CrossAxisAlignment.end,
                    //                               //   children: [
                    //                               //     Text(
                    //                               //       data[index].procurement,
                    //                               //       style: TextStyle(
                    //                               //           fontSize: 8,
                    //                               //           color: Color(0xFF9AA1AC),
                    //                               //           fontWeight: FontWeight.w400,
                    //                               //           fontFamily: 'Roboto'),
                    //                               //     ),
                    //                               //     SizedBox(height: 8),
                    //                               //     Text(
                    //                               //       NumberFormat.currency(
                    //                               //               locale: 'id',
                    //                               //               symbol: 'IDR ',
                    //                               //               decimalDigits: 0)
                    //                               //           .format(data[index].amount)
                    //                               //           .toString(),
                    //                               //       // 'IDR 18.981.000',
                    //                               //       style: TextStyle(
                    //                               //           fontSize: 10,
                    //                               //           color: Color(0xFF595D64),
                    //                               //           fontWeight: FontWeight.w500,
                    //                               //           fontFamily: 'Roboto'),
                    //                               //     ),
                    //                               //   ],
                    //                               // ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     );
                    //                   });
                    //             } else if (snapshot.connectionState ==
                    //                 ConnectionState.waiting) {
                    //               return Container(
                    //                 width: size.width,
                    //                 height: size.height,
                    //                 child: Center(
                    //                   child: CircularProgressIndicator(),
                    //                 ),
                    //               );
                    //             } else if (snapshot.connectionState ==
                    //                 ConnectionState.none) {
                    //               return Container(
                    //                 width: size.width,
                    //                 height: size.height,
                    //                 child: Center(
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                     MainAxisAlignment.center,
                    //                     children: [
                    //                       Image.asset(
                    //                           'assets/images/no_connection.png'),
                    //                       Text('No internet connection',
                    //                           style: TextStyle(
                    //                               fontSize: 13,
                    //                               color:
                    //                               Color(0xFF595D64),
                    //                               fontWeight:
                    //                               FontWeight.w500,
                    //                               fontFamily: 'Roboto')),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               );
                    //             } else {
                    //               return Container(
                    //                 width: size.width,
                    //                 height: size.height,
                    //                 child: Center(
                    //                   child: CircularProgressIndicator(),
                    //                 ),
                    //               );
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //     )
                    //         : ScrollConfiguration(
                    //       behavior: MyBehavior(),
                    //       child: SingleChildScrollView(
                    //         controller: _scrollController,
                    //         physics: AlwaysScrollableScrollPhysics(),
                    //         child: Container(
                    //           width: size.width,
                    //           height: size.height / 1.2,
                    //           child: Center(
                    //             child: Column(
                    //               mainAxisAlignment:
                    //               MainAxisAlignment.center,
                    //               children: [
                    //                 Image.asset(
                    //                     'assets/images/no_connection.png'),
                    //                 Text('No internet connection',
                    //                     style: TextStyle(
                    //                         fontSize: 13,
                    //                         color: Color(0xFF595D64),
                    //                         fontWeight: FontWeight.w500,
                    //                         fontFamily: 'Roboto')),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Visibility(
                    //   visible: _value == 1 ? true : false,
                    //   child: RefreshIndicator(
                    //     onRefresh: _refreshOpname,
                    //     child: _isInternetOn
                    //         ? Container(
                    //       color: Colors.white,
                    //       width: size.width,
                    //       height: size.height,
                    //       child: SingleChildScrollView(
                    //         physics: const BouncingScrollPhysics(
                    //             parent: AlwaysScrollableScrollPhysics()),
                    //         child: FutureBuilder<List<DataBawahOpname>>(
                    //           future: getRequestOpname(),
                    //           builder: (context, snapshot) {
                    //             if (snapshot.hasData ||
                    //                 snapshot.connectionState ==
                    //                     ConnectionState.active) {
                    //               List<DataBawahOpname> data =
                    //                   snapshot.data;
                    //               return ListView.builder(
                    //                   itemCount: data.length,
                    //                   physics:
                    //                   NeverScrollableScrollPhysics(),
                    //                   shrinkWrap: true,
                    //                   itemBuilder: (context, index) {
                    //                     return Card(
                    //                       elevation: 1,
                    //                       child: Container(
                    //                         padding: EdgeInsets.symmetric(
                    //                             horizontal: 15,
                    //                             vertical: 15),
                    //                         width: size.width,
                    //                         child: Row(
                    //                           crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                           mainAxisAlignment:
                    //                           MainAxisAlignment
                    //                               .spaceBetween,
                    //                           children: [
                    //                             Column(
                    //                               crossAxisAlignment:
                    //                               CrossAxisAlignment
                    //                                   .start,
                    //                               children: [
                    //                                 Text(
                    //                                   data[index]
                    //                                       .monitoring
                    //                                       .name,
                    //                                   style: TITLE,
                    //                                 ),
                    //                                 SizedBox(height: 5),
                    //                                 Text(
                    //                                   data[index]
                    //                                       .monitoring
                    //                                       .serialNumber,
                    //                                   style: TextStyle(
                    //                                       fontSize: 11,
                    //                                       color: Color(
                    //                                           0xFF595D64),
                    //                                       fontWeight:
                    //                                       FontWeight
                    //                                           .w300,
                    //                                       fontFamily:
                    //                                       'Roboto'),
                    //                                 ),
                    //                                 SizedBox(height: 5),
                    //                                 Row(
                    //                                   children: [
                    //                                     Text(
                    //                                       'Condition : ',
                    //                                       style: TextStyle(
                    //                                           fontSize: 9,
                    //                                           color: Color(
                    //                                               0xFF595D64),
                    //                                           fontWeight:
                    //                                           FontWeight
                    //                                               .w600,
                    //                                           fontFamily:
                    //                                           'Roboto'),
                    //                                     ),
                    //                                     Text(
                    //                                       data[index]
                    //                                           .condition
                    //                                           .name,
                    //                                       style: TextStyle(
                    //                                           fontSize: 9,
                    //                                           color: Color(
                    //                                               0xFF595D64),
                    //                                           fontWeight:
                    //                                           FontWeight
                    //                                               .w500,
                    //                                           fontFamily:
                    //                                           'Roboto'),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                                 SizedBox(height: 8),
                    //                               ],
                    //                             ),
                    //                             // Column(
                    //                             //   crossAxisAlignment:
                    //                             //       CrossAxisAlignment.end,
                    //                             //   children: [
                    //                             //     Text(
                    //                             //       data[index].procurement,
                    //                             //       style: TextStyle(
                    //                             //           fontSize: 8,
                    //                             //           color: Color(0xFF9AA1AC),
                    //                             //           fontWeight: FontWeight.w400,
                    //                             //           fontFamily: 'Roboto'),
                    //                             //     ),
                    //                             //     SizedBox(height: 8),
                    //                             //     Text(
                    //                             //       NumberFormat.currency(
                    //                             //               locale: 'id',
                    //                             //               symbol: 'IDR ',
                    //                             //               decimalDigits: 0)
                    //                             //           .format(data[index].amount)
                    //                             //           .toString(),
                    //                             //       // 'IDR 18.981.000',
                    //                             //       style: TextStyle(
                    //                             //           fontSize: 10,
                    //                             //           color: Color(0xFF595D64),
                    //                             //           fontWeight: FontWeight.w500,
                    //                             //           fontFamily: 'Roboto'),
                    //                             //     ),
                    //                             //   ],
                    //                             // ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     );
                    //                   });
                    //             } else if (snapshot.connectionState ==
                    //                 ConnectionState.waiting) {
                    //               return Container(
                    //                 width: size.width,
                    //                 height: size.height,
                    //                 child: Center(
                    //                   child: CircularProgressIndicator(),
                    //                 ),
                    //               );
                    //             } else if (snapshot.connectionState ==
                    //                 ConnectionState.none) {
                    //               return Container(
                    //                 width: size.width,
                    //                 height: size.height,
                    //                 child: Center(
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                     MainAxisAlignment.center,
                    //                     children: [
                    //                       Image.asset(
                    //                           'assets/images/no_connection.png'),
                    //                       Text('No internet connection',
                    //                           style: TextStyle(
                    //                               fontSize: 13,
                    //                               color:
                    //                               Color(0xFF595D64),
                    //                               fontWeight:
                    //                               FontWeight.w500,
                    //                               fontFamily: 'Roboto')),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               );
                    //             } else {
                    //               return Container(
                    //                 width: size.width,
                    //                 height: size.height,
                    //                 child: Center(
                    //                   child: CircularProgressIndicator(),
                    //                 ),
                    //               );
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //     )
                    //         : ScrollConfiguration(
                    //       behavior: MyBehavior(),
                    //       child: SingleChildScrollView(
                    //         controller: _scrollController,
                    //         physics: AlwaysScrollableScrollPhysics(),
                    //         child: Container(
                    //           width: size.width,
                    //           height: size.height / 1.2,
                    //           child: Center(
                    //             child: Column(
                    //               mainAxisAlignment:
                    //               MainAxisAlignment.center,
                    //               children: [
                    //                 Image.asset(
                    //                     'assets/images/no_connection.png'),
                    //                 Text('No internet connection',
                    //                     style: TextStyle(
                    //                         fontSize: 13,
                    //                         color: Color(0xFF595D64),
                    //                         fontWeight: FontWeight.w500,
                    //                         fontFamily: 'Roboto')),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   bottom: 17,
            //   right: 22,
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       _value == 0
            //           ? Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => AssetScanScreen()))
            //           : Container();
            //     },
            //     child: _value == 0 ? Icon(Icons.qr_code) : Icon(Icons.add),
            //     backgroundColor: Color(0xFFF12A32),
            //   ),
            // ),
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
