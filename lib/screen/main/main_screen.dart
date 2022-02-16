import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sisca_finnet/screen/main/account_screen.dart';
import 'package:sisca_finnet/screen/main/asset_screen.dart';
import 'package:sisca_finnet/screen/main/maintenance_screen.dart';
import 'package:sisca_finnet/screen/main/voucher_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final tabs = [
    AssetScreen(),
    MaintenanceScreen(),
    VoucherScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FaIcon(FontAwesomeIcons.box)),
              label: 'Asset'),
          BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FaIcon(FontAwesomeIcons.tools)),
              label: 'Maintenance'),
          BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FaIcon(FontAwesomeIcons.ticketAlt)),
              label: 'Voucher'),
          BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FaIcon(FontAwesomeIcons.userAlt)),
              label: 'Account'),
        ],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: 15,
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(color: Color(0xFFF12A32), size: 15),
        selectedItemColor: Color(0xFFF12A32),
        unselectedItemColor: Color(0xFF9AA1AC),
        showUnselectedLabels: true,
        unselectedFontSize: 8,
        selectedFontSize: 8,
        onTap: onTapped,
      ),
    );
  }
}
