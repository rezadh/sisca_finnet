import 'package:connectivity/connectivity.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/trip_model.dart';
import 'package:sisca_finnet/model/trip_vehicle_model.dart';
import 'package:sisca_finnet/model/user_leader_model.dart';
import 'package:sisca_finnet/model/user_vp_model.dart';
import 'package:sisca_finnet/model/voucher_model.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:sisca_finnet/widget/custom_dropdown_trip_vehicle.dart';
import 'package:sisca_finnet/widget/custom_dropdown_user_leader.dart';
import 'package:sisca_finnet/widget/custom_dropdown_user_vp.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  FToast fToast;
  Future<List<DataBawahTripRequest>> futureTripRequest;
  final _formKey = GlobalKey<FormState>();
  TextEditingController tujuanController = TextEditingController();
  TextEditingController keperluanController = TextEditingController();
  TextEditingController dateTripController = TextEditingController();
  var _labelTextTujuan = 'Tujuan';
  var _labelTextKeperluan = 'Keperluan';
  var _labelTextdateTrip = 'Tanggal';
  var _tanggalTrip;
  String _keperluan;
  String _tujuan;
  String _dateTrip;
  String _level;
  String _idReviewer;
  String _usernameReviewer;
  String _avatarReviewer;
  String _firstnameReviewer;
  String _lastnameReviewer;
  var _levelReviewer;
  String _userPositionReviewer;
  String _idVehicle;
  String _idApprover;
  String _usernameApprover;
  String _avatarApprover;
  String _firstnameApprover;
  String _lastnameApprover;
  var _levelApprover;
  String _userPositionApprover;
  bool _isChecked = true;
  bool _value = false;
  bool _valueDriver = false;
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
        _postStoreTripRequest();
      });
    }
  }

  void _postStoreTripRequest() async {
    Map body = {
      'trip_id': _idVehicle,
      'trip_destination': _tujuan ?? '',
      'trip_description': _keperluan ?? '',
      'required_driver': _valueDriver == true ? 1 : 0,
      'trip_date_time': _dateTrip,
      'reviewed_to': _idReviewer
    };
    print(body);
    await postStoreTripRequest(body).then((value) {
      EasyLoading.dismiss();
      if (value.data != null) {
        EasyLoading.showSuccess('Sukses');
        Navigator.pop(context, true);
        setState(() {
          getRequestTripRequest();
        });
        return;
      } else {
        EasyLoading.showError('Failed');
        return null;
      }
    });
  }

  Future<void> refreshTripRequest() async {
    // await postRequestMaintenance();
    // await Future.delayed(Duration(seconds: 2));
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetOn = false;
      });
    } else {
      await getRequestTripRequest();
      setState(() {
        _isInternetOn = true;
      });
    }
    setState(() {
      futureTripRequest = getRequestTripRequest();
    });
  }

  dateTimePickerWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      pickerMode: DateTimePickerMode.date,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        _dateTrip = DateFormat('yyyy-MM-dd HH:mm').format(selectdate);
        dateTripController.text = _dateTrip;
        print(_dateTrip);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getConnect();
      futureTripRequest = getRequestTripRequest();
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

  _getDate(String _date) {
    DateTime dateFormat = DateFormat('yyyy-MM-dd HH:mm').parse(_date);
    var date = DateFormat('dd').format(dateFormat);
    var month = DateFormat('MM').format(dateFormat);
    var year = DateFormat('yyyy').format(dateFormat);
    var hour = DateFormat('HH').format(dateFormat);
    var minute = DateFormat('mm').format(dateFormat);
    String parseMonth;
    if (month == '01') {
      parseMonth = 'Januari';
    } else if (month == '02') {
      parseMonth = 'Februari';
    } else if (month == '03') {
      parseMonth = 'Maret';
    } else if (month == '04') {
      parseMonth = 'April';
    } else if (month == '05') {
      parseMonth = 'Mei';
    } else if (month == '06') {
      parseMonth = 'Juni';
    } else if (month == '07') {
      parseMonth = 'Juli';
    } else if (month == '08') {
      parseMonth = 'Agustus';
    } else if (month == '09') {
      parseMonth = 'September';
    } else if (month == '10') {
      parseMonth = 'Oktober';
    } else if (month == '11') {
      parseMonth = 'November';
    } else if (month == '12') {
      parseMonth = 'Desember';
    }
    _tanggalTrip = '$date $parseMonth $year $hour:$minute';
    return _tanggalTrip;
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
          'Trip Request',
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
                  onRefresh: refreshTripRequest,
                  child: _isInternetOn
                      ? Container(
                          width: size.width,
                          height: size.height,
                          child: FutureBuilder<List<DataBawahTripRequest>>(
                            future: getRequestTripRequest(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<DataBawahTripRequest> data = snapshot.data;
                                return data.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: data.length,
                                        physics: const BouncingScrollPhysics(
                                            parent:
                                                AlwaysScrollableScrollPhysics()),
                                        itemBuilder: (context, index) {
                                          _getDate(data[index].tripDateTime);
                                          // print(_getDate(data[index].tripDateTime));
                                          // print(data[index].tripDateTime);
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
                                                        data[index].tripDestination ==
                                                                null
                                                            ? '-'
                                                            : data[index]
                                                                .tripDestination,
                                                        style: TITLE,
                                                      ),
                                                      Divider(
                                                          color: Colors.white,
                                                          height: 8),
                                                      data[index].tripDateTime ==
                                                              null
                                                          ? Text(
                                                              '-',
                                                              style: TITLE,
                                                            )
                                                          : Text(_tanggalTrip),
                                                      Divider(
                                                          color: Colors.white,
                                                          height: 4),
                                                      Text(
                                                        data[index]
                                                                .tripDescription ??
                                                            '-',
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            color: Color(
                                                                0xFF595D64),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontFamily:
                                                                'Roboto'),
                                                      ),
                                                      Divider(
                                                          color: Colors.white,
                                                          height: 15),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            data[index].trip ==
                                                                    null
                                                                ? '-'
                                                                : data[index]
                                                                        .trip
                                                                        .vehicleCode ??
                                                                    '-',
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
                                                          SizedBox(width: 10),
                                                          Visibility(
                                                            visible: data[index].requiredDriver == 1 ? true : false,
                                                            child: Container(
                                                              child: Row(
                                                                children: [
                                                                  Transform.scale(
                                                                    scale: 0.6,
                                                                    child: Checkbox(
                                                                      visualDensity: VisualDensity(horizontal: -4),
                                                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                      fillColor: MaterialStateProperty
                                                                          .resolveWith<
                                                                              Color>((Set<
                                                                                  MaterialState>
                                                                              states) {
                                                                        if (states.contains(
                                                                            MaterialState
                                                                                .disabled)) {
                                                                          return Colors
                                                                              .red;
                                                                        }
                                                                        return Colors
                                                                            .orange;
                                                                      }),
                                                                      checkColor:
                                                                          Colors.white,
                                                                      // fillColor: MaterialStateColor.resolveWith(),
                                                                      value: _isChecked,
                                                                      onChanged: null,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Dengan Driver',
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          //     Visibility(
                                                          //       visible: data[index]
                                                          // .requiredDriver == 1 ? true : false,
                                                          //       child: Container(
                                                          //         padding: EdgeInsets
                                                          //             .symmetric(
                                                          //             horizontal: 10,
                                                          //             vertical: 4),
                                                          //         decoration:
                                                          //         BoxDecoration(
                                                          //           color: Colors.white,
                                                          //           border: Border.all(
                                                          //             color: Color(0xFFCF1D23)
                                                          //           ),
                                                          //           borderRadius:
                                                          //           BorderRadius.all(
                                                          //             Radius.circular(5),
                                                          //           ),
                                                          //         ),
                                                          //         child: Text(
                                                          //           data[index]
                                                          //               .requiredDriver == 1 ? 'Butuh Driver' : '',
                                                          //           style: TextStyle(
                                                          //               fontSize: 9,
                                                          //               color: Color(0xFFCF1D23),
                                                          //               fontWeight:
                                                          //               FontWeight
                                                          //                   .w300,
                                                          //               fontFamily:
                                                          //               'Roboto'),
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     SizedBox(width: 5),
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
                                                                color: Color(
                                                                    0xFF595D64),
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
                                                                  fontSize: 9,
                                                                  // color: Color(0xFF595D64),
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
                                                        ],
                                                      ),
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
                    tujuanController.text = '';
                    keperluanController.text = '';
                    dateTripController.text = '';
                    _value = false;
                    _valueDriver = false;
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
                                            'Trip request form',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        Divider(color: Colors.white),
                                        TextFormField(
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          controller: tujuanController,
                                          // style: TextStyle(fontSize: 10),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: _labelTextTujuan,
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
                                              _labelTextTujuan = 'Tujuan';
                                            });
                                          },
                                          onChanged: (value) {
                                            _tujuan = value;
                                          },
                                          onFieldSubmitted: (value) {
                                            setState(() {
                                              _tujuan = value;
                                            });
                                          },
                                        ),
                                        Divider(color: Colors.white, height: 5),
                                        Text(
                                          'Ex. Telkom Landmark Tower, Jl. Gatot Subroto',
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xFFBAC1CC),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto'),
                                        ),
                                        Divider(
                                            color: Colors.white, height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DropdownSearch<
                                                DataBawahTripVehicle>(
                                              validator: (v) => v == null
                                                  ? "Required Field"
                                                  : null,
                                              showSelectedItems: true,
                                              mode: Mode.MENU,
                                              compareFn: (i, s) =>
                                                  i?.isEqual(s) ?? false,
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText: "Vehicle",
                                                hintText: "Vehicle",
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        12, 12, 0, 0),
                                                border: OutlineInputBorder(),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFBAC1CC)),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFBAC1CC)),
                                                ),
                                                errorStyle: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFFF12A32),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              onFind: (String filter) =>
                                                  getRequestTripVehicle(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _idVehicle = value.id;
                                                });
                                              },
                                              dropdownBuilder:
                                                  customDropDownTripVehicle,
                                              popupItemBuilder:
                                                  customPopupItemBuilderTripVehicle,
                                            ),
                                            Divider(
                                                color: Colors.white, height: 5),
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
                                        TextFormField(
                                          maxLines: 3,
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
                                              _labelTextKeperluan = 'Keperluan';
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
                                          'Ex. Meeting dengan client ...',
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xFFBAC1CC),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Roboto'),
                                        ),
                                        Divider(
                                            color: Colors.white, height: 15),

                                        GestureDetector(
                                          onTap: () {
                                            dateTimePickerWidget(context);
                                          },
                                          child: TextFormField(
                                            maxLines: 1,
                                            enabled: false,
                                            keyboardType: TextInputType.text,
                                            controller: dateTripController,
                                            // style: TextStyle(fontSize: 10),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              labelText: _labelTextdateTrip,
                                              disabledBorder:
                                                  OutlineInputBorder(
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
                                                _labelTextdateTrip = 'Tanggal';
                                              });
                                            },
                                            onChanged: (value) {
                                              _dateTrip = value;
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                _dateTrip = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: -25,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: CheckboxListTile(
                                                    title: Text(
                                                      'Butuh Driver',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              Color(0xFF6E7178),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: 'Roboto'),
                                                    ),
                                                    value: _valueDriver,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _valueDriver = value;
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
                                        Divider(
                                            color: Colors.white, height: 24),
                                        Text(
                                          'Trip request review',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF595D64),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Roboto'),
                                        ),
                                        Divider(
                                            color: Colors.white, height: 16),
                                        Visibility(
                                          visible: _level == '2' ? false : true,
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
                                                  'This will send notification for review to : ',
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
