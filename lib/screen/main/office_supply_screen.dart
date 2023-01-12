import 'package:connectivity/connectivity.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/office_supply_model.dart';
import 'package:sisca_finnet/model/user_leader_model.dart';
import 'package:sisca_finnet/model/user_vp_model.dart';
import 'package:sisca_finnet/model/voucher_model.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:sisca_finnet/widget/custom_dropdown_office_supply.dart';
import 'package:sisca_finnet/widget/custom_dropdown_user_leader.dart';
import 'package:sisca_finnet/widget/custom_dropdown_user_vp.dart';

class OfficeSupplyScreen extends StatefulWidget {
  @override
  _OfficeSupplyScreenState createState() => _OfficeSupplyScreenState();
}

class _OfficeSupplyScreenState extends State<OfficeSupplyScreen> {
  FToast fToast;
  Future<List<DataBawahOfficeSupply>> futureOfficeSupply;
  final _formKey = GlobalKey<FormState>();
  TextEditingController keperluanController = TextEditingController();
  TextEditingController voucherTotalController = TextEditingController();
  var _labelTextKeperluan = 'Keperluan';
  var _labelTextVoucherTotal = 'Jumlah voucher';
  String _keperluan;
  String _voucherTotal;
  String _description;
  String _officeSupply;
  String _level;
  String _idReviewer;
  String _usernameReviewer;
  String _avatarReviewer;
  String _firstnameReviewer;
  String _lastnameReviewer;
  var _levelReviewer;
  String _userPositionReviewer;
  String _idApprover;
  String _idOfficeSupply;
  String _nameOfficeSupply;
  String _codeOfficeSupply;
  String _usernameApprover;
  String _avatarApprover;
  String _firstnameApprover;
  String _lastnameApprover;
  var _levelApprover;
  String _userPositionApprover;
  bool _value = false;
  bool _submitRequest = false;
  bool _isInternetOn = true;
  final _scrollController = ScrollController();

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

