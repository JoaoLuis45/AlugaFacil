import 'package:aluga_facil/app/controllers/home_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brownColorTwo,
        iconTheme: IconThemeData(color: goldColorThree),
        title: Text(
          'Meus Imóveis',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: goldColorThree,
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: brownColorTwo),
              currentAccountPicture: CircleAvatar(
                child: Obx(() {
                  return controller.userController.value.loggedUser.avatar ==
                          null
                      ? InkWell(
                          onTap: () {
                            controller.switchProfilePhoto(context);
                          },
                          child: Icon(Icons.photo_camera),
                        )
                      : CircleAvatar(
                          radius: 33,
                          backgroundImage: NetworkImage(
                            controller.userController.value.loggedUser.avatar!,
                          ),
                          child: Text(''),
                        );
                }),
              ),
              accountName: Text(
                controller.userController.value.loggedUser.name!,
              ),
              accountEmail: Text(
                controller.userController.value.loggedUser.email!,
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    'Sair',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  onTap: () {
                    controller.repository.logout();
                    controller.userController.value.logout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
