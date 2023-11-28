import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  }
  print('No image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

 String toDate(DateTime dateTime){
  final date = DateFormat.yMMMEd().format(dateTime);
  return '$date';
}

 String toDateTime(DateTime dateTime){
  final date = DateFormat.yMMMEd().format(dateTime);
  final time = DateFormat.Hm().format(dateTime);

  return '$date $time';
}

String toTime(DateTime dateTime){
  final time = DateFormat.Hm().format(dateTime);
  return '$time';
}