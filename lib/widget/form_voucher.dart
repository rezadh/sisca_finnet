import 'package:connectivity/connectivity.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/user_leader_model.dart';
import 'package:sisca_finnet/model/user_vp_model.dart';
import 'package:sisca_finnet/model/voucher_model.dart';
import 'package:sisca_finnet/util/const.dart';

import 'custom_dropdown_user_leader.dart';
import 'custom_dropdown_user_vp.dart';

class FormVoucher extends StatefulWidget {
  final level;

  FormVoucher({this.level});

  @override
  _FormVoucherState createState() => _FormVoucherState();
}

class _FormVoucherState extends State<FormVoucher> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  var _labelTextDescription = 'Description';
  String _description;
  String _level;
  String _idReviewer;
  String _usernameReviewer;
  String _avatarReviewer;
  String _firstnameReviewer;
  String _lastnameReviewer;
  var _levelReviewer;
  String _userPositionReviewer;
  String _idApprover;
  String _usernameApprover;
  String _avatarApprover;
  String _firstnameApprover;
  String _lastnameApprover;
  var _levelApprover;
  String _userPositionApprover;
  bool _value = false;
  bool _submitRequest = false;
  bool _visible = false;

  void _getWidget() {
    _level = widget.level;
  }

  Future getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        EasyLoading.showError('No Connection');
      });
    } else {
      setState(() {
        _postStoreVoucher();
      });
    }
  }

  void _postStoreVoucher() async {
    Map body = {
      'requested_description': _description ?? '',
      'requested_to': _idReviewer,
      'reviewed_to': _idApprover,
    };
    print(body);
    await postRequestStoreVoucher(body).then((value) {
      EasyLoading.dismiss();
      if (value.data != null) {
        EasyLoading.showSuccess('Sukses');
        Navigator.pop(context);
        setState(() {
          getRequestVoucher();
        });
        return;
      } else {
        EasyLoading.showError('Failed');
        return null;
      }
    });
  }

  @override
  void initState() {
    _getWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Voucher request form',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF595D64),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto'),
                ),
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
                  enabledBorder: OutlineInputBorder(
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
                onFieldSubmitted: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              Divider(color: Colors.white, height: 5),
              Text(
                'Additional information related to voucher request',
                style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFFBAC1CC),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
              Divider(color: Colors.white, height: 24),
              Text(
                'Voucher request approval',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF595D64),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto'),
              ),
              Divider(color: Colors.white, height: 16),
              Visibility(
                visible: _level == '1' ? false : true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownSearch<UserLeader>(
                      validator: (v) => v == null ? "Required Field" : null,
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                        ),
                        errorStyle: TextStyle(
                            fontSize: 8,
                            color: Color(0xFFF12A32),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto'),
                      ),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      onFind: (String filter) => postRequestUserLeader(),
                      onChanged: (value) {
                        setState(() {
                          _idReviewer = value.id;
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
                  ],
                ),
              ),
              Visibility(
                visible: _level == '1'
                    ? false
                    : _level == '2'
                        ? false
                        : true,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownSearch<UserVp>(
                        validator: (v) => v == null ? "Required Field" : null,
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFBAC1CC)),
                          ),
                          errorStyle: TextStyle(
                              fontSize: 8,
                              color: Color(0xFFF12A32),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto'),
                        ),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onFind: (String filter) => postRequestUserVp(),
                        onChanged: (value) {
                          setState(() {
                            _idApprover = value.id;
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
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: true,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: -25,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: CheckboxListTile(
                            title: Text(
                              'I have reviewed this voucher request',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF6E7178),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto'),
                            ),
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                                if (_value) {
                                  if (!_formKey.currentState.validate()) {
                                    _submitRequest = false;
                                    _value = false;
                                  } else if (_formKey.currentState.validate()) {
                                    _submitRequest = true;
                                    _value = true;
                                  }
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.white, height: 15),
              Visibility(
                visible: _value
                    ? _level == '1'
                        ? false
                        : true
                    : false,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This will send notification for review & approval to : ',
                        style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFF6E7178),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto'),
                      ),
                      Divider(color: Colors.white, height: 5),
                      Visibility(
                        visible: _level == '1' ? false : true,
                        child: Container(
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              child: _avatarReviewer == null
                                                  ? Image.asset(
                                                      'assets/images/placeholder.png',
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      BASE_URL_STORAGE +
                                                          _avatarReviewer,
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                    SizedBox(width: 5),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          Divider(
                                              color: Colors.white, height: 5),
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
                      ),
                      Divider(color: Colors.white, height: 10),
                      Visibility(
                        visible: _level == '3' ? true : false,
                        child: Container(
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
                                    _usernameApprover == null
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              child: _avatarApprover == null
                                                  ? Image.asset(
                                                      'assets/images/placeholder.png',
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      BASE_URL_STORAGE +
                                                          _avatarApprover,
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                    SizedBox(width: 5),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                _usernameApprover == null
                                                    ? ''
                                                    : '$_usernameApprover - ',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                _firstnameApprover == null
                                                    ? ''
                                                    : '$_firstnameApprover ',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                _lastnameApprover ?? '',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: Colors.white, height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                _levelApprover == null
                                                    ? ''
                                                    : 'Level $_levelApprover - ',
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFF595D64),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                _userPositionApprover ?? '',
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
                      ),
                      Divider(height: 33, color: Colors.white),
                    ],
                  ),
                ),
              ),
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
                        _submitRequest == false
                            ? Color(0xFF95989A)
                            : Color(0xFFF12A32)),
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
                    if (_submitRequest) {
                      if (!_formKey.currentState.validate()) {
                        setState(() {
                          _visible = true;
                        });
                      } else if (_formKey.currentState.validate()) {
                        setState(() {
                          EasyLoading.show(status: 'Loading');
                          getConnect();
                        });
                        return;
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
