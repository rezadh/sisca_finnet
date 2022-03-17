import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sisca_finnet/model/user_leader_model.dart';
import 'package:sisca_finnet/util/const.dart';

Widget customDropDownUserLeader(BuildContext context, UserLeader item) {
  if (item == null) {
    return Container();
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(top: 8),
    child: (item.firstName == null)
        ? ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(),
            title: Text("No item selected"),
          )
        : Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 45,
                  width: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    child: item.avatar == null
                        ? Image.asset(
                            'assets/images/placeholder.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            BASE_URL_STORAGE + item.avatar,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  // width: MediaQuery.of(context).size.width / 2.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${item.username} - ' ?? '',
                            style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                          Text(
                            '${item.firstName} ' ?? '',
                            style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                          Text(
                            item?.lastName.toString() ?? '',
                            style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Level ${item.level} - ' ?? '',
                            style: TextStyle(
                                fontSize: 8,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                          Text(
                            item.userPosition.name,
                            style: TextStyle(
                                fontSize: 8,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto'),
                          ),
                          SizedBox(height: 5),
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

Widget customPopupItemBuilderUserLeader(
    BuildContext context, UserLeader item, bool isSelected) {
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
          Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Color(0xFFDDDDDD),
                border: Border.all(color: Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                child: item.avatar == null
                    ? Image.asset(
                        'assets/images/placeholder.png',
                        width: 25,
                        height: 25,
                      )
                    : Image.network(
                        BASE_URL_STORAGE + item.avatar,
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
              )),
          SizedBox(width: 5),
          Container(
            // width: MediaQuery.of(context).size.width / 2.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${item.username} - ' ?? '',
                      style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      '${item.firstName} ' ?? '',
                      style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      item?.lastName.toString() ?? '',
                      style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Level ${item.level} - ' ?? '',
                      style: TextStyle(
                          fontSize: 8,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      item.userPosition.name,
                      style: TextStyle(
                          fontSize: 8,
                          color: Color(0xFF595D64),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                    SizedBox(height: 5),
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
