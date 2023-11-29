// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();

  XFile? _file = await _picker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('no image selected');
  
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content)
    )
  );

}