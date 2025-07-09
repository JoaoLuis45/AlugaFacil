import 'package:aluga_facil/app/controllers/post_page_controller.dart';
import 'package:aluga_facil/app/ui/pages/postTabs/post_hiring_page.dart';
import 'package:aluga_facil/app/ui/pages/postTabs/post_selling_page.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class PostPage extends GetView<PostPageController> {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: goldColorThree),
        title: const Text(
          'Postagens',
          style: TextStyle(
            color: goldColorThree,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: brownColorTwo,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/createPost');
            },
            icon: const Icon(Icons.post_add, color: goldColorThree),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height
          ),
          child: Column(
            children: [
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: FlutterToggleTab(
                      width: 90, // width in percent
                      borderRadius: 30,
                      height: 50,
                      selectedIndex: controller.pageIndex.value,
                      selectedBackgroundColors: [goldColorThree, goldColorTwo],
                      selectedTextStyle: TextStyle(
                        color: goldToBrownColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      unSelectedTextStyle: TextStyle(
                        color: brownColorTwo,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      dataTabs: controller.listTabs,
                      selectedLabelIndex: (index) {
                        controller.pageIndex.value = index;
                        controller.pageController.jumpToPage(index);
                      },
                      isScroll: false,
                    ),
                  ),
                );
              }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.pageIndex.value = index;
                    },
                    children: [PostSellingPage(), PostHiringPage()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
