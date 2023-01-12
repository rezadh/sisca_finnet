import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sisca_finnet/screen/check_emulator_screen.dart';
import 'package:sisca_finnet/screen/login_screen.dart';
import 'package:sisca_finnet/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sisca Finnet',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFF12A32),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CheckEmulatorScreen(),
      },
      builder: EasyLoading.init(),
      // home: Scaffold(
      //   appBar: AppBar(title: const Text('Is am i in matrix?')),
      //   body: Test(),
      // ),
    );
  }
}
//
// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _isRealDevice(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Container(width: 0, child: CircularProgressIndicator());
//         }
//         // WidgetsBinding.instance.addPostFrameCallback((_) {
//         //   Navigator.pushAndRemoveUntil(
//         //     context,
//         //     MaterialPageRoute(builder: (context) => SplashScreen()),
//         //     (route) => false,
//         //   );
//         //   // Navigator.pushReplacement(context, newRoute)
//         // });
//         return null;
//       },
//     );
//   }

  // Future<bool> _isRealDevice() async {
  //   AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
  //   return androidInfo.isPhysicalDevice;
  // }
// }
