import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/model/login_model.dart';
import 'package:sisca_finnet/screen/main/asset_screen.dart';
import 'package:sisca_finnet/screen/main/voucher_screen.dart';

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
  TextEditingController nikController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<bool> showPopGagal(String title, String message) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 14),
        // textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('TUTUP'),
        ),
      ],
    ),
  );
  void _postLogin() async{
    await postRequestLogin(_method,_value == 0 ? nikController.text : emailController.text, passwordController.text).then((value){
      if(value != null){
        // return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AssetScreen()),
        );
      }else {
        showPopGagal('Login Gagal', 'Username dan Password Salah');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 69),
                  Image.asset(
                    'assets/images/logo_name_color.png',
                    width: 131,
                    height: 44,
                    color: Color(0xFFD71A21),
                  ),
                  SizedBox(height: 45),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 55),
                      height: 315,
                      width: 314,
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 11),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF12A32),
                                    border: Border.all(color: Color(0xFFF12A32)),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                  ),
                                  child: Text(
                                    'SSO (NIK)',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _method = 'user_account';
                                      _value = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 11),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFF12A32)),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: Text(
                                      'USER ACCOUNT',
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
                                  onTap: (){
                                    setState(() {
                                      _method = 'nik';
                                      _value = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 11),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFF12A32)),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                    ),
                                    child: Text(
                                      'SSO (NIK)',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFF12A32),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 11),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF12A32),
                                    border: Border.all(color: Color(0xFFF12A32)),

                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  child: Text(
                                    'USER ACCOUNT',
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
                          TextFormField(
                            keyboardType: _value == 0 ? TextInputType.number : TextInputType.emailAddress,
                            controller: _value == 0 ? nikController : emailController,
                            decoration: InputDecoration(
                              labelText: _value == 0 ? _labelNik : _labelEmail,
                              hintText: '',
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                            ),
                            onTap: () {
                              setState(() {
                                _labelNik = 'Identity & Access Number (NIK)';
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
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isShowPassword,
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
                          _postLogin();
                          postRequestAsset();
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
    );
  }
}
