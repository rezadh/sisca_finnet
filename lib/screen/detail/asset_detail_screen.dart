import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/screen/report_opname_form_screen.dart';
import 'package:sisca_finnet/util/const.dart';

class AssetDetailScreen extends StatefulWidget {
  final id;

  AssetDetailScreen({this.id});

  @override
  _AssetDetailScreenState createState() => _AssetDetailScreenState();
}

class _AssetDetailScreenState extends State<AssetDetailScreen> {
  String _name;
  String _serialNumber;
  String _username;
  String _firstName;
  String _lastName;
  String _email;
  String _brandOrType;
  String _startDate;
  String _lastOpnameCondition;
  String _colorLastOpnameCondition;
  String _avatar;
  int _usefulLife;
  int _amount;
  String _description;
  bool _loading = true;
  bool _isInternetOn = true;
  bool _data = true;
  TextEditingController descriptionController = TextEditingController();

  _getWidget() async {
    _getConnect();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var statusCode = prefs.getInt('status_asset');
    await getRequestAssetDetail(widget.id).then((value) {
      if (mounted) {
        if (statusCode == 400) {
          setState(() {
            _data = false;
            _loading = false;
          });
        } else {
          setState(() {
            _loading = false;
            _data = true;
            _name = value.data.name;
            _serialNumber = value.data.serialNumber;
            _username = value.data.pic.username;
            _firstName = value.data.pic.firstName;
            _lastName = value.data.pic.lastName;
            _email = value.data.pic.email;
            _avatar = value.data.pic.avatar;
            _brandOrType = value.data.brandOrType;
            _startDate = value.data.startDate;
            _usefulLife = value.data.usefulLife;
            _amount = value.data.amount;
            _description = value.data.description;
            print(value.data.latestOpname);
            if (value.data.latestOpname == null) {
              _lastOpnameCondition = null;
              _colorLastOpnameCondition = null;
            } else {
              _lastOpnameCondition = value.data.latestOpname.condition.name;
              var parts = value.data.latestOpname.condition.color.split('#');
              _colorLastOpnameCondition = '0xFF${parts[1].trim()}';
            }
          });
        }
      }
    });
  }

  Future _getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetOn = false;
      });
    } else {
      setState(() {
        _isInternetOn = true;
      });
    }
  }

  @override
  void initState() {
    _getWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Asset detail',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto'),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 0,
                child: _isInternetOn
                    ? _loading
                        ? Container(
                            width: size.width,
                            height: size.height,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : _data
                            ? Container(
                                width: size.width,
                                height: size.height,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_name ?? '',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF595D64),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto')),
                                    Divider(color: Colors.white, height: 8),
                                    Text(_serialNumber ?? '',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF595D64),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto')),
                                    Divider(color: Colors.white, height: 16),
                                    Text(
                                      'Person in charge : ',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF595D64),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Divider(color: Colors.white, height: 8),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                                child: _avatar == null
                                                    ? Image.asset(
                                                        'assets/images/placeholder.png',
                                                        fit: BoxFit.cover,
                                                      )
                                                    : _avatar == ''
                                                        ? Image.asset(
                                                            'assets/images/placeholder.png',
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.network(
                                                            BASE_URL_STORAGE +
                                                                _avatar,
                                                            fit: BoxFit.cover,
                                                          )),
                                          ),
                                          SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '$_username - $_firstName $_lastName',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Divider(
                                                  color: Colors.white,
                                                  height: 4),
                                              Text(
                                                _email ?? '',
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.white, height: 16),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Brand / type : ',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                _brandOrType == 'null'
                                                    ? ''
                                                    : _brandOrType,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: Colors.white, height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Start date : ',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                _startDate ?? '',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: Colors.white, height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Useful life : ',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _usefulLife.toString() ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                            Color(0xFF595D64),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                  Text(
                                                    _usefulLife > 1
                                                        ? ' Years'
                                                        : ' Year',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                            Color(0xFF595D64),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: Colors.white, height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Acquisition value : ',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'IDR ',
                                                        decimalDigits: 0)
                                                    .format(_amount)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: Colors.white, height: 8),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Description : ',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Container(
                                                width: size.width / 2.2,
                                                child: Text(
                                                  _description == 'null'
                                                      ? ''
                                                      : _description,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xFF595D64),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: Colors.white, height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Last Opname Condition : ',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 13,
                                                    height: 13,
                                                    decoration: BoxDecoration(
                                                      color: _colorLastOpnameCondition ==
                                                              null
                                                          ? Colors.white
                                                          : Color(num.parse(
                                                              _colorLastOpnameCondition)),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    _lastOpnameCondition == null
                                                        ? ''
                                                        : _lastOpnameCondition,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                            Color(0xFF595D64),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Container(
                                                    height: 35,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            Color(0xFFDB1C23),
                                                      ),
                                                      child: Text(
                                                        'Report Opname',
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Roboto'),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ReportOpnameFormScreen()));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width: size.width,
                                height: size.height / 1.5,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/not_found.png'),
                                      Text('Asset not found',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF595D64),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto')),
                                    ],
                                  ),
                                ),
                              )
                    : Container(
                        width: size.width,
                        height: size.height / 1.5,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/no_connection.png'),
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
      ),
    );
  }
}
