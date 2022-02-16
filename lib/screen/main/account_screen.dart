import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/screen/login_screen.dart';
import 'package:sisca_finnet/screen/main/asset_screen.dart';
import 'package:sisca_finnet/widget/custom_bottom_bar.dart';

import 'voucher_screen.dart';
import 'maintenance_screen.dart';

class AccountScreen extends StatefulWidget {

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

enum BottomIcons { Asset, Maintenance, Voucher, Account }


class _AccountScreenState extends State<AccountScreen> {
  BottomIcons bottomIcons = BottomIcons.Account;

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
        title: GestureDetector(
          onTap: () async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt('value', 0);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
            );
          },
          child: Text(
            'Account',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto'),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        child: Stack(
          children: [
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
