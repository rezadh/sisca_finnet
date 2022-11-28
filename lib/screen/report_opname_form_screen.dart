import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sisca_finnet/model/asset_model.dart';
import 'package:sisca_finnet/model/opname_model.dart';
import 'package:sisca_finnet/screen/main/asset_screen.dart';
import 'package:sisca_finnet/widget/custom_dropdown_condition.dart';
import 'package:sisca_finnet/widget/custom_dropdown_unit_report_opname.dart';

class ReportOpnameFormScreen extends StatefulWidget {
  @override
  _ReportOpnameFormScreenState createState() => _ReportOpnameFormScreenState();
}

class _ReportOpnameFormScreenState extends State<ReportOpnameFormScreen> {
  TextEditingController descriptionController = TextEditingController();
  var _labelTextDescription = 'Description';
  String _description;
  String _monitoringId;
  String _conditionId;
  final _formKey = GlobalKey<FormState>();

  void _postStoreReportOpname() async {
    Map body = {
      'monitoring_id': _monitoringId,
      'condition_id': _conditionId,
      'description': _description ?? '',
    };

    await postRequestOpname(body).then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        EasyLoading.showSuccess('Sukses');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AssetScreen()),
          (route) => false,
        );
        return;
      } else {
        EasyLoading.showError('Failed');
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Report Opname Form',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  width: size.width,
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: DropdownSearch<Monitoring>(
                          validator: (v) => v == null ? "Required Field" : null,
                          showSelectedItems: true,
                          mode: Mode.MENU,
                          compareFn: (i, s) => i?.isEqual(s) ?? false,
                          dropdownSearchDecoration: InputDecoration(
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
                          onFind: (String filter) =>
                              getRequestAssetMonitoring(),
                          onChanged: (value) {
                            setState(() {
                              _monitoringId = value.id;
                              if (_formKey.currentState.validate()) {
                                return;
                              } else {
                                return;
                              }
                            });
                          },
                          dropdownBuilder: customDropDownUnitReportOpname,
                          popupItemBuilder:
                              customPopupItemBuilderUnitReportOpname,
                        ),
                      ),
                      Divider(height: 5, color: Colors.white),
                      Text(
                        'Click to choose asset to be checked',
                        style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFFBAC1CC),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto'),
                      ),
                      Divider(height: 16, color: Colors.white),
                      Container(
                        child: DropdownSearch<Condition>(
                          validator: (v) => v == null ? "Required Field" : null,
                          showSelectedItems: true,
                          mode: Mode.MENU,
                          compareFn: (i, s) => i?.isEqual(s) ?? false,
                          dropdownSearchDecoration: InputDecoration(
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
                          onFind: (String filter) => getRequestCondition(),
                          onChanged: (value) {
                            setState(() {
                              _conditionId = value.id;
                              if (_formKey.currentState.validate()) {
                                return;
                              } else {
                                return;
                              }
                            });
                          },
                          dropdownBuilder: customDropDownUnitCondition,
                          popupItemBuilder: customPopupItemBuilderUnitCondition,
                        ),
                      ),
                      Divider(height: 5, color: Colors.white),
                      Text(
                        'Click to choose checked condition',
                        style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFFBAC1CC),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto'),
                      ),
                      Divider(height: 15, color: Colors.white),
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
                            borderSide:
                                BorderSide(color: Colors.white, width: 5.0),
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
                        onChanged: (value) {
                          _description = value;
                          print(_description);
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            _description = value;
                          });
                        },
                      ),
                      Divider(height: 5, color: Colors.white),
                      Text(
                        'Additional information related to asset condition',
                        style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFFBAC1CC),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto'),
                      ),
                      Divider(height: 24, color: Colors.white),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 44,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFF12A32)),
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
                            if (_formKey.currentState.validate()) {
                              EasyLoading.show(status: 'Loading');
                              _postStoreReportOpname();
                            } else {
                              return;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
