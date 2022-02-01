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
            Positioned(
              bottom: -5,
              left: -5,
              child: Card(
                elevation: 1,
                child: Container(
                  width: size.width,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBottomBar(
                          onPressed: () {
                            setState(() {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AssetScreen()),
                                (route) => false,
                              );
                              bottomIcons = BottomIcons.Asset;
                            });
                          },
                          bottomIcons:
                              bottomIcons == BottomIcons.Asset ? true : false,
                          text: 'Asset',
                          icons: 'assets/images/box.png'),
                      CustomBottomBar(
                          onPressed: () {
                            setState(() {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MaintenanceScreen()),
                                (route) => false,
                              );
                              bottomIcons = BottomIcons.Maintenance;
                            });
                          },
                          bottomIcons: bottomIcons == BottomIcons.Maintenance
                              ? true
                              : false,
                          text: 'Maintenance',
                          icons: 'assets/images/tools.png'),
                      CustomBottomBar(
                          onPressed: () {
                            setState(() {
                              bottomIcons = BottomIcons.Voucher;
                            });
                          },
                          bottomIcons:
                          bottomIcons == BottomIcons.Voucher ? true : false,
                          text: 'Voucher',
                          icons: 'assets/images/voucher.png'),
                      CustomBottomBar(
                          onPressed: () {
                            setState(() {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountScreen()),
                                (route) => false,
                              );
                              bottomIcons = BottomIcons.Account;
                            });
                          },
                          bottomIcons:
                              bottomIcons == BottomIcons.Account ? true : false,
                          text: 'Account',
                          icons: 'assets/images/user.png'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
