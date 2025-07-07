import 'package:aluga_facil/app/controllers/post_hiring_page_controller.dart';
import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostHiringPage extends GetView<PostHiringPageController> {
  const PostHiringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.lista.isEmpty
          ? Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.house_outlined, size: 100, color: brownColorTwo),
                  Text(
                    'Nenhuma postagem para alugar encontrada',
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
                                child: post.house.fotoCasa != null &&
                                        post.house.fotoCasa != ''
                                    ? CircleAvatar(
                                        radius: 32,
                                        backgroundImage: NetworkImage(
                                          post.house.fotoCasa!,
                                        ),
                                      )
                                    : Icon(
                                        Icons.house,
                                        color: brownColorTwo,
                                        size: 64,
                                      ),
                              ),
                              title: Text(
                                '${post.situation}: ${post.house.numeroCasa} - ${post.house.logradouro}',
                              ),
                              subtitle: Text(
                                '${post.contact} | ${formatDate(post.postDate)} | R\$${post.value}',
                              ),
                              onTap: () {
                                // Get.toNamed('/detailsHouse', arguments: casa);
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
