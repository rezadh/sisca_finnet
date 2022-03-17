import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/voucher_model.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:sisca_finnet/widget/form_voucher.dart';

class VoucherScreen extends StatefulWidget {
  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  FToast fToast;

  @override
  void initState() {
    super.initState();
    setState(() {
      getRequestVoucher();

    });
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    fToast.showToast(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.grey,
          ),
          child: Text(
            'Copy to Clipboard',
            style: TextStyle(color: Colors.white),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
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
          'Voucher',
          style: TextStyle(
              fontSize: 19,
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
                        width: size.width,
                        height: size.height,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 100),
                        child: RefreshIndicator(
                          key: _refreshIndicatorKey,
                          onRefresh: getRequestVoucher,
                          child: Container(
                            width: size.width,
                            height: size.height,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: FutureBuilder<List<DataBawah>>(
                                future: getRequestVoucher(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<DataBawah> data = snapshot.data;
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
                                                          Text(
                                                            data[index].voucher ==
                                                                    null
                                                                ? '-'
                                                                : data[index]
                                                                    .voucher
                                                                    .voucherType,
                                                            style: TITLE,
                                                          ),
                                                          Divider(
                                                              color:
                                                                  Colors.white,
                                                              height: 8),
                                                          data[index].voucher ==
                                                                  null
                                                              ? Text(
                                                                  'Voucher Code : ',
                                                                  style: TITLE,
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                      data[index]
                                                                          .voucher
                                                                          .voucherCode,
                                                                      style:
                                                                          TITLE,
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            4),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                data[index].voucher.voucherCode));
                                                                        // showToast();
                                                                        _showToast();
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .file_copy_outlined,
                                                                        size:
                                                                            12,
                                                                        color: Color(
                                                                            0xFF595D64),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                          Divider(
                                                              color:
                                                                  Colors.white,
                                                              height: 4),
                                                          Text(
                                                            data[index].requestedDescription ?? '',
                                                            style: TextStyle(
                                                                fontSize: 9,
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
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(
                                                                color: data[index]
                                                                            .status
                                                                            .color ==
                                                                        'green'
                                                                    ? Color(
                                                                        0xFF52C829)
                                                                    : data[index].status.color ==
                                                                            'default'
                                                                        ? Color(
                                                                            0xFF595D64)
                                                                        : Color(
                                                                            0xFF598BD7),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              data[index]
                                                                  .status
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: data[index]
                                                                              .status
                                                                              .color ==
                                                                          'green'
                                                                      ? Color(
                                                                          0xFF52C829)
                                                                      : data[index].status.color ==
                                                                              'default'
                                                                          ? Color(
                                                                              0xFF595D64)
                                                                          : Color(
                                                                              0xFF598BD7),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                            ),
                                                          ),
                                                          Divider(
                                                              height: 8,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                            data[index]
                                                                .createdAt,
                                                            style: TextStyle(
                                                                fontSize: 10,
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
                                            },
                                          )
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50),
                                            margin: EdgeInsets.only(
                                                top: size.height / 3),
                                            width: size.width,
                                            height: size.height / 2,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                      'assets/images/empty_data.png'),
                                                  Text(
                                                    'No Requests yet..',
                                                    style: TextStyle(
                                                        fontSize: 13,
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
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
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
                            showDialog(
                                context: context,
                                builder: (context) => FormVoucher(
                                      level: prefs.getString('level'),
                                    ));
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
