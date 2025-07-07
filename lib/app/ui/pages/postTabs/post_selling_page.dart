import 'package:aluga_facil/app/controllers/post_selling_page_controller.dart';
import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSellingPage extends GetView<PostSellingPageController> {
  const PostSellingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.lista.isEmpty
          ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sell_outlined,
                    size: 100,
                    color: brownColorTwo,
                  ),
                  Text(
                    'Nenhuma postagem de venda encontrada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: brownColorTwo,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final PostModel post = controller.lista[index];
                  return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            color: goldColorThree,
                            elevation: 8,
                            child: ListTile(
                              leading: Hero(
                                tag: post,
                                child: post.house!.fotoCasa != null &&
                                        post.house!.fotoCasa != ''
                                    ? CircleAvatar(
                                        radius: 32,
                                        backgroundImage: NetworkImage(
                                          post.house!.fotoCasa!,
                                        ),
                                      )
                                    : Icon(
                                        Icons.house,
                                        color: brownColorTwo,
                                        size: 64,
                                      ),
                              ),
                              title: Text(
                                '${post.situation}: ${post.house!.numeroCasa} - ${post.house!.logradouro}',
                              ),
                              subtitle: Text(
                                '${post.contact} | ${formatDate(post.postDate)} | R\$${post.valor}',
                              ),
                              onTap: () {
                                 Get.toNamed('/detailsPosts', arguments: post);
                              },
                            ),
                          ),
                        );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: controller.lista.length,
              ),
            );
    });
  }
}
