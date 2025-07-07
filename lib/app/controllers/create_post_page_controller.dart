import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/data/enums/situation_post.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/post_repository.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CreatePostController extends GetxController {
  TextEditingController inputHouse = TextEditingController();
  TextEditingController inputContact = TextEditingController();
  TextEditingController inputSituation = TextEditingController();
  TextEditingController inputValue = TextEditingController();
  TextEditingController inputObs = TextEditingController();
  MultiSelectController<SituationPost> multiController =
      MultiSelectController();

  List<DropdownItem<SituationPost>> situationtList = [];

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final PostRepository postRepository;
  final HouseRepository houseRepository = HouseRepository(HouseProvider());
  final casa = HouseModel().obs;
  late List<dynamic> listaCasasDisponiveis;

  CreatePostController(this.postRepository);

  @override
  void onInit() {
    super.onInit();
    getSituationPost();
  }

  getSituationPost() {
    for (var element in SituationPost.values) {
      situationtList.add(
        DropdownItem<SituationPost>(value: element, label: element.name),
      );
    }
  }

  savePost() async {
    if (inputHouse.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A casa é obrigatória!');
      return;
    } else if (inputContact.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O contato é obrigatório!');
      return;
    } else if (inputSituation.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A situação obrigatória!');
      return;
    } else if (inputValue.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O valor é obrigatório!');
      return;
    }

    isLoading = true;

    PostModel post = PostModel(
      house: casa.value,
      contact: inputContact.text,
      obs: inputObs.text,
      situation: inputSituation.text,
      value: double.tryParse(inputValue.text) ?? 0.0,
    );
    await postRepository.setPost(post);
    isLoading = false;
    Get.back();
    showMessageBar('Sucesso!', 'Postagem realizada com sucesso!');

  }

  selectHouse(BuildContext context) {
    final houseController = Get.find<HouseController>();
    listaCasasDisponiveis = houseController.lista;
    showModalBottomSheet(
      backgroundColor: brownColorTwo,
      context: Get.context!,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: brownColorTwo,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 32,
                ),
                child: Text(
                  'Aqui você pode selecionar a casa para postagem.',
                  style: TextStyle(color: goldColorThree),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Text(
                  'Escolha uma:',
                  style: TextStyle(fontSize: 22, color: goldColorThree),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: goldColorThree),
                  itemCount: listaCasasDisponiveis.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final HouseModel house = listaCasasDisponiveis[index];
                    return ListTile(
                      leading: Icon(
                        Icons.business_sharp,
                        color: goldColorThree,
                      ),
                      title: Text(
                        house.numeroCasa!,
                        style: TextStyle(color: goldColorThree),
                      ),
                      subtitle: Text(
                        house.logradouro!,
                        style: TextStyle(color: goldColorThree),
                      ),
                      onTap: () async {
                        casa.value = house;
                        inputHouse.text = house.numeroCasa!;
                        Get.back();
                        showMessageBar(
                          'Sucesso',
                          'Casa selecionada com sucesso!',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
