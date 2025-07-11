import 'package:aluga_facil/app/Exceptions/invalid_date_aluguel.dart';
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

  late List<dynamic> listaCasasDisponiveis;

  final casa = HouseModel().obs;

  @override
  void onInit() async{
    super.onInit();
    inquilino.value = Get.arguments;
    getDetailsInquilino();
    if(inquilino.value.casaId != null) {
      casa.value = (await houseRepository.getCasa(inquilino.value.casaId!))!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<InquilinoDetailsPageController>();
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
    listaCasasDisponiveis =
        houseController.lista.where((e) => e!.inquilino == null).toList();
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
                        try{
                          inquilino.update((val) {
                          val!.casaId = house.id;
                          val.casaNumero = house.numeroCasa;
                        });
                        house.inquilino = inquilino.value.cpf;
                        await houseRepository.setInquilino(house);
                        await inquilinoRepository.setCasa(inquilino.value);
                        Get.back();
                        showMessageBar('Sucesso', 'Casa vinculada ao inquilino!');
                        } on InvalidDateAluguel {
                          showMessageBar('Erro', 'Selecione uma data válida para o aluguel.');
                        } catch (e) {
                          showMessageBar('Erro', 'Ocorreu um erro ao vincular a casa.');
                        }
                       
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
