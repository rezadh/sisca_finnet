import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/model/user_leader_model.dart';
import 'package:sisca_finnet/model/user_vp_model.dart';
import 'package:sisca_finnet/widget/custom_dropdown_unit.dart';
import 'package:sisca_finnet/widget/custom_dropdown_user_leader.dart';
import 'package:sisca_finnet/widget/custom_dropdown_user_vp.dart';

class FormMaintenance extends StatefulWidget {
  @override
  _FormMaintenanceState createState() => _FormMaintenanceState();
}

class _FormMaintenanceState extends State<FormMaintenance> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maintenanceOptionController =
      TextEditingController(text: 'Logistic support\nBantuan logistik');
  var _labelTextAmount = 'Request Amount *';
  var _labelTextMaintenanceOption = 'Maintenance options *';
  var _labelTextDescription = 'Description';
  String filePath;
  String _file;
  String _usernameReviewer;
  String _avatarReviewer;
  String _firstnameReviewer;
  String _lastnameReviewer;
  String _levelReviewer;
  String _userPositionReviewer;
  String _usernameApprover;
  String _avatarApprover;
  String _firstnameApprover;
  String _lastnameApprover;
  String _levelApprover;
  String _userPositionApprover;
  bool _value = false;

  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      filePath = image.path.split('/').last;
      save().whenComplete(() => _file = filePath);
    });
  }

  Future<bool> save() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Maintenance request form',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF595D64),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white),
            DropdownSearch<Monitoring>(
              validator: (v) => v == null ? "required field" : null,
              showSelectedItems: true,
              mode: Mode.MENU,
              compareFn: (i, s) => i?.isEqual(s) ?? false,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Unit / Device *",
                hintText: "Unit / Device *",
                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
              ),
              onFind: (String filter) => postRequestAssetMonitoring(),
              onChanged: print,
              dropdownBuilder: customDropDownUnit,
              popupItemBuilder: customPopupItemBuilderUnit,
            ),
            SizedBox(height: 5),
            Text(
              'Click to choose Unit / Device to be requested for maintenance',
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFFBAC1CC),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white),
            TextFormField(
              style: TextStyle(fontSize: 10),
              keyboardType: TextInputType.number,
              controller: amountController,
              onFieldSubmitted: (value) {
                setState(() {
                  // final temp = amountController.text
                  //     .replaceAll('Rp', '')
                  //     .replaceAll('.', '');
                  // uangDibayar = int.parse(temp);
                  // _kembalian = uangDibayar - tarif;
                  // final test = NumberFormat.currency(
                  //     locale: 'id', decimalDigits: 0)
                  //     .format(_kembalian);
                  // print(test);
                  // kembalianController.text =
                  //     NumberFormat.currency(
                  //         locale: 'id',
                  //         decimalDigits: 0,
                  //         symbol: 'Rp')
                  //         .format(_kembalian);
                  print(amountController.text);
                });
              },
              decoration: InputDecoration(
                labelText: _labelTextAmount,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
              ),
              onTap: () {
                setState(() {
                  _labelTextAmount = 'Request Amount *';
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            Text(
              'Cost due to maintenance (Current budget: IDR 0',
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFFBAC1CC),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white),
            TextFormField(
              maxLines: 2,
              enabled: false,
              keyboardType: TextInputType.number,
              controller: maintenanceOptionController,
              style: TextStyle(fontSize: 10),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                labelText: _labelTextMaintenanceOption,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
              ),
              onTap: () {
                setState(() {
                  _labelTextAmount = 'Request Amount *';
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            Divider(color: Colors.white),
            TextFormField(
              maxLines: 4,
              keyboardType: TextInputType.text,
              controller: descriptionController,
              // style: TextStyle(fontSize: 10),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                labelText: _labelTextDescription,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 5.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
              ),
              onTap: () {
                setState(() {
                  _labelTextDescription = 'Description';
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            Divider(color: Colors.white, height: 5),
            Text(
              'Additional information related to maintenance report',
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFFBAC1CC),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white, height: 15),
            Text(
              'Report evidence *',
              style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF6E7178),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pickImage();
                    });
                    // File file = await takePicture();
                    // filePath = await getFileName(_image);
                    // save().whenComplete(() => _file = filePath);
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFEE2830),
                    child:
                        Image.asset('assets/images/attachment.png', width: 14),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  _file ?? 'file',
                  style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFF595D64),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
            Divider(),
            Text(
              'Attachment supporting maintenance request information',
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFFBAC1CC),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white, height: 32),
            Text(
              'Maintenance request approval',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF595D64),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white, height: 16),
            DropdownSearch<UserLeader>(
              validator: (v) => v == null ? "required field" : null,
              showSelectedItems: true,
              mode: Mode.MENU,
              compareFn: (i, s) => i?.isEqual(s) ?? false,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Request review to *",
                hintText: "Request review to *",
                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
              ),
              onFind: (String filter) => postRequestUserLeader(),
              onChanged: (value) {
                setState(() {
                  _avatarReviewer = value.avatar;
                  _usernameReviewer = value.username;
                  _firstnameReviewer = value.firstName;
                  _lastnameReviewer = value.lastName;
                  _levelReviewer = value.level;
                  _userPositionReviewer = value.userPosition.name;
                });
              },
              dropdownBuilder: customDropDownUserLeader,
              popupItemBuilder: customPopupItemBuilderUserLeader,
            ),
            Divider(color: Colors.white, height: 5),
            Text(
              'Choose to whom request to be reviewed',
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFFBAC1CC),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white),
            DropdownSearch<UserVp>(
              validator: (v) => v == null ? "required field" : null,
              showSelectedItems: true,
              mode: Mode.MENU,
              compareFn: (i, s) => i?.isEqual(s) ?? false,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Request approval to *",
                hintText: "Request approval to *",
                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                ),
              ),
              onFind: (String filter) => postRequestUserVp(),
              onChanged: (value) {
                setState(() {
                  _avatarApprover = value.avatar;
                  _usernameApprover = value.username;
                  _firstnameApprover = value.firstName;
                  _lastnameApprover = value.lastName;
                  _levelApprover = value.level;
                  _userPositionApprover = value.userPosition.name;
                });
              },
              dropdownBuilder: customDropDownUserVp,
              popupItemBuilder: customPopupItemBuilderUserVp,
            ),
            Divider(color: Colors.white, height: 5),
            Text(
              'Choose to whom request to be approved',
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFFBAC1CC),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white, height: 15),
            Row(
              children: [
                Container(
                  width: 20,
                  child: Checkbox(
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'I have reviewed this maintenance request',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF6E7178),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
            Divider(color: Colors.white, height: 15),
            Text(
              'This will send notification for review & approval to : ',
              style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF6E7178),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'),
            ),
            Divider(color: Colors.white, height: 5),
            Container(
              child: Row(
                children: [
                  Text(
                    'Reviewer : ',
                    style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFF6E7178),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _usernameReviewer == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width / 12,
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFFDDDDDD),
                                    child: _avatarReviewer == null
                                        ? Image.asset(
                                            'assets/images/placeholder.png',
                                            width: 20)
                                        : Image.network(_avatarReviewer)),
                              ),
                        SizedBox(width: 5),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _usernameReviewer == null
                                        ? ''
                                        : '$_usernameReviewer - ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                  Text(
                                    _firstnameReviewer == null
                                        ? ''
                                        : '$_firstnameReviewer ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                  Text(
                                    _lastnameReviewer ?? '',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.white, height: 5),
                              Row(
                                children: [
                                  Text(
                                    _levelReviewer == null
                                        ? ''
                                        : 'Level $_levelReviewer - ',
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                  Text(
                                    _userPositionReviewer ?? '',
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white, height: 10),
            Container(
              child: Row(
                children: [
                  Text(
                    'Approver : ',
                    style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFF6E7178),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _usernameReviewer == null
                            ? Container()
                            : Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: MediaQuery.of(context).size.width / 12,
                          child: CircleAvatar(
                              backgroundColor: Color(0xFFDDDDDD),
                              child: _avatarReviewer == null
                                  ? Image.asset(
                                  'assets/images/placeholder.png',
                                  width: 20)
                                  : Image.network(_avatarReviewer)),
                        ),
                        SizedBox(width: 5),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _usernameReviewer == null
                                        ? ''
                                        : '$_usernameReviewer - ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                  Text(
                                    _firstnameReviewer == null
                                        ? ''
                                        : '$_firstnameReviewer ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                  Text(
                                    _lastnameReviewer ?? '',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.white, height: 5),
                              Row(
                                children: [
                                  Text(
                                    _levelReviewer == null
                                        ? ''
                                        : 'Level $_levelReviewer - ',
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                  ),
                                  Text(
                                    _userPositionReviewer ?? '',
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF595D64),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white, height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 44,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      _value == false ? Color(0xFF95989A) : Color(0xFFF12A32)),
                ),
                child: Text(
                  'Submit request',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto'),
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