  Future _isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetOn = false;
        EasyLoading.showError('No Connection');
      });
    } else {
      setState(() {
        _isInternetOn = true;
        _postStoreOfficeSupply();
      });
    }
  }

  void _postStoreOfficeSupply() async {
    Map body = {
      'office_supply_description': _keperluan ?? '',
      'reviewed_to': _idReviewer,
      'office_supply_quantity': _voucherTotal ?? 0,
      'office_supply_id': _idOfficeSupply,
    };
    print(body);
    await postRequestOfficeSupply(body).then((value) {
      EasyLoading.dismiss();
      if (value.data != null) {
        EasyLoading.showSuccess('Sukses');
        Navigator.pop(context, true);
        setState(() {
          getRequestOfficeSupply();
        });
        return;
      } else {
        EasyLoading.showError('Failed');
        return null;
      }
    });
  }

  Future<void> refreshOfficeSupply() async {
    // await postRequestMaintenance();
    // await Future.delayed(Duration(seconds: 2));
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetOn = false;
      });
    } else {
      await getRequestOfficeSupply();
      setState(() {
        _isInternetOn = true;
      });
    }
    setState(() {
      futureOfficeSupply = getRequestOfficeSupply();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getConnect();
      futureOfficeSupply = getRequestOfficeSupply();
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
          'Office Supply Request',
          style: TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
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
                width: size.width,
                height: size.height,
                padding: EdgeInsets.only(left: 15, right: 15, top: 100),
                child: RefreshIndicator(
                  onRefresh: refreshOfficeSupply,
                  child: _isInternetOn
                      ? Container(
                    width: size.width,
                    height: size.height,
                    child: FutureBuilder<List<DataBawahOfficeSupply>>(
                      future: getRequestOfficeSupply(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DataBawahOfficeSupply> data = snapshot.data;
                          return data.isNotEmpty
                              ? ListView.builder(
                            itemCount: data.length,
                            physics: const BouncingScrollPhysics(
                                parent:
                                AlwaysScrollableScrollPhysics()),
                            itemBuilder: (context, index) {
                              String item;
                              if(int.parse(data[index].officeSupplyQuantity) > 1){
                                item = 'items';
                              }else {
                                item = 'item';
                              }
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
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            data[index].officeSupplyName ==
                                                null
                                                ? '-'
                                                : data[index]
                                                .officeSupplyName,
                                            style: TITLE,
                                          ),
                                          Divider(
                                              color: Colors.white,
                                              height: 5),
                                          data[index].officeSupplyQuantity ==
                                              null
                                              ? Text('-', style: TITLE) : Text(
                                            '${data[index].officeSupplyQuantity} $item',
                                            style: TITLE,
                                          ),
                                          Divider(
                                              color: Colors.white,
                                              height: 5),
                                          Text(
                                            data[index].officeSupplyDescription ==
                                                null
                                                ? '-'
                                                : data[index]
                                                .officeSupplyDescription,
                                            style: TITLE,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets
                                                .symmetric(
                                                horizontal: 10,
                                                vertical: 4),
                                            decoration:
                                            BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Color(0xFF595D64),
                                                // color: data[index]
                                                //             .status
                                                //             .color ==
                                                //         'green'
                                                //     ? Color(
                                                //         0xFF52C829)
                                                //     : data[index]
                                                //                 .status
                                                //                 .color ==
                                                //             'default'
                                                //         ? Color(
                                                //             0xFF595D64)
                                                //         : Color(
                                                //             0xFF598BD7),
                                              ),
                                              borderRadius:
                                              BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Text(
                                              // 'Under Review',
                                              data[index]
                                                  .status
                                                  .name,
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  // color: Color(0xFF595D64),
                                                  color: data[index]
                                                              .status
                                                              .color ==
                                                          'green'
                                                      ? Color(
                                                          0xFF52C829)
                                                      : data[index]
                                                                  .status
                                                                  .color ==
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
                                          // Container(
                                          //   padding: EdgeInsets
                                          //       .symmetric(
                                          //       horizontal: 10,
                                          //       vertical: 4),
                                          //   decoration:
                                          //   BoxDecoration(
                                          //     color: Colors.white,
                                          //     border: Border.all(
                                          //       color: data[index]
                                          //           .status
                                          //           .color ==
                                          //           'green'
                                          //           ? Color(
                                          //           0xFF52C829)
                                          //           : data[index]
                                          //           .status
                                          //           .color ==
                                          //           'default'
                                          //           ? Color(
                                          //           0xFF595D64)
                                          //           : Color(
                                          //           0xFF598BD7),
                                          //     ),
                                          //     borderRadius:
                                          //     BorderRadius.all(
                                          //       Radius.circular(5),
                                          //     ),
                                          //   ),
                                          //   child: Text(
                                          //     data[index]
                                          //         .status
                                          //         .name,
                                          //     style: TextStyle(
                                          //         fontSize: 10,
                                          //         color: data[index]
                                          //             .status
                                          //             .color ==
                                          //             'green'
                                          //             ? Color(
                                          //             0xFF52C829)
                                          //             : data[index]
                                          //             .status
                                          //             .color ==
                                          //             'default'
                                          //             ? Color(
                                          //             0xFF595D64)
                                          //             : Color(
                                          //             0xFF598BD7),
                                          //         fontWeight:
                                          //         FontWeight
                                          //             .w300,
                                          //         fontFamily:
                                          //         'Roboto'),
                                          //   ),
                                          // ),
                                          Divider(
                                              height: 8,
                                              color: Colors.white),
                                          Text(
                                            data[index].createdAt,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(
                                                    0xFF595D64),
                                                fontWeight:
                                                FontWeight.w400,
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
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],
                              ),
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
                          return Center(
                              child: CircularProgressIndicator());
                        }
                      },
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
                onPressed: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  setState(() {
                    _level = prefs.getString('level');
                    keperluanController.text = '';
                    voucherTotalController.text = '';
                    _value = false;
                    _submitRequest = false;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                scrollable: true,
                                content: Form(
                                  key: _formKey,
                                  child: Container(
                                    width: size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Office Supply request form',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        Divider(color: Colors.white),
                                        DropdownSearch<OfficeSupplyAsset>(
                                          validator: (v) => v == null
                                              ? "Required Field"
                                              : null,
                                          showSelectedItems: true,
                                          mode: Mode.MENU,
                                          compareFn: (i, s) =>
                                          i?.isEqual(s) ?? false,
                                          dropdownSearchDecoration:
                                          InputDecoration(
                                            labelText:
                                            "Office Supply",
                                            hintText:
                                            "Office Supply",
                                            contentPadding:
                                            EdgeInsets.fromLTRB(
                                                12, 12, 0, 0),
                                            border: OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Color(0xFFBAC1CC)),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Color(0xFFBAC1CC)),
                                            ),
                                            errorStyle: TextStyle(
                                                fontSize: 8,
                                                color: Color(0xFFF12A32),
                                                fontWeight:
                                                FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          autoValidateMode:
                                          AutovalidateMode
                                              .onUserInteraction,
                                          onFind: (String filter) =>
                                              getRequestAssetOfficeSupply(),
                                          onChanged: (value) {
                                            setState(() {
                                              print(value.id);
                                              _idOfficeSupply = value.id;
                                              _nameOfficeSupply = value.name;
                                              _codeOfficeSupply = value.code;
                                            });
                                          },
                                          dropdownBuilder:
                                          customDropDownOfficeSupply,
                                          popupItemBuilder:
                                          customPopupItemBuilderOfficeSupply,
                                        ),
                                        Divider(color: Colors.white, height: 5),
                                        Text(
                                          'Click to choose Office Supply',
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xFFBAC1CC),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto'),
                                        ),
                                        Divider(color: Colors.white, height: 15),
                                        TextFormField(
                                          maxLines: 2,
                                          keyboardType: TextInputType.text,
                                          controller: keperluanController,
                                          // style: TextStyle(fontSize: 10),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: _labelTextKeperluan,
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFBAC1CC)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFBAC1CC)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFBAC1CC)),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 5.0),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFFFFFFF),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _labelTextKeperluan =
                                              'Keperluan';
                                            });
                                          },
                                          onChanged: (value) {
                                            _keperluan = value;
                                          },
                                          onFieldSubmitted: (value) {
                                            setState(() {
                                              _keperluan = value;
                                            });
                                          },
                                        ),
                                        Divider(color: Colors.white, height: 5),
                                        Text(
                                          'Ex. Daily Operational ...',
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xFFBAC1CC),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto'),
                                        ),
                                        Divider(color: Colors.white, height: 15),

                                        TextFormField(
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          controller: voucherTotalController,
                                          // style: TextStyle(fontSize: 10),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: _labelTextVoucherTotal,
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFBAC1CC)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFBAC1CC)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFBAC1CC)),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 5.0),
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFFFFFFF),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _labelTextVoucherTotal =
                                              'Jumlah';
                                            });
                                          },
                                          onChanged: (value) {
                                            _voucherTotal = value;
                                          },
                                          onFieldSubmitted: (value) {
                                            setState(() {
                                              _voucherTotal = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Masukan Jumlah Yang Dibutuhkan',
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xFFBAC1CC),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto'),
                                        ),
                                        Divider(
                                            color: Colors.white, height: 24),
                                        Text(
                                          'Office Supply Review',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF595D64),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Roboto'),
                                        ),
                                        Divider(
                                            color: Colors.white, height: 16),
                                        Visibility(
                                          visible: _level == '2'
                                                  ? true
                                                  : true,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DropdownSearch<UserLeader>(
                                                validator: (v) => v == null
                                                    ? "Required Field"
                                                    : null,
                                                showSelectedItems: true,
                                                mode: Mode.MENU,
                                                compareFn: (i, s) =>
                                                    i?.isEqual(s) ?? false,
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelText:
                                                      "Request review to *",
                                                  hintText:
                                                      "Request review to *",
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12, 12, 0, 0),
                                                  border: OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFBAC1CC)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFBAC1CC)),
                                                  ),
                                                  errorStyle: TextStyle(
                                                      fontSize: 8,
                                                      color: Color(0xFFF12A32),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Roboto'),
                                                ),
                                                autoValidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                onFind: (String filter) =>
                                                    postRequestUserLeader(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    print(value.id);
                                                    _idReviewer = value.id;
                                                    _avatarReviewer =
                                                        value.avatar;
                                                    _usernameReviewer =
                                                        value.username;
                                                    _firstnameReviewer =
                                                        value.firstName;
                                                    _lastnameReviewer =
                                                        value.lastName;
                                                    _levelReviewer =
                                                        value.level;
                                                    _userPositionReviewer =
                                                        value.userPosition.name;
                                                  });
                                                },
                                                dropdownBuilder:
                                                    customDropDownUserLeader,
                                                popupItemBuilder:
                                                    customPopupItemBuilderUserLeader,
                                              ),
                                              Divider(
                                                  color: Colors.white,
                                                  height: 5),
                                              Text(
                                                'Choose to whom request to be reviewed',
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFFBAC1CC),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Divider(color: Colors.white),
                                            ],
                                          ),
                                        ),
                                        // Visibility(
                                        //   visible: _level == '1' ? false : true,
                                        //   child: Container(
                                        //     child: Column(
                                        //       crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //       children: [
                                        //         DropdownSearch<UserVp>(
                                        //           validator: (v) => v == null
                                        //               ? "Required Field"
                                        //               : null,
                                        //           showSelectedItems: true,
                                        //           mode: Mode.MENU,
                                        //           compareFn: (i, s) =>
                                        //           i?.isEqual(s) ?? false,
                                        //           dropdownSearchDecoration:
                                        //           InputDecoration(
                                        //             labelText:
                                        //             "Request approval to *",
                                        //             hintText:
                                        //             "Request approval to *",
                                        //             contentPadding:
                                        //             EdgeInsets.fromLTRB(
                                        //                 12, 12, 0, 0),
                                        //             border:
                                        //             OutlineInputBorder(),
                                        //             focusedBorder:
                                        //             OutlineInputBorder(
                                        //               borderSide: BorderSide(
                                        //                   color: Color(
                                        //                       0xFFBAC1CC)),
                                        //             ),
                                        //             enabledBorder:
                                        //             OutlineInputBorder(
                                        //               borderSide: BorderSide(
                                        //                   color: Color(
                                        //                       0xFFBAC1CC)),
                                        //             ),
                                        //             errorStyle: TextStyle(
                                        //                 fontSize: 8,
                                        //                 color:
                                        //                 Color(0xFFF12A32),
                                        //                 fontWeight:
                                        //                 FontWeight.w400,
                                        //                 fontFamily: 'Roboto'),
                                        //           ),
                                        //           autoValidateMode:
                                        //           AutovalidateMode
                                        //               .onUserInteraction,
                                        //           onFind: (String filter) =>
                                        //               postRequestUserVp(),
                                        //           onChanged: (value) {
                                        //             setState(() {
                                        //               _idApprover = value.id;
                                        //               _avatarApprover =
                                        //                   value.avatar;
                                        //               _usernameApprover =
                                        //                   value.username;
                                        //               _firstnameApprover =
                                        //                   value.firstName;
                                        //               _lastnameApprover =
                                        //                   value.lastName;
                                        //               _levelApprover =
                                        //                   value.level;
                                        //               _userPositionApprover =
                                        //                   value.userPosition
                                        //                       .name;
                                        //             });
                                        //           },
                                        //           dropdownBuilder:
                                        //           customDropDownUserVp,
                                        //           popupItemBuilder:
                                        //           customPopupItemBuilderUserVp,
                                        //         ),
                                        //         Divider(
                                        //             color: Colors.white,
                                        //             height: 5),
                                        //         Text(
                                        //           'Choose to whom request to be approved',
                                        //           style: TextStyle(
                                        //               fontSize: 8,
                                        //               color: Color(0xFFBAC1CC),
                                        //               fontWeight:
                                        //               FontWeight.w400,
                                        //               fontFamily: 'Roboto'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        Visibility(
                                          visible: true,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: -25,
                                                  child: Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    child: CheckboxListTile(
                                                      title: Text(
                                                        'I have reviewed this voucher request',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Color(
                                                                0xFF6E7178),
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            fontFamily:
                                                            'Roboto'),
                                                      ),
                                                      value: _value,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _value = value;
                                                          if (_value) {
                                                            _submitRequest =
                                                            true;
                                                            if (!_formKey
                                                                .currentState
                                                                .validate()) {
                                                              _submitRequest =
                                                              false;
                                                              _value = false;
                                                            } else if (_formKey
                                                                .currentState
                                                                .validate()) {
                                                              _submitRequest =
                                                              true;
                                                              _value = true;
                                                            }
                                                          } else {
                                                            _submitRequest =
                                                            false;
                                                          }
                                                        });
                                                      },
                                                      controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                            color: Colors.white, height: 15),
                                        Visibility(
                                          visible: _value
                                              ? _level == '2'
                                              ? true
                                              : true
                                              : false,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'This will send notification for review & approval to : ',
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Color(0xFF6E7178),
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontFamily: 'Roboto'),
                                                ),
                                                Divider(
                                                    color: Colors.white,
                                                    height: 5),
                                                Visibility(
                                                  visible: _level == '2'
                                                      ? true
                                                      : true,
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Reviewer : ',
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              color: Color(
                                                                  0xFF6E7178),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Roboto'),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              _usernameReviewer ==
                                                                      null
                                                                  ? Container()
                                                                  : Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              50),
                                                                        ),
                                                                        child: _avatarReviewer ==
                                                                                null
                                                                            ? Image.asset(
                                                                                'assets/images/placeholder.png',
                                                                                width: 30,
                                                                                height: 30,
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : Image.network(
                                                                                BASE_URL_STORAGE + _avatarReviewer,
                                                                                width: 30,
                                                                                height: 30,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                      ),
                                                                    ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Container(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          _usernameReviewer == null
                                                                              ? ''
                                                                              : '$_usernameReviewer - ',
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Color(0xFF595D64),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: 'Roboto'),
                                                                        ),
                                                                        Text(
                                                                          _firstnameReviewer == null
                                                                              ? ''
                                                                              : '$_firstnameReviewer ',
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Color(0xFF595D64),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: 'Roboto'),
                                                                        ),
                                                                        Text(
                                                                          _lastnameReviewer ??
                                                                              '',
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Color(0xFF595D64),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: 'Roboto'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                        color: Colors
                                                                            .white,
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          _levelReviewer == null
                                                                              ? ''
                                                                              : 'Level $_levelReviewer - ',
                                                                          style: TextStyle(
                                                                              fontSize: 8,
                                                                              color: Color(0xFF595D64),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: 'Roboto'),
                                                                        ),
                                                                        Text(
                                                                          _userPositionReviewer ??
                                                                              '',
                                                                          style: TextStyle(
                                                                              fontSize: 8,
                                                                              color: Color(0xFF595D64),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: 'Roboto'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Divider(
                                                //     color: Colors.white,
                                                //     height: 10),
                                                // Visibility(
                                                //   visible: _level == '1'
                                                //       ? false
                                                //       : true,
                                                //   child: Container(
                                                //     child: Row(
                                                //       children: [
                                                //         Text(
                                                //           'Approver : ',
                                                //           style: TextStyle(
                                                //               fontSize: 8,
                                                //               color: Color(
                                                //                   0xFF6E7178),
                                                //               fontWeight:
                                                //               FontWeight
                                                //                   .w500,
                                                //               fontFamily:
                                                //               'Roboto'),
                                                //         ),
                                                //         SizedBox(width: 10),
                                                //         Container(
                                                //           child: Row(
                                                //             mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .center,
                                                //             children: [
                                                //               _usernameApprover ==
                                                //                   null
                                                //                   ? Container()
                                                //                   : Container(
                                                //                 padding: EdgeInsets.symmetric(
                                                //                     vertical:
                                                //                     5),
                                                //                 child:
                                                //                 ClipRRect(
                                                //                   borderRadius:
                                                //                   BorderRadius.all(
                                                //                     Radius.circular(
                                                //                         50),
                                                //                   ),
                                                //                   child: _avatarApprover ==
                                                //                       null
                                                //                       ? Image.asset(
                                                //                     'assets/images/placeholder.png',
                                                //                     width: 30,
                                                //                     height: 30,
                                                //                     fit: BoxFit.cover,
                                                //                   )
                                                //                       : Image.network(
                                                //                     BASE_URL_STORAGE + _avatarApprover,
                                                //                     width: 30,
                                                //                     height: 30,
                                                //                     fit: BoxFit.cover,
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //               SizedBox(
                                                //                   width: 5),
                                                //               Container(
                                                //                 child: Column(
                                                //                   crossAxisAlignment:
                                                //                   CrossAxisAlignment
                                                //                       .start,
                                                //                   children: [
                                                //                     Row(
                                                //                       children: [
                                                //                         Text(
                                                //                           _usernameApprover == null
                                                //                               ? ''
                                                //                               : '$_usernameApprover - ',
                                                //                           style: TextStyle(
                                                //                               fontSize: 10,
                                                //                               color: Color(0xFF595D64),
                                                //                               fontWeight: FontWeight.w400,
                                                //                               fontFamily: 'Roboto'),
                                                //                         ),
                                                //                         Text(
                                                //                           _firstnameApprover == null
                                                //                               ? ''
                                                //                               : '$_firstnameApprover ',
                                                //                           style: TextStyle(
                                                //                               fontSize: 10,
                                                //                               color: Color(0xFF595D64),
                                                //                               fontWeight: FontWeight.w400,
                                                //                               fontFamily: 'Roboto'),
                                                //                         ),
                                                //                         Text(
                                                //                           _lastnameApprover ??
                                                //                               '',
                                                //                           style: TextStyle(
                                                //                               fontSize: 10,
                                                //                               color: Color(0xFF595D64),
                                                //                               fontWeight: FontWeight.w400,
                                                //                               fontFamily: 'Roboto'),
                                                //                         ),
                                                //                       ],
                                                //                     ),
                                                //                     Divider(
                                                //                         color: Colors
                                                //                             .white,
                                                //                         height:
                                                //                         5),
                                                //                     Row(
                                                //                       children: [
                                                //                         Text(
                                                //                           _levelApprover == null
                                                //                               ? ''
                                                //                               : 'Level $_levelApprover - ',
                                                //                           style: TextStyle(
                                                //                               fontSize: 8,
                                                //                               color: Color(0xFF595D64),
                                                //                               fontWeight: FontWeight.w400,
                                                //                               fontFamily: 'Roboto'),
                                                //                         ),
                                                //                         Text(
                                                //                           _userPositionApprover ??
                                                //                               '',
                                                //                           style: TextStyle(
                                                //                               fontSize: 8,
                                                //                               color: Color(0xFF595D64),
                                                //                               fontWeight: FontWeight.w500,
                                                //                               fontFamily: 'Roboto'),
                                                //                         ),
                                                //                       ],
                                                //                     ),
                                                //                   ],
                                                //                 ),
                                                //               ),
                                                //             ],
                                                //           ),
                                                //         ),
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                                Divider(
                                                    height: 33,
                                                    color: Colors.white),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width,
                                          height: 44,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8.0)),
                                              ),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  _submitRequest == false
                                                      ? Color(0xFF95989A)
                                                      : Color(0xFFF12A32)),
                                            ),
                                            child: Text(
                                              'Submit request',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            onPressed: () {
                                              if (_submitRequest) {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    EasyLoading.show(
                                                        status: 'Loading');
                                                    _isConnected();
                                                  });
                                                  return;
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        });
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
