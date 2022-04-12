import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'detail/asset_detail_screen.dart';

class AssetScanScreen extends StatefulWidget {
  @override
  _AssetScanScreenState createState() => _AssetScanScreenState();
}

class _AssetScanScreenState extends State<AssetScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      // setState(() {
      if (mounted) {
        controller.dispose();
        result = scanData;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AssetDetailScreen(id: result.code)));
        print(result.code);
      }
      // });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
          'Asset Scan',
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
                top: 0,
                left: 0,
                child: Container(
                  // color: Colors.black,
                  width: size.width,
                  height: size.height,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                )),
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
