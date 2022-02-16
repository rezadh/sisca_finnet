import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sisca_finnet/screen/main/account_screen.dart';
import 'package:sisca_finnet/screen/main/asset_screen.dart';
import 'package:sisca_finnet/screen/main/maintenance_screen.dart';
import 'package:sisca_finnet/widget/custom_bottom_bar.dart';

class VoucherScreen extends StatefulWidget {
  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

enum BottomIcons { Asset, Maintenance, Voucher, Account }

class _VoucherScreenState extends State<VoucherScreen> {
  BottomIcons bottomIcons = BottomIcons.Voucher;

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
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
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
