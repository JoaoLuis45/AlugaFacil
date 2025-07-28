import 'package:aluga_facil/app/controllers/home_page_controller.dart';
import 'package:aluga_facil/app/ui/pages/tabs/dashboard_page.dart';
import 'package:aluga_facil/app/ui/pages/tabs/financeiro_page.dart';
import 'package:aluga_facil/app/ui/pages/tabs/house_page.dart';
import 'package:aluga_facil/app/ui/pages/tabs/inquilino_page.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/fade_indexed_stack.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomePage extends GetView<HomePageController> {
  List<Widget> pages = [
    const HousePage(),
    const InquilinoPage(),
    const DashboardPage(),
    const FinanceiroPage(),
  ];
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: brownColorTwo,
        iconTheme: IconThemeData(color: goldColorThree),
        title: Text(
          'AlugaFácil',
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
                  return controller.userController.loggedUser.avatar == null
                      ? InkWell(
                          onTap: () {
                            controller.switchProfilePhoto(context);
                          },
                          child: Icon(Icons.photo_camera),
                        )
                      : CircleAvatar(
                          radius: 33,
                          backgroundImage: NetworkImage(
                            controller.userController.loggedUser.avatar!,
                          ),
                          child: Text(''),
                        );
                }),
              ),
              accountName: Text(controller.userController.loggedUser.name!),
              accountEmail: Text(controller.userController.loggedUser.email!),
            ),
            Column(
              children: [
                ListTile(
                    leading: Icon(Icons.delete_forever, color: Colors.red),
                    title: Text(
                      'Deletar Conta',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
                    ),
                    onTap: () async {
                      final result = await showDialogMessage(
                        context,
                        'Deletar Conta',
                        'Deseja deletar essa conta?',
                      );
                      if (result != true) return;
                      controller.repository.deleteUserAccount();
                      controller.userController.logout();
                    },
                  ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    'Sair',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  onTap: () async{
                    await controller.repository.logout();
                    controller.userController.logout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(() => getBody()),
      bottomNavigationBar: getFooter(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: brownColorTwo,
        onPressed: () {
          Get.toNamed('/posts');
        },
        child: Icon(Icons.add_home_work_sharp, color: goldColorThree, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBody() {
    return FadeIndexedStack(index: controller.indexPage.value, children: pages);
  }

  Widget getFooter() {
    List<IconData> iconIndex = [
      Icons.house_outlined,
      Icons.person_outline,
      Icons.dashboard_customize_outlined,
      Icons.attach_money_rounded,
    ];

    return Obx(
      () => AnimatedBottomNavigationBar(
        activeColor: goldColorThree,
        splashColor: goldColorOne,
        backgroundColor: brownColorTwo,
        inactiveColor: Colors.white60,
        icons: iconIndex,
        gapWidth: 60,
        gapLocation: GapLocation.center,
        activeIndex: controller.indexPage.value,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 16,
        rightCornerRadius: 16,
        iconSize: 25,
        onTap: (index) => controller.indexPage.value = index,
      ),
    );
  }
}
