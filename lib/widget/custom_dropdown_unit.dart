import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/model/maintenance_model.dart';

Widget customDropDownUnit(BuildContext context, Monitoring item) {
  if (item == null) {
    return Container();
  }

  return Container(
      child: (item.name == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(),
              title: Text("No item selected"),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.name ?? '',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF595D64),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
                SizedBox(height: 5),
                Text(
                  item?.serialNumber.toString() ?? '',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF595D64),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Roboto'),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Current budget : ',
                      style: TextStyle(
                          fontSize: 8,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                    SizedBox(height: 5),
                    Text(
                      NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'IDR ',
                                  decimalDigits: 0)
                              .format(item?.currentBudget)
                              .toString() ??
                          '',
                      style: TextStyle(
                          fontSize: 8,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                    color: Color(0xFFE0E0E0),
                    height: 1,
                    width: MediaQuery.of(context).size.width),
              ],
            )
      // ListTile(
      //   contentPadding: EdgeInsets.all(0),
      //   leading: CircleAvatar(
      //     // this does not work - throws 404 error
      //     // backgroundImage: NetworkImage(item.avatar ?? ''),
      //   ),
      //   title: Text(item.name),
      //   subtitle: Text(
      //     item.createdAt.toString(),
      //   ),
      // ),
      );
}

Widget customPopupItemBuilderUnit(
    BuildContext context, Monitoring item, bool isSelected) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item?.name ?? '',
            style: TextStyle(
                fontSize: 10,
                color: Color(0xFF595D64),
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto'),
          ),
          SizedBox(height: 5),
          Text(
            item?.serialNumber.toString() ?? '',
            style: TextStyle(
                fontSize: 10,
                color: Color(0xFF595D64),
                fontWeight: FontWeight.w300,
                fontFamily: 'Roboto'),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Current budget : ',
                style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF595D64),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 5),
              Text(
                NumberFormat.currency(
                            locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                        .format(item?.currentBudget)
                        .toString() ??
                    '',
                style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF595D64),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
              color: Color(0xFFE0E0E0),
              height: 1,
              width: MediaQuery.of(context).size.width),
        ],
      )
      // ListTile(
      //   selected: isSelected,
      //   title: Text(item?.name ?? ''),
      //   subtitle: Text(item?.createdAt?.toString() ?? ''),
      //   leading: CircleAvatar(
      //     // this does not work - throws 404 error
      //     // backgroundImage: NetworkImage(item.avatar ?? ''),
      //   ),
      // ),
      );
}
RenderBox findBorderBox(RenderBox box) {
  RenderBox borderBox;

  box.visitChildren((child) {
    if (child is RenderCustomPaint) {
      borderBox = child;
    }

    final box = findBorderBox(child as RenderBox);
    if (box != null) {
      borderBox = box;
    }
  });

  return borderBox;
}