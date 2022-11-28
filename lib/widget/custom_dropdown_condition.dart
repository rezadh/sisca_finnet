import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/model/opname_model.dart';

Widget customDropDownUnitCondition(BuildContext context, Condition item) {
  if (item == null) {
    return Container();
  }
  String _colorLastOpnameCondition;
  var parts = item?.color?.split('#');
  _colorLastOpnameCondition = '0xFF${parts[1].trim()}';
  return Container(
      padding: EdgeInsets.only(top: 10),
      child: (item.name == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(),
              title: Text("No item selected"),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: item?.color == null
                        ? Colors.white
                        : Color(num.parse(_colorLastOpnameCondition)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  item?.name ?? '',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF595D64),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
                SizedBox(height: 8),
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

Widget customPopupItemBuilderUnitCondition(
    BuildContext context, Condition item, bool isSelected) {
  String _colorLastOpnameCondition;
  var parts = item?.color?.split('#');
  _colorLastOpnameCondition = '0xFF${parts[1].trim()}';
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 13,
            height: 13,
            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            decoration: BoxDecoration(
              color: item?.color == null
                  ? Colors.white
                  : Color(num.parse(_colorLastOpnameCondition)),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Text(
              item?.name ?? '',
              style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF595D64),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
          ),
          SizedBox(height: 8),
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
