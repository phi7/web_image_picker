import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:firebase/firebase.dart' as fb;


class ImagePickerModel extends ChangeNotifier {
  ImagePickerModel({Key? key});

  String textMessage = 'initial';
  String? imageURL;
  //File? file;

  Future downloadURL() async {
    //final instance = FirebaseFirestore.instance;

    FirebaseStorage storage = FirebaseStorage.instance;

    Reference imageRef = storage.ref().child("DL").child("dangomushi_icon.jpg");
    imageURL = await imageRef.getDownloadURL();
    print(imageURL);
    notifyListeners();
  }

  imagePicker() {
    return ImagePickerWeb.getImageInfo.then((MediaInfo mediaInfo) {
      uploadFile(mediaInfo, 'UL', mediaInfo.fileName!);
    });
  }

  uploadFile(MediaInfo mediaInfo, String ref, String fileName) {
    try {
      String mimeType = mime(basename(mediaInfo.fileName!))!;
      var metaData = fb.UploadMetadata(contentType: mimeType);
      fb.StorageReference storageReference = fb.storage().ref(ref).child(fileName);

      fb.UploadTask uploadTask = storageReference.put(mediaInfo.data, metaData);
      var imageUri;
      uploadTask.future.then((snapshot) => {
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          snapshot.ref.getDownloadURL().then((dynamic uri) {
            imageUri = uri;
            print('Download URL: ${imageUri.toString()}');
          })
        })
      });


    } catch (e) {
      print('File Upload Error: $e');
    }
  }



  /*
  void uploadFile() async {
    // imagePickerで画像を選択する
    // upload

      pickerFile =
    await ImagePickerWeb().getImage(source: ImageSource.gallery);
    print(pickerFile);
    File file = File(pickerFile!.path);
    print(file);

    //Image file = "images/dam.png";

    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UL/upload-pic.png").putFile(file);
    } catch (e) {
      print(e);
    }
  }

   */




}
