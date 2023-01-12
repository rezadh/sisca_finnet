import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:sisca_finnet/screen/splash_screen.dart';

class CheckEmulatorScreen extends StatefulWidget {
  @override
  State<CheckEmulatorScreen> createState() => _CheckEmulatorScreenState();
}

class _CheckEmulatorScreenState extends State<CheckEmulatorScreen> {

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool jailbroken;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
    } on PlatformException {
      jailbroken = true;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Is physic: ${androidInfo.isPhysicalDevice}');
      if (!jailbroken) {
        if (androidInfo.isPhysicalDevice) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (route) => false,
          );
        } else {
          return null;
        }
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Is physic: ${iosInfo.isPhysicalDevice}');
      if (!jailbroken) {
        if (iosInfo.isPhysicalDevice) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (route) => false,
          );
        } else {
          return null;
        }
      }
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

  }

  // initPlatformState() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if(Platform.isAndroid){
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     print('Is physic: ${androidInfo.isPhysicalDevice}');
  //     if(androidInfo.isPhysicalDevice){
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => SplashScreen()),
  //         (route) => false,
  //       );
  //     }else{
  //       return null;
  //     }
  //   }else if(Platform.isIOS){
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     print('Is physic: ${iosInfo.isPhysicalDevice}');
  //     if(iosInfo.isPhysicalDevice){
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => SplashScreen()),
  //             (route) => false,
  //       );
  //     }else{
  //       return null;
  //     }
  //   }
  // String text;
  // bool res = await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator;
  // if(res){
  //   text = res.toString();
  //   return null;
  // }else{
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => SplashScreen()),
  //         (route) => false,
  //   );
  // }
  // if (!mounted) return;
  //
  // setState(() {
  //   _text = text;
  // });
  // print(_text);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
