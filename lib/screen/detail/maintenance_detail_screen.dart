import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sisca_finnet/util/const.dart';

class MaintenanceDetailScreen extends StatefulWidget {
  final id;
  final name;
  final serialNumber;
  final statusName;
  final statusColor;
  final requestAmount;
  final description;
  final evidenceDownload;
  final userRequestAvatar;
  final userRequestUsername;
  final userRequestFirstname;
  final userRequestLastname;
  final userRequestLevel;
  final userRequestPositionName;
  final userReviewAvatar;
  final userReviewUsername;
  final userReviewFirstname;
  final userReviewLastname;
  final userReviewLevel;
  final userReviewPositionName;
  final userApproveAvatar;
  final userApproveUsername;
  final userApproveFirstname;
  final userApproveLastname;
  final userApproveLevel;
  final userApprovePositionName;

  MaintenanceDetailScreen(
      {this.id,
      this.name,
      this.serialNumber,
      this.statusName,
      this.statusColor,
      this.requestAmount,
      this.description,
      this.evidenceDownload,
      this.userRequestAvatar,
      this.userRequestUsername,
      this.userRequestFirstname,
      this.userRequestLastname,
      this.userRequestLevel,
      this.userRequestPositionName,
      this.userReviewAvatar,
      this.userReviewUsername,
      this.userReviewFirstname,
      this.userReviewLastname,
      this.userReviewLevel,
      this.userReviewPositionName,
      this.userApproveAvatar,
      this.userApproveUsername,
      this.userApproveFirstname,
      this.userApproveLastname,
      this.userApproveLevel,
      this.userApprovePositionName});

  @override
  _MaintenanceDetailScreenState createState() =>
      _MaintenanceDetailScreenState();
}

class _MaintenanceDetailScreenState extends State<MaintenanceDetailScreen> {
  var _id;
  var _name;
  var _serialNumber;
  var _statusName;
  var _statusColor;
  var _requestAmount;
  var _description;
  var _evidenceDownload;
  var _userRequestAvatar;
  var _userRequestUsername;
  var _userRequestFirstname;
  var _userRequestLastname;
  var _userRequestLevel;
  var _userRequestPositionName;
  var _userReviewAvatar;
  var _userReviewUsername;
  var _userReviewFirstname;
  var _userReviewLastname;
  var _userReviewLevel;
  var _userReviewPositionName;
  var _userApproveAvatar;
  var _userApproveUsername;
  var _userApproveFirstname;
  var _userApproveLastname;
  var _userApproveLevel;
  var _userApprovePositionName;

  void _getWidgetDetail() {
    _id = widget.id;
    _name = widget.name;
    _serialNumber = widget.serialNumber;
    _statusName = widget.statusName;
    _statusColor = widget.statusColor;
    _requestAmount = widget.requestAmount;
    _description = widget.description;
    _evidenceDownload = widget.evidenceDownload;
    _userRequestAvatar = widget.userRequestAvatar;
    _userRequestUsername = widget.userRequestUsername;
    _userRequestFirstname = widget.userRequestFirstname;
    _userRequestLastname = widget.userRequestLastname;
    _userRequestLevel = widget.userRequestLevel;
    _userRequestPositionName = widget.userRequestPositionName;
    _userReviewAvatar = widget.userReviewAvatar;
    _userReviewUsername = widget.userReviewUsername;
    _userReviewFirstname = widget.userReviewFirstname;
    _userReviewLastname = widget.userRequestLastname;
    _userReviewLevel = widget.userReviewLevel;
    _userReviewPositionName = widget.userReviewPositionName;
    _userApproveAvatar = widget.userApproveAvatar;
    _userApproveUsername = widget.userApproveUsername;
    _userApproveFirstname = widget.userApproveFirstname;
    _userApproveLastname = widget.userApproveLastname;
    _userApproveLevel = widget.userApproveLevel;
    _userApprovePositionName = widget.userApprovePositionName;
  }

