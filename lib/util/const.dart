import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String BASE_URL = 'https://finnet.sisca.id/api/v1/';


Future<File> takePicture() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // return await ImagePicker.pickImage(source: ImageSource.gallery);
  // ImagePicker _imagePicker = ImagePicker();
  // Directory appDir = await getExternalStorageDirectory();
  // String directoryPath = '${appDir.path}/Camera';
  // await Directory(directoryPath).create(recursive: true);
  // String filePath = '$appDir.jpg';
  // File file = File(filePath);
  // String basenamee = appDir.path.split('/').last;
  // print(basenamee);
  // print(filePath);
  // try {
  //   await _imagePicker.pickImage(source: ImageSource.gallery);
  //   prefs.setString(filePath, 'filename');
  // } catch (e) {
  //   return null;
  // }
  // return File(basenamee);
}


Future<String> getFileName(File imageFile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String fileName = basename(imageFile.path);
  prefs.setString(fileName, 'filename');
  print(fileName);
  return fileName;
}
