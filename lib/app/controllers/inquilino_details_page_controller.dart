import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquilinoDetailsPageController extends GetxController {
  final inquilino = InquilinoModel().obs;

  TextEditingController inputNome = TextEditingController();
  TextEditingController inputCpf = TextEditingController();
  TextEditingController inputCelular = TextEditingController();
  TextEditingController inputTelefone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputDataNascimento = TextEditingController();

  final InquilinoRepository inquilinoRepository = InquilinoRepository(
    InquilinoProvider(),
  );

  final HouseRepository houseRepository = HouseRepository(HouseProvider());

  @override
  void onInit() {
    super.onInit();
    inquilino.value = Get.arguments;
    getDetailsInquilino();
  }

  getDetailsInquilino() {
    inputNome.text = inquilino.value.nome ?? '';
    inputCpf.text = inquilino.value.cpf ?? '';
    inputCelular.text = inquilino.value.celular ?? '';
    inputTelefone.text = inquilino.value.telefone ?? '';
    inputEmail.text = inquilino.value.email ?? '';
    inputDataNascimento.text = inquilino.value.dataNascimento == null
        ? ''
        : formatDate(inquilino.value.dataNascimento);
  }

  selectHouse(BuildContext context) {
    final houseController = Get.find<HouseController>();
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
                  'Aqui você pode vincular uma casa a esse inquilino.',
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
                  itemCount: houseController.lista.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final HouseModel house = houseController.lista[index];
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
                        inquilino.update((val) {
                          val!.casaId = house.id;
                          val.casaNumero = house.numeroCasa;
                        });
                        await inquilinoRepository.setCasa(inquilino.value);
                        house.inquilino = inquilino.value.cpf;
                        await houseRepository.setInquilino(house);
                        Get.back();
                        showMessageBar('Sucesso', 'Casa vinculada ao inquilino!');
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
