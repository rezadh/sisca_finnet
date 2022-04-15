import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/login_model.dart';
import 'package:sisca_finnet/screen/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _nik;
  String _email;
  String _method;
  int _value = 0;
  final _formKey = GlobalKey<FormState>();
  var _labelNik = 'Identity & Access Number (NIK)';
  var _labelEmail = 'Email';
  var _labelPassword = 'Password';
  bool _isShowPassword = true;
  bool _loading = false;
  TextEditingController nikController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isInternetOn = true;

  Future<bool> showPopGagal(String title, String message) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 19),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 15),
            // textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _loading = false;
                Navigator.pop(context);
              },
              child: Text('TUTUP'),
            ),
          ],
        ),
      );

  Future<bool> showPopNoConnection() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 26),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Something was wrong',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF595D64),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto'),
                  ),
                  Image.asset('assets/images/no_connection.png'),
                  Text(
                    'No Internet Connection',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF595D64),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto'),
                  ),
                  Divider(height: 16, color: Colors.white),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFF12A32)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFF12A32),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // TextButton(
            //   onPressed: () {
            //     _loading = false;
            //     Navigator.pop(context);
            //   },
            //   child: Text('TUTUP'),
            // ),
          ],
        ),
      );

  void _postLogin() async {
    // EasyLoading.dismiss();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loading = false;
    await postRequestLogin(
            _method,
            _value == 0 ? nikController.text : emailController.text,
            passwordController.text)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        if (value.accessToken != null) {
          prefs.setInt('value', 1);
          prefs.setString('role', value.roles[0].name);
          prefs.setString('last_logged_in', value.user.lastLoggedIn);
          prefs.setString('position', value.user.userPosition.name);
          prefs.setString(
              'division', value.user.userPosition.userDivision.name);
          prefs.setString('directorate',
              value.user.userPosition.userDivision.userDirectorate.name);
          prefs.setString('level', value.user.level);
          // prefs.setString('method', _method);
          // prefs.setString('username', _value == 0 ? nikController.text : emailController.text);
          // prefs.setString('password', passwordController.text);
          var roles = value.roles[0].isAssetHolder;
          if (roles == 1) {
            return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
            );
          } else {
            showPopGagal(
                'Login Failed', 'your role is not eligible to use this app');
          }
        } else {
          showPopGagal(
              'Login Failed', 'Something wrong, please try again later');
        }
      } else {
        showPopGagal('Login Failed', 'email or password is wrong');
      }
    });
  }

  Future getConnect() async {
    _loading = true;
    print(_loading);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        EasyLoading.dismiss();
        showPopNoConnection();
        // EasyLoading.showError('No Connection');
        print(_loading);
        _loading = false;
        isInternetOn = false;
      });
    } else {
      setState(() {
        print(_loading);
        isInternetOn = true;
        _loading = false;
        _postLogin();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      // if (status == EasyLoadingStatus.dismiss) {
      //   _timer.cancel();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = orientation == Orientation.landscape;

    return AbsorbPointer(
      absorbing: _loading ? true : false,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              height: size.height,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 69),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 111,
                        height: 65,
                      ),
                      SizedBox(height: 35),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 1,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 55),
                          height: isLandscape ? size.height / 1.3 : size.height / 2,
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25),
                              Text(
                                'Welcome',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFF595D64),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto'),
                              ),
                              SizedBox(height: 15),
                              Visibility(
                                visible: _value == 0 ? true : false,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width / 2.7,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 11),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF12A32),
                                        border: Border.all(
                                            color: Color(0xFFF12A32)),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)),
                                      ),
                                      child: Text(
                                        'SSO (NIK)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _method = 'user_account';
                                          _value = 1;
                                        });
                                      },
                                      child: Container(
                                        width: size.width / 2.7,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 11),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xFFF12A32)),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                        ),
                                        child: Text(
                                          'USER ACCOUNT',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFF12A32),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _value == 1 ? true : false,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _method = 'nik';
                                          _value = 0;
                                        });
                                      },
                                      child: Container(
                                        width: size.width / 2.7,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 11),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xFFF12A32)),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                        ),
                                        child: Text(
                                          'SSO (NIK)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFF12A32),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: size.width / 2.7,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 11),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF12A32),
                                        border: Border.all(
                                            color: Color(0xFFF12A32)),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                      ),
                                      child: Text(
                                        'USER ACCOUNT',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 33),
                              Visibility(
                                visible: _value == 0 ? true : false,
                                child: TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  controller: nikController,
                                  decoration: InputDecoration(
                                    labelText: _labelNik,
                                    hintText: '',
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _labelNik =
                                          'Identity & Access Number (NIK)';
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _nik = nikController.text;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Visibility(
                                visible: _value == 1 ? true : false,
                                child: TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: _labelEmail,
                                    hintText: '',
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _labelEmail = 'Email';
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _nik = nikController.text;
                                      _email = emailController.text;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: _isShowPassword,
                                // autofocus: false,
                                // autofocus: _value == 0 ? false : false,
                                // focusNode: focusNode,
                                decoration: InputDecoration(
                                  labelText: _labelPassword,
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                      _isShowPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xFFBDBDBD),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _isShowPassword = !_isShowPassword;
                                      });
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                ),
                                onTap: () {
                                  setState(() {
                                    _labelPassword = 'Password';
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 45),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 23),
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFF12A32)),
                          ),
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto'),
                          ),
                          onPressed: () {
                            setState(() {
                              EasyLoading.show(status: 'Loading');
                              _loading = true;
                              getConnect();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 21),
                      Text(
                        'Asset Management System - PT Finnet Indonesia',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF595D64),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto'),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Powered by',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto'),
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            'assets/images/logo_name_color.png',
                            width: 53,
                            height: 18,
                            color: Color(0xFFD71A21),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