  Future download(String url) async {
    var status = await Permission.storage.request();
    //TODO UBAH NAMA FILE
    if (status.isGranted) {
      final baseStorage = await getApplicationDocumentsDirectory();
      print(baseStorage.path);
      final downloadPath = '${baseStorage.path}/Sisca_Finnet';
      print(downloadPath);
      await Directory(downloadPath).create(recursive: true);
      await FlutterDownloader.enqueue(
        url: url,
        fileName:
            'maintenance_evidence_${_id}_${DateTime.now().millisecondsSinceEpoch}',
        savedDir: baseStorage.path,
        saveInPublicStorage: true,
        showNotification: true,
        // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }
  }

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    setState(() {
      _getWidgetDetail();
    });
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status == DownloadTaskStatus.complete) {
        EasyLoading.showSuccess('File Downloaded');
      } else if (status == DownloadTaskStatus.failed) {
        EasyLoading.showError('Failed');
      } else if (status == DownloadTaskStatus.running) {
        EasyLoading.show(status: 'Downloading...');
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
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
          'Maintenance detail',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        child: Stack(
          children: [
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
            Positioned(
              top: 100,
              left: 0,
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _name ?? '',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF595D64),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto'),
                              ),
                              Divider(color: Colors.white, height: 8),
                              Text(_serialNumber ?? '',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF595D64),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto')),
                            ],
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Color(0xFF686868)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Text(_statusName ?? '',
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: _statusColor == 'green'
                                          ? Color(0xFF52C829)
                                          : _statusColor == 'default'
                                              ? Color(0xFF595D64)
                                              : Color(0xFF598BD7),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto'))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white, height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Request amount :',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF595D64),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                          Text(
                              NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'IDR ',
                                          decimalDigits: 0)
                                      .format(_requestAmount) ??
                                  '',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF595D64),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Roboto')),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white, height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Maintenance option :',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF595D64),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                          Column(
                            children: [
                              Text('Logistic Support',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF595D64),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto')),
                              Text('Bantuan Logistik',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF595D64),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white, height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Request description :',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF595D64),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                          Container(
                            width: 150,
                            child: Text(_description ?? '',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF595D64),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Roboto')),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white, height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Request evidence :',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF595D64),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                          Container(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0)),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFF12A32)),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Download',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                              onPressed: () => download(
                                  BASE_URL_STORAGE + _evidenceDownload),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white),
                    Divider(),
                    Divider(color: Colors.white),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      child: _userRequestAvatar == null
                                          ? Image.asset(
                                              'assets/images/placeholder.png',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              BASE_URL_STORAGE +
                                                  _userRequestAvatar,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            _userRequestUsername == null
                                                ? ''
                                                : '$_userRequestUsername - ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userRequestFirstname == null
                                                ? ''
                                                : '$_userRequestFirstname ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userRequestLastname ?? '',
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
                                            _userRequestLevel == null
                                                ? ''
                                                : 'Level $_userRequestLevel - ',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userRequestPositionName ?? '',
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
                          Text(
                            'Requested by',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white, height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      child: _userReviewAvatar == null
                                          ? Image.asset(
                                              'assets/images/placeholder.png',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              BASE_URL_STORAGE +
                                                  _userReviewAvatar,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            _userReviewUsername == null
                                                ? ''
                                                : '$_userReviewUsername - ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userReviewFirstname == null
                                                ? ''
                                                : '$_userReviewFirstname ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userReviewLastname ?? '',
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
                                            _userReviewLevel == null
                                                ? ''
                                                : 'Level $_userReviewLevel - ',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userReviewPositionName ?? '',
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
                          Text(
                            'Reviewer by',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white, height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      child: _userApproveAvatar == null
                                          ? Image.asset(
                                              'assets/images/placeholder.png',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              BASE_URL_STORAGE +
                                                  _userApproveAvatar,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            _userApproveUsername == null
                                                ? ''
                                                : '$_userApproveUsername - ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userApproveFirstname == null
                                                ? ''
                                                : '$_userApproveFirstname ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userApproveLastname ?? '',
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
                                            _userApproveLevel == null
                                                ? ''
                                                : 'Level $_userApproveLevel - ',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Color(0xFF595D64),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            _userApprovePositionName ?? '',
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
                          Text(
                            'Approval by',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF595D64),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
