import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/data/providers/post_provider.dart';
import 'package:aluga_facil/app/data/repositories/post_repository.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class PostDetailsPageController extends GetxController {
  TextEditingController inputSituation = TextEditingController();
  TextEditingController inputPostDate = TextEditingController();
  TextEditingController inputContact = TextEditingController();
  TextEditingController inputObs = TextEditingController();
  TextEditingController inputValue = TextEditingController();

  final listTabs = <DataTab>[].obs;

  final tabIndex = 0.obs;

  final PostRepository postRepository = PostRepository(PostProvider());

  final post = PostModel().obs;

  @override
  void onInit() async {
    super.onInit();
    post.value = Get.arguments as PostModel;
    listTabs.value = <DataTab>[
      DataTab(
        title: 'Ativo',
        icon: Icons.check_circle_outline,
        isSelected: true,
      ),
      DataTab(
        title: 'Desativar',
        icon: Icons.remove_circle_outline,
        isSelected: false,
      ),
      DataTab(
        title: post.value.situation == 'Vender' ? 'Vendida' : 'Alugada',
        icon: post.value.situation == 'Vender'
            ? Icons.sell_outlined
            : Icons.handshake,
        isSelected: false,
      ),
    ];
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

  alterStatusPost() async {
    String status = '';
    switch (tabIndex.value) {
      case 1:
        status = 'Inactive';
        break;
      case 2:
        status = post.value.situation == 'Vender' ? 'Sold' : 'Rented';
        break;
    }
    await postRepository.alterStatusPost(post.value, status);
    Get.back();
    showMessageBar('Sucesso', 'Postagem alterada com sucesso');
  }
}
