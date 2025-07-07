import 'package:aluga_facil/app/controllers/create_post_page_controller.dart';
import 'package:aluga_facil/app/controllers/post_hiring_page_controller.dart';
import 'package:aluga_facil/app/controllers/post_selling_page_controller.dart';
import 'package:aluga_facil/app/data/databases/db_realtime.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class PostProvider {
  late FirebaseDatabase db;

  PostProvider() {
    _startProvider();
  }

  _startProvider() {
    _startRealtime();
  }

  _startRealtime() {
    db = DbRealtime.get();
  }

  Future<void> setPost(PostModel post) async {
    final postController = Get.find<CreatePostController>();
    await db
        .ref("posts/${post.id}")
        .set({
          "post": post.toJson(),
          "status": "posted",
          "type": post.situation,
        })
        .onError((error, stackTrace) => postController.isLoading = false)
        .timeout(
          30.seconds,
          onTimeout: () {
            postController.isLoading = false;
          },
        );
  }

  Future<PostModel> _sellingHandle(postId, value) async {
    final status = value['status'];
    try {
      if (status == 'posted') {
        if (value['type'] == 'Vender') {
          final v = value['post'];
          final post = PostModel(
            contact: v['contact'],
            house: HouseModel(
              id: v['house']['id'],
              numeroCasa: v['house']['numeroCasa'],
              logradouro: v['house']['logradouro'],
              bairro: v['house']['bairro'],
              cidade: v['house']['cidade'],
              fotoCasa: v['house']['fotoCasa'],
              valorAluguel:
                  double.tryParse(v['house']['valorAluguel'].toString()) ?? 0.0,
              inquilino: v['house']['inquilino'],
              dataAluguel: v['house']['dataAluguel'] != null
                  ? DateTime.tryParse(v['house']['dataAluguel'])
                  : null,
            ),
            postDate: v['postDate'] != null
                ? DateTime.tryParse(v['postDate'])
                : null,
            situation: v['situation'],
            valor: double.tryParse(v['valor'].toString()) ?? 0.0,
            observations: v['observations'],
          );
          post.id = postId;
          return post;
        }
      }
    } catch (e) {
      showMessageBar('Erro', 'Não foi possível buscar as postagens de venda.');
    }
    throw Exception('Não foi possível retornar um PostModel válido.');
  }

  Future<PostModel> _hiringHandle(postId, value) async {
    final status = value['status'];
    try {
      if (status == 'posted') {
        if (value['type'] == 'Alugar') {
          final v = value['post'];
          final post = PostModel(
            contact: v['contact'],
            house: HouseModel(
              id: v['house']['id'],
              numeroCasa: v['house']['numeroCasa'],
              logradouro: v['house']['logradouro'],
              bairro: v['house']['bairro'],
              cidade: v['house']['cidade'],
              fotoCasa: v['house']['fotoCasa'],
              valorAluguel:
                  double.tryParse(v['house']['valorAluguel'].toString()) ?? 0.0,
              inquilino: v['house']['inquilino'],
              dataAluguel: v['house']['dataAluguel'] != null
                  ? DateTime.tryParse(v['house']['dataAluguel'])
                  : null,
            ),
            postDate: v['postDate'] != null
                ? DateTime.tryParse(v['postDate'])
                : null,
            situation: v['situation'],
            valor: double.tryParse(v['valor'].toString()) ?? 0.0,
            observations: v['observations'],
          );
          post.id = postId;
          return post;
        }
      }
    } catch (e) {
      showMessageBar('Erro', 'Não foi possível buscar as postagens de venda.');
    }
    throw Exception('Não foi possível retornar um PostModel válido.');
  }

  void handle(DatabaseEvent event) async{
    final hiringController = Get.find<PostHiringPageController>();
    final sellingController = Get.find<PostSellingPageController>();
    if (event.snapshot.value == null) return;
    final data = event.snapshot.value as Map<dynamic, dynamic>;

    sellingController.isLoading.value = true;
    hiringController.isLoading.value = true;
    var sellingList = [];
    var hiringList = [];
    data.forEach((postId, value)  async{
      final status = value['status'];
      if (status == 'posted') {
        if (value['type'] == 'Vender') {
          sellingList.add( await _sellingHandle(postId, value));
        } else if (value['type'] == 'Alugar') {
          hiringList.add( await _hiringHandle(postId, value));
        }
      }
      sellingController.lista.assignAll(sellingList);
      hiringController.lista.assignAll(hiringList);
      hiringController.isLoading.value = false;
      sellingController.isLoading.value = false;
      if (status == "error") {
        printError(info: postId);
        printError(info: value['post']);
        printError(info: value['status']);
      }
    });
    
  }
}
