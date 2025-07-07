import 'package:aluga_facil/app/controllers/create_post_page_controller.dart';
import 'package:aluga_facil/app/data/providers/post_provider.dart';
import 'package:aluga_facil/app/data/repositories/post_repository.dart';
import 'package:get/get.dart';

class CreatePostBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<CreatePostController>(CreatePostController(PostRepository(PostProvider())));
  }
}