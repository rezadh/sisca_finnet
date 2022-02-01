import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  VoidCallback onPressed;
  bool bottomIcons;
  String text;
  String icons;

  CustomBottomBar({this.onPressed, this.bottomIcons, this.text, this.icons});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: widget.bottomIcons == true
          ? Container(
              // decoration: BoxDecoration(
              //   color: Color(0xFFFFFFFF).withOpacity(0.6),
              //   borderRadius: BorderRadius.circular(30),
              // ),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 11, bottom: 11),
              child: Column(
                children: [
                  Image.asset(
                    widget.icons,
                    width: 20,
                    height: 20,
                    color: Color(0xFFF12A32),
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Roboto',
                        color: Color(0xFFF12A32)),
                  ),
                ],
              ),
            )
          : Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 11, bottom: 11),
              child: Column(
                children: [
                  Image.asset(
                    widget.icons,
                    color: Color(0xFF9AA1AC),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Roboto',
                        color: Color(0xFF9AA1AC)),
                  ),
                ],
              ),
            ),
    );
  }
}
