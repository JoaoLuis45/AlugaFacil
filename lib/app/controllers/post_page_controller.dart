import 'dart:async';

import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/providers/post_provider.dart';
import 'package:aluga_facil/app/data/repositories/post_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class PostPageController extends GetxController {
  final isLoading = false.obs;
  final pageIndex = 0.obs;

  final listTabs = <DataTab>[
    DataTab(title: 'Vender', icon: Icons.sell_outlined, isSelected: true),
    DataTab(title: 'Alugar', icon: Icons.house_outlined, isSelected: false),
  ];

  PageController pageController = PageController();


  StreamSubscription<DatabaseEvent>? streamSubscription;

  final userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    registerFirebaseListen();
  }

  registerFirebaseListen() {
    String userRef = "posts";
    DatabaseReference ref = FirebaseDatabase.instance.ref(userRef);
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    streamSubscription = ref.onValue.listen(PostRepository(PostProvider()).handle);
  }
}
