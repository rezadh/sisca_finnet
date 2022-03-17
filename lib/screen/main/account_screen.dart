import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/profile_model.dart';
import 'package:sisca_finnet/screen/login_screen.dart';
import 'package:sisca_finnet/util/const.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File _profileAvatar;
  String _code;
  String _firstName;
  String _lastName;
  String _position;
  String _roles;
  String _division;
  String _directorate;
  String _avatar;
  String _splitAvatar;
  String _lastLoggedInData;
  String _lastLoggedIn;
  bool _loadingProfile = true;
  bool _loading = true;
  int _value = 0;
  var _username;
  var _labelTextFirstName = 'First name *';
  var _labelTextLastName = 'Last name *';
  var _labelTextUsername = 'Username *';
  var _labelTextEmail = 'Email *';
  var _labelTextUserIdentityNumber = 'User Identity Number *';
  var _labelTextPersonalAddress = 'Work Address / Personal Address';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController userIdentityNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController personalAddressController = TextEditingController();

  _getDataLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _roles = prefs.getString('role');
    _position = prefs.getString('position');
    _division = prefs.getString('division');
    _directorate = prefs.getString('directorate');
    _lastLoggedInData = prefs.getString('last_logged_in');
    _getLastLoggedIn(_lastLoggedInData);
    await getRequestProfile().then((value) {
      _loadingProfile = false;
      _code = value.data.code;
      _firstName = value.data.firstName;
      _lastName = value.data.lastName;
      _avatar = value.data.avatar;
      // _splitAvatar = _avatar.split('/').last;
      firstNameController.text = value.data.firstName;
      lastNameController.text = value.data.lastName;
      usernameController.text = value.data.username;
      userIdentityNumberController.text = value.data.code;
      emailController.text = value.data.email;
      personalAddressController.text = value.data.address;
    });
    // await postRequestLogin(method, username, password).then((value) {
    //   if (value != null) {
    //     setState(() {
    //       _roles = value.roles[0].name;
    //       _position = '${value.user.level} - ${value.user.userPosition.name}';
    //       _division = value.user.userPosition.userDivision.name;
    //       _directorate = value.user.userPosition.userDivision.userDirectorate.name;
    //     });
    //   }
    // });
    return _roles;
  }

  void _getLastLoggedIn(String time) {
    var dateTime = DateTime.now();
    var convertTime = DateTime.parse(time).toLocal();
    if (dateTime.difference(convertTime).inSeconds == 1) {
      _lastLoggedIn =
          '${dateTime.difference(convertTime).inSeconds} second ago';
    } else if (dateTime.difference(convertTime).inSeconds <= 60) {
      _lastLoggedIn =
          '${dateTime.difference(convertTime).inMinutes} seconds ago';
    } else if (dateTime.difference(convertTime).inMinutes == 1) {
      _lastLoggedIn =
          '${dateTime.difference(convertTime).inMinutes} minute ago';
    } else if (dateTime.difference(convertTime).inMinutes <= 60) {
      _lastLoggedIn =
          '${dateTime.difference(convertTime).inMinutes} minutes ago';
    } else if (dateTime.difference(convertTime).inHours == 1) {
      _lastLoggedIn = '${dateTime.difference(convertTime).inHours} hour ago';
    } else if (dateTime.difference(convertTime).inHours <= 24) {
      _lastLoggedIn = '${dateTime.difference(convertTime).inHours} hours ago';
    } else if (dateTime.difference(convertTime).inDays == 1) {
      _lastLoggedIn = '${dateTime.difference(convertTime).inDays} day ago';
    } else if (dateTime.difference(convertTime).inDays <= 30) {
      _lastLoggedIn = '${dateTime.difference(convertTime).inDays} days ago';
    }
  }

  void _postStoreProfile() async {
    Map body = {
      'username': usernameController.text,
      'code': _code,
      'email': emailController.text,
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'address': personalAddressController.text ?? '',
      'avatar': _profileAvatar != null ? _profileAvatar.path : _profileAvatar,
    };
    await postRequestProfile(body).then((value) {
      EasyLoading.dismiss();
      if (value.data != null) {
        EasyLoading.showSuccess('Sukses');
        return;
      } else {
        EasyLoading.showError('Failed');
        return null;
        // showPopGagal('Submit Failed', 'Something wrong');
      }
    });
  }

  Future getConnect() async {
    _loading = true;
    print(_loading);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        EasyLoading.showError('No Connection');
        print(_loading);
        _loading = false;
      });
    } else {
      setState(() {
        print(_loading);
        _loading = false;
        _postStoreProfile();
      });
    }
  }

  void _pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 2000,
      maxHeight: 2000,
    );
    if (pickedFile != null) {
      setState(() {
        _profileAvatar = File(pickedFile.path);
        _value = 1;
        prefs.setInt('value_profile', _value);
      });
    }
  }

  Future<bool> showPopUpLogout(String title, String message, int valuePopUp) =>
      showDialog(
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
                Navigator.pop(context);
              },
              child: Text('NO'),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                switch (valuePopUp) {
                  case 0:
                    prefs.setInt('value', 0);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                    break;
                  case 1:
                    Navigator.pop(context);
                    EasyLoading.show(status: 'Loading');
                    getConnect();
                    break;
                }
              },
              child: Text('YES'),
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    _getDataLogin().then((id) {
      setState(() {
        _roles = id;
      });
    });
  }

  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Account',
          style: TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Scrollbar(
              child: _loadingProfile
                  ? Container(
                      width: size.width,
                      height: size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                  : Container(
                      width: size.width,
                      height: size.height,
                      padding: EdgeInsets.only(
                          top: 80, left: 24, right: 24, bottom: 10),
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(color: Colors.white, height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 81,
                                    height: 81,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          child: Container(
                                            width: 71,
                                            height: 71,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              child: _profileAvatar != null
                                                  ? Image.file(
                                                      _profileAvatar,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : _avatar == null
                                                      ? Image.asset(
                                                          'assets/images/placeholder.png',
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.network(
                                                          BASE_URL_STORAGE +
                                                              _avatar,
                                                          fit: BoxFit.cover,
                                                        ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            right: 5,
                                            bottom: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                _pickImage();
                                              },
                                              child: Container(
                                                width: 40,
                                                padding: EdgeInsets.all(6),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: Image.asset(
                                                      'assets/images/camera.png'),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width / 1.59,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$_firstName $_lastName',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 2,
                                                    color: Color(0xFFF14722)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 8),
                                              child: Text(
                                                _roles ?? '',
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Color(0xFFF14722),
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(height: 8, color: Colors.white),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Position',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            Text(
                                              'Level $_position',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ],
                                        ),
                                        Divider(height: 2, color: Colors.white),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Division',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            Text(
                                              _division ?? '',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ],
                                        ),
                                        Divider(height: 2, color: Colors.white),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Directorate',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            Text(
                                              _directorate ?? '',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ],
                                        ),
                                        Divider(height: 2, color: Colors.white),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Last Logged in',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            Text(
                                              _lastLoggedIn.toString(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF595D64),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.white, height: 30),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: size.width / 2.5,
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: firstNameController,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF595D64),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto'),
                                        decoration: InputDecoration(
                                            labelText: _labelTextFirstName,
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
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFF12A32)),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFFFFFFF),
                                            errorStyle: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFF12A32),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto')),
                                        onChanged: (value) async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          _value = 1;
                                          prefs.setInt('value_profile', _value);
                                        },
                                        onTap: () {
                                          setState(() {
                                            _labelTextFirstName =
                                                'First name *';
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: size.width / 2.5,
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: lastNameController,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF595D64),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto'),
                                        decoration: InputDecoration(
                                            labelText: _labelTextLastName,
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
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFF12A32)),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFFFFFFF),
                                            errorStyle: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFF12A32),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto')),
                                        onChanged: (value) async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          _value = 1;
                                          prefs.setInt('value_profile', _value);
                                        },
                                        onTap: () {
                                          setState(() {
                                            _labelTextLastName = 'Last name *';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: Colors.white),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: usernameController,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFBAC1CC),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto'),
                                  decoration: InputDecoration(
                                      labelText: _labelTextUsername,
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
                                            color: Colors.white, width: 5.0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFF12A32)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      errorStyle: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFF12A32),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto')),
                                  onTap: () {
                                    setState(() {
                                      _labelTextUsername = 'Username *';
                                    });
                                  },
                                ),
                              ),
                              Divider(color: Colors.white, height: 5),
                              Text(
                                'Username related to SSO account',
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFBAC1CC),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto'),
                              ),
                              Divider(color: Colors.white),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: userIdentityNumberController,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFBAC1CC),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto'),
                                  decoration: InputDecoration(
                                      labelText: _labelTextUserIdentityNumber,
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
                                            color: Colors.white, width: 5.0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFF12A32)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      errorStyle: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFF12A32),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto')),
                                  onTap: () {
                                    setState(() {
                                      _labelTextUserIdentityNumber =
                                          'User Identity number *';
                                    });
                                  },
                                ),
                              ),
                              Divider(color: Colors.white, height: 5),
                              Text(
                                'Unique user identity number',
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFBAC1CC),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto'),
                              ),
                              Divider(color: Colors.white),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF595D64),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto'),
                                  decoration: InputDecoration(
                                      labelText: _labelTextEmail,
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
                                            color: Colors.white, width: 5.0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFF12A32)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      errorStyle: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFF12A32),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto')),
                                  onChanged: (value) async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    _value = 1;
                                    prefs.setInt('value_profile', _value);
                                  },
                                  onTap: () {
                                    setState(() {
                                      _labelTextEmail = 'Email *';
                                    });
                                  },
                                ),
                              ),
                              Divider(color: Colors.white, height: 5),
                              Text(
                                'Work email. Notification and information would send to this email',
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFBAC1CC),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto'),
                              ),
                              Divider(color: Colors.white),
                              Container(
                                height: 82,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: personalAddressController,
                                  maxLines: 5,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF595D64),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto'),
                                  decoration: InputDecoration(
                                      labelText: _labelTextPersonalAddress,
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
                                            color: Colors.white, width: 5.0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFF12A32)),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      errorStyle: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFF12A32),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto')),
                                  onChanged: (value) async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    _value = 1;
                                    prefs.setInt('value_profile', _value);
                                  },
                                  onTap: () {
                                    setState(() {
                                      _labelTextPersonalAddress =
                                          'Work address / Personal address';
                                    });
                                  },
                                ),
                              ),
                              Divider(color: Colors.white, height: 5),
                              Text(
                                'Additional information related to user located',
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFBAC1CC),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto'),
                              ),
                              Divider(color: Colors.white),
                              Container(
                                height: 44,
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFF12A32)),
                                  ),
                                  child: Text(
                                    'Save changes',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Roboto'),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _loading = true;
                                      if (_value == 1) {
                                        showPopUpLogout(
                                            'Save Change',
                                            'Are you sure want to save change?',
                                            1);
                                      }
                                      // getConnect();
                                    });
                                  },
                                ),
                              ),
                              Divider(color: Colors.white),
                              Container(
                                height: 44,
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  // style: ButtonStyle(
                                  //   shape: MaterialStateProperty.all(
                                  //     RoundedRectangleBorder(
                                  //         borderRadius:
                                  //             BorderRadius.circular(8.0)),
                                  //   ),
                                  //   backgroundColor: MaterialStateProperty.all(
                                  //       Colors.white),
                                  // ),
                                  child: Text(
                                    'Log out',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFF12A32),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Roboto'),
                                  ),
                                  onPressed: () {
                                    showPopUpLogout('LOGOUT',
                                        'Are you sure want to logout ?', 0);
                                  },
                                ),
                              ),
                            ],
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
