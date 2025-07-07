import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/data/providers/post_provider.dart';
import 'package:aluga_facil/app/data/repositories/post_repository.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailsPageController extends GetxController {
  TextEditingController inputSituation = TextEditingController();
  TextEditingController inputPostDate = TextEditingController();
  TextEditingController inputContact = TextEditingController();
  TextEditingController inputObs = TextEditingController();
  TextEditingController inputValue = TextEditingController();

  final PostRepository inquilinoRepository = PostRepository(PostProvider());

  final post = PostModel().obs;

  @override
  void onInit() async {
    super.onInit();
    post.value = Get.arguments as PostModel;
    getDetailsPost();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<PostDetailsPageController>();
  }

  getDetailsPost() {
    inputSituation.text = post.value.situation ?? '';
    inputContact.text = post.value.contact ?? '';
    inputObs.text = post.value.observations ?? '';
    inputValue.text = post.value.valor?.toString() ?? '';
    if (post.value.postDate != null) {
      inputPostDate.text = formatDate(post.value.postDate!);
    } else {
      inputPostDate.text = '';
    }
    post.update((a) {});
  }
}
