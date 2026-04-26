import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:open_file/open_file.dart';

class ImageOpener {
  /// Crop and open image file with default image viewer app via Android intent
  /// [imagePath] must be an absolute file system path (not asset path)
  static Future<void> openImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!await file.exists()) {
        throw FileSystemException('File not found', imagePath);
      }

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: const Color.fromARGB(255, 66, 133, 244),
            toolbarWidgetColor: const Color.fromARGB(255, 255, 255, 255),
            activeControlsWidgetColor: const Color.fromARGB(255, 66, 133, 244),
            lockAspectRatio: false,
            hideBottomControls: false,
          ),
        ],
      );

      if (croppedFile == null) return;

      await OpenFile.open(croppedFile.path);
    } catch (e) {
      rethrow;
    }
  }
}
