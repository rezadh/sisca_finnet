import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sisca_finnet/model/maintenance_model.dart';
import 'package:sisca_finnet/screen/detail/maintenance_detail_screen.dart';
import 'package:sisca_finnet/screen/main/test_screen.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:sisca_finnet/widget/form_maintenance.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}


class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      postRequestMaintenance();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Maintenance request',
          style: TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: -60,
                      left: 0,
                      child: Container(
                        // margin: EdgeInsets.only(bottom: 90),
                        width: size.width,
                        height: size.height,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 100),
                        child: RefreshIndicator(
                          key: _refreshIndicatorKey,
                          onRefresh: postRequestMaintenance,
                          child: Container(
                            width: size.width,
                            height: size.height,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: FutureBuilder<List<Maintenance>>(
                                future: postRequestMaintenance(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Maintenance> data = snapshot.data;
                                    return data.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: data.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              for(int i = 0; i < data.length; i++){
                                                print(data[i].requestedAmount);
                                              }
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MaintenanceDetailScreen(
                                                                id: data[index].id,
                                                                name: data[
                                                                        index]
                                                                    .monitoringMaintenance
                                                                    .name,
                                                                serialNumber: data[
                                                                        index]
                                                                    .monitoringMaintenance
                                                                    .serialNumber,
                                                                requestAmount: data[index].requestedAmount,
                                                                statusName: data[index].status.name,
                                                                statusColor: data[index].status.color,
                                                                description: data[index].description,
                                                                evidenceDownload: data[index].requestEvidence,
                                                                userRequestAvatar: data[index].userRequestedBy.avatar,
                                                                userRequestUsername: data[index].userRequestedBy.username,
                                                                userRequestFirstname: data[index].userRequestedBy.firstname,
                                                                userRequestLastname: data[index].userRequestedBy.lastname,
                                                                userRequestLevel: data[index].userRequestedBy.level,
                                                                userRequestPositionName: data[index].userRequestedBy.userPosition.name,
                                                                userReviewAvatar: data[index].userReviewedTo.avatar,
                                                                userReviewUsername: data[index].userReviewedTo.username,
                                                                userReviewFirstname: data[index].userReviewedTo.firstname,
                                                                userReviewLastname: data[index].userReviewedTo.lastname,
                                                                userReviewLevel: data[index].userReviewedTo.level,
                                                                userReviewPositionName: data[index].userReviewedTo.userPosition.name,
                                                                userApproveAvatar: data[index].userRequestedTo.avatar,
                                                                userApproveUsername: data[index].userRequestedTo.username,
                                                                userApproveFirstname: data[index].userRequestedTo.firstname,
                                                                userApproveLastname: data[index].userRequestedTo.lastname,
                                                                userApproveLevel: data[index].userRequestedTo.level,
                                                                userApprovePositionName: data[index].userRequestedTo.userPosition.name,
                                                              )));
                                                },
                                                child: Card(
                                                  elevation: 1,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 15),
                                                    width: size.width,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${data[index].id.substring(data[index].id.length - 4).toUpperCase().toString()} - ',
                                                                  style: TITLE,
                                                                ),
                                                                Text(
                                                                  data[index]
                                                                      .userRequestedBy
                                                                      .username,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Color(
                                                                          0xFF595D64),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          'Roboto'),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 8),
                                                            Text(
                                                              data[index]
                                                                  .monitoringMaintenance
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Color(
                                                                      0xFF595D64),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              data[index]
                                                                  .monitoringMaintenance
                                                                  .serialNumber,
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Color(
                                                                      0xFF595D64),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              data[index]
                                                                  .status
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: data[index]
                                                                              .status
                                                                              .color ==
                                                                          'green'
                                                                      ? Color(
                                                                          0xFF52C829)
                                                                      : data[index].status.color ==
                                                                              'default'
                                                                          ? Color(
                                                                              0xFF595D64)
                                                                          : Color(
                                                                              0xFF598BD7),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                            ),
                                                            SizedBox(height: 8),
                                                            Text(
                                                              NumberFormat.currency(
                                                                      locale:
                                                                          'id',
                                                                      symbol:
                                                                          'IDR ',
                                                                      decimalDigits:
                                                                          0)
                                                                  .format(data[
                                                                          index]
                                                                      .requestedAmount)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Color(
                                                                      0xFF595D64),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50),
                                            margin: EdgeInsets.only(
                                                top: size.height / 3),
                                            width: size.width,
                                            height: size.height / 2,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                      'assets/images/empty_data.png'),
                                                  Text(
                                                    'No Requests yet..',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFF595D64),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                  } else {
                                    return Text('');
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 77,
                      right: 22,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TestScreen()),
                            // );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => AlertPopUp()),
                            // );
                            // showPopRequestData(context);
                            showDialog(
                                context: context,
                                builder: (context) => FormMaintenance());
                            // FormMaintenance();
                          });
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Color(0xFFF12A32),
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
            ],
          ),
        ),
      ),
    );
  }
}
