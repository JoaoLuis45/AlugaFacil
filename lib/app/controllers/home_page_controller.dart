import 'dart:io';

import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/models/user_data_model.dart';
import 'package:aluga_facil/app/data/repositories/user_Repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomePageController extends GetxController {
  final UserRepository _repository;
  UserRepository get repository => _repository;

  final PageController pageController = PageController();
  final indexPage = 2.obs;

  final userController = Get.find<UserController>();
  final inquilinoController = Get.find<InquilinoPageController>();
  final houseController = Get.find<HouseController>();
  final paymentController = Get.find<FinanceiroPageController>();

  HomePageController(this._repository);

  @override
  void onInit() async {
    super.onInit();
    final user = _repository.getUserData();
    userController.loggedUser = user;
    await refreshPages();
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  refreshPages() async {
    await inquilinoController.inquilinoRepository.read();
    await houseController.houseRepository.read();
    await paymentController.paymentRepository.read();
  }

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

        final currentUser = FirebaseAuth.instance.currentUser;

        final fileUrl = await fileRef.getDownloadURL();
        await currentUser?.updatePhotoURL(fileUrl);

        userController.loggedUser = UserDataModel(
          name: userController.loggedUser.name,
          email: userController.loggedUser.email,
          avatar: fileUrl,
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
