
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sudoku/WidgetCon/CustomToast.dart';

class PickImage{

  static File? image;

  bool isFileSizeValid(File file, int maxSizeInBytes) {
    int fileSize = file.lengthSync();
    return fileSize <= maxSizeInBytes;
  }

  Future<void> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        if(isFileSizeValid(File(pickedImage.path), 1048576*10)){
          image = File(pickedImage.path);
        }else{
          CustomToast.showToast('Image file size exceeds the maximum allowed size 10mb.');
        }
      }
    } on PlatformException catch (e) {
      CustomToast.showToast('Platform FAILED');
    }
  }
}