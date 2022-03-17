import 'package:connectivity/connectivity.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/model/maintenance_model.dart';
import 'package:sisca_finnet/model/user_leader_model.dart';
import 'package:sisca_finnet/model/user_vp_model.dart';
import 'package:sisca_finnet/util/const.dart';
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
  String _filePath;
  String _file;
  String _idMonitoring;
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
  String _description;
  int _currentBudget = 0;
  int _requestAmount = 0;
  var _temp;
  final _formKey = GlobalKey<FormState>();
  final _formKeyAmount = GlobalKey<FormState>();
  bool _value = false;
  bool _visible = false;
  bool _submitRequest = false;

  void pickImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        final file = result.files.first;
        _file = file.name;
        _filePath = file.path;
        if (!_formKey.currentState.validate() ||
            !_formKeyAmount.currentState.validate() ||
            _file != null) {
          _submitRequest = false;
        } else if (_formKeyAmount.currentState.validate() ||
            _formKey.currentState.validate() ||
            _file != null) {
          _submitRequest = true;
        }
      });
    }

    // setState(() {
    //
    //   filePath = result.files.single.path.split('/').last;
    //   save().whenComplete(() => _file = filePath);
    // });
  }

  Future<bool> save() async {
    return true;
  }

  Future<bool> showPopGagal(String title, String message) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 14),
            // textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('TUTUP'),
            ),
          ],
        ),
      );

  Future getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        EasyLoading.showError('No Connection');
      });
    } else {
      setState(() {
        _postStoreMaintenance();
      });
    }
  }

  void _postStoreMaintenance() async {
    Map body = {
      'monitoring_id': _idMonitoring,
      'requested_amount': _temp,
      'requested_description': _description ?? '',
      'maintenance_option': 'logistic_support',
      'requested_to': _idReviewer,
      'reviewed_to': _idApprover,
      'requested_evidence': _filePath,
    };
    print(body);
    await postStoreMaintenance(body).then((value) {
      EasyLoading.dismiss();
      print(value.status);
      if (value.data != null) {
        EasyLoading.showSuccess('Sukses');
        Navigator.pop(context);
        setState(() {
          postRequestMaintenance();
        });
        return;
      } else {
        EasyLoading.showError('Failed');
        return null;
        // showPopGagal('Submit Failed', 'Something wrong');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Container(
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
                validator: (v) => v == null ? "Required Field" : null,
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
                onFind: (String filter) => postRequestAssetMonitoring(),
                onChanged: (value) {
                  setState(() {
                    _idMonitoring = value.id;
                    _currentBudget = value.currentBudget;
                    if (!_formKey.currentState.validate() ||
                        !_formKeyAmount.currentState.validate() ||
                        _file == null) {
                      _visible = true;
                      _submitRequest = false;
                    } else if (_formKeyAmount.currentState.validate() ||
                        _formKey.currentState.validate() ||
                        _file != null) {
                      _submitRequest = true;
                    }
                    print(_currentBudget);
                  });
                },
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
              Form(
                key: _formKeyAmount,
                child: TextFormField(
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'id', decimalDigits: 0, symbol: 'IDR '),
                  ],
                  enabled: _currentBudget == 0 ? false : true,
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
                      if (value.isEmpty) {
                        amountController.text = '0';
                      }
                      final temp = amountController.text
                          .replaceAll('IDR ', '')
                          .replaceAll('.', '');
                      _requestAmount = int.parse(temp);
                      _temp = temp;
                      if (!_formKeyAmount.currentState.validate() ||
                          !_formKey.currentState.validate() ||
                          _file == null) {
                        _visible = true;
                        _submitRequest = false;
                      } else if (_formKeyAmount.currentState.validate() ||
                          _formKey.currentState.validate() ||
                          _file != null) {
                        _submitRequest = true;
                      }
                      print(_requestAmount);
                    });
                  },

                  decoration: InputDecoration(
                      labelText: _labelTextAmount,
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
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF12A32)),
                      ),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      errorStyle: TextStyle(
                          fontSize: 8,
                          color: Color(0xFFF12A32),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto')),
                  onTap: () {
                    setState(() {
                      _labelTextAmount = 'Request Amount *';
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      value = '0';
                      return 'Required Field';
                    }
                    final temp =
                        value.replaceAll('IDR ', '').replaceAll('.', '');
                    if (int.parse(temp) > _currentBudget) {
                      return 'The Request Amount field must be $_currentBudget or less';
                    }
                    return null;
                  },
                  // onChanged: (text) => setState(() => _formKeyAmount.currentState.validate()),
                ),
              ),
              SizedBox(height: 5),
              Visibility(
                visible: _requestAmount > _currentBudget ? false : true,
                child: Text(
                  'Cost due to maintenance (Current budget: ${NumberFormat.currency(locale: 'id', symbol: 'IDR ', decimalDigits: 0).format(_currentBudget)})',
                  style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFFBAC1CC),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            child: Image.asset('assets/images/attachment.png',
                                width: 14),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          _file ?? '',
                          style: TextStyle(
                              fontSize: 8,
                              color: Color(0xFF595D64),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white, height: 5),
                    Visibility(
                      visible: _visible
                          ? _file == null
                              ? true
                              : false
                          : false,
                      child: Text(
                        'Required Field',
                        style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFFF12A32),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                  ],
                ),
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
              Visibility(
                visible: _usernameReviewer == null ? false : true,
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
                visible: _usernameApprover == null ? false : true,
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
                              'I have reviewed this maintenance request',
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
                                  if (!_formKeyAmount.currentState.validate() ||
                                      !_formKey.currentState.validate() ||
                                      _file == null) {
                                    _submitRequest = false;
                                  } else if (_formKeyAmount.currentState
                                          .validate() ||
                                      _formKey.currentState.validate() ||
                                      _file != null) {
                                    _submitRequest = true;
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
                visible: _value == true ? true : false,
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
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
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
                                  _usernameApprover == null
                                      ? Container()
                                      : Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
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
                                        Divider(color: Colors.white, height: 5),
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
                    ],
                  ),
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
                      if (!_formKeyAmount.currentState.validate() ||
                          !_formKey.currentState.validate() ||
                          _file == null) {
                        setState(() {
                          _visible = true;
                          print(_visible);
                        });
                      } else if (_formKeyAmount.currentState.validate() ||
                          _formKey.currentState.validate() ||
                          _file != null) {
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
