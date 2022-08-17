import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File imgFile) {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      return ref.putFile(imgFile);
    } on FirebaseException {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException {
      return null;
    }
  }
}
