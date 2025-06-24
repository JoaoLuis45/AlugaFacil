import 'dart:io';

import 'package:aluga_facil/app/models/user_data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomePageController extends GetxController {
  final Rx<UserDataModel> user = UserDataModel().obs;
  late UserCredential credential;

  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments['user'];
    credential = Get.arguments['credential'];
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      return File(result.files.first.path!);
    }
  }

  switchProfilePhoto(BuildContext context) async {
    try {
      final avatar = await _uploadImage();

      if (avatar != null) {
        final fileName = '${const Uuid().v4()}.${avatar.path.split('.').last}';

        final fileRef = _storage.ref(fileName);

        await fileRef.putFile(avatar);

        final fileUrl = await fileRef.getDownloadURL();

        await credential.user?.updatePhotoURL(fileUrl);

        user.value = UserDataModel(
          name: user.value.name,
          email: user.value.email,
          avatar: fileUrl
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
