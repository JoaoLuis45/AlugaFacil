import 'package:aluga_facil/app/Exceptions/invalid_date_aluguel.dart';
import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/providers/payment_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HouseDetailsPageController extends GetxController {
  final casa = HouseModel().obs;

  TextEditingController inputNumeroCasa = TextEditingController();
  TextEditingController inputLogradouro = TextEditingController();
  TextEditingController inputBairro = TextEditingController();
  TextEditingController inputCidade = TextEditingController();
  TextEditingController inputvalorAluguel = TextEditingController();
  TextEditingController inputDataAluguel = TextEditingController();

  final InquilinoRepository inquilinoRepository = InquilinoRepository(
    InquilinoProvider(),
  );

  final HouseRepository houseRepository = HouseRepository(HouseProvider());
  final PaymentRepository paymentRepository = PaymentRepository(
    PaymentProvider(),
  );

  final inquilino = InquilinoModel().obs;

  final isLoadingInquilino = false.obs;

  late List<dynamic> listaInquilinosDisponiveis;

  final listPayments = [].obs;

  @override
  void onInit() async {
    super.onInit();
    casa.value = Get.arguments;
    getDetailsHouse();
    await getInquilino();
    await getPayments();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<HouseDetailsPageController>();
  }

  getInquilino() async {
    if (casa.value.inquilino != null) {
      isLoadingInquilino.value = true;
      inquilino.value =
          await inquilinoRepository.getInquilino(casa.value.inquilino) ??
          InquilinoModel();
      isLoadingInquilino.value = false;
    }
  }

  getDetailsHouse() {
    inputNumeroCasa.text = casa.value.numeroCasa ?? '';
    inputLogradouro.text = casa.value.logradouro ?? '';
    inputBairro.text = casa.value.bairro ?? '';
    inputCidade.text = casa.value.cidade ?? '';
    inputvalorAluguel.text = casa.value.valorAluguel?.toString() ?? '';
    if (casa.value.dataAluguel != null) {
      inputDataAluguel.text =
          '${casa.value.dataAluguel!.day.toString()} de todo mês';
    } else {
      inputDataAluguel.text = '';
    }
    casa.update((a){});
  }

  getPayments() async {
    listPayments.value =
        await paymentRepository.getPaymentsByHouseAndInquilino(
          casa.value,
          inquilino.value,
        ) ??
        [];
  }

  selectInquilino(BuildContext context) {
    final inquilinoController = Get.find<InquilinoPageController>();
    listaInquilinosDisponiveis = inquilinoController.lista
        .where((e) => e!.casaId == null)
        .toList();
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
                  'Aqui você pode vincular um inquilino a essa casa.',
                  style: TextStyle(color: goldColorThree),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Text(
                  'Escolha um:',
                  style: TextStyle(fontSize: 22, color: goldColorThree),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: goldColorThree),
                  itemCount: listaInquilinosDisponiveis.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final InquilinoModel inquilino =
                        listaInquilinosDisponiveis[index];
                    return ListTile(
                      leading: Icon(
                        Icons.business_sharp,
                        color: goldColorThree,
                      ),
                      title: Text(
                        inquilino.cpf!,
                        style: TextStyle(color: goldColorThree),
                      ),
                      subtitle: Text(
                        inquilino.nome!,
                        style: TextStyle(color: goldColorThree),
                      ),
                      onTap: () async {
                        try {
                          casa.value.inquilino = inquilino.cpf;
                          inquilino.casaId = casa.value.id;
                          inquilino.casaNumero = casa.value.numeroCasa;
                          await houseRepository.setInquilino(casa.value);
                          await inquilinoRepository.setCasa(inquilino);
                          getDetailsHouse();
                          await getInquilino();
                          await getPayments();
                          Get.back();
                          showMessageBar(
                            'Sucesso',
                            'Inquilino vinculado à casa!',
                          );
                        } on InvalidDateAluguel {
                          showMessageBar(
                            'Erro',
                            'Selecione uma data válida para o aluguel.',
                          );
                        } catch (e) {
                          showMessageBar(
                            'Erro',
                            'Ocorreu um erro ao vincular inquilino.',
                          );
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
