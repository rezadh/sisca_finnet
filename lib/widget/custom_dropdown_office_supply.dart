import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sisca_finnet/model/office_supply_model.dart';

Widget customDropDownOfficeSupply(BuildContext context, OfficeSupplyAsset item) {
  if (item == null) {
    return Container();
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(top: 8),
    child: (item.name == null)
        ? ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text("No item selected"),
    )
        : Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 5),
          Flexible(
            child: Container(
              // width: MediaQuery.of(context).size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? '',
                    style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF595D64),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.code ?? '',
                    style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFF595D64),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customPopupItemBuilderOfficeSupply(
    BuildContext context, OfficeSupplyAsset item, bool isSelected) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
      border: Border.all(color: Color(0xFFDDDDDD)),
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
    ),
    child: Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 5),
          Container(
            // width: MediaQuery.of(context).size.width / 2.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? '',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF595D64),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      item.code ?? '',
                      style: TextStyle(
                          fontSize: 8,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

RenderBox findBorderBoxUserLeader(RenderBox box) {
  RenderBox borderBox;

  box.visitChildren((child) {
    if (child is RenderCustomPaint) {
      borderBox = child;
    }

    final box = findBorderBoxUserLeader(child as RenderBox);
    if (box != null) {
      borderBox = box;
    }
  });

  return borderBox;
}
