import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/data/enums/payment_form.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CreatePaymentPageController extends GetxController {
  TextEditingController inputCasaId = TextEditingController();
  TextEditingController inputInquilino = TextEditingController();
  TextEditingController inputFormaPagamento = TextEditingController();
  TextEditingController inputValor = TextEditingController();
  TextEditingController inputDataPagamento = TextEditingController();

  MultiSelectController<PaymentForm> multiController = MultiSelectController();

  final listaInquilinos = [].obs;
  final listaHouses = [].obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final PaymentRepository paymentRepository;

  String dataPagamento = '';
  String casaId = '';

  List<DropdownItem<PaymentForm>> paymentList = [];

  late List<dynamic> listaCasasDisponiveis;

  late List<dynamic> listaInquilinosDisponiveis;

  final isEditing = false.obs;
  final payment = PaymentModel().obs;

  CreatePaymentPageController(this.paymentRepository);

  @override
  void onInit() {
    super.onInit();
    getPaymentForms();
    if (Get.arguments.runtimeType == PaymentModel) editPayment();
    if (Get.arguments.runtimeType == HouseModel) setHouseAndInquilino();
  }

  setHouseAndInquilino() {
    final HouseModel casa = Get.arguments as HouseModel;
    inputCasaId.text = casa.numeroCasa!;
    casaId = casa.id!;
    inputInquilino.text = casa.inquilino!;
    inputValor.text = casa.valorAluguel.toString();
  }

  editPayment() async {
    if (Get.arguments != null) {
      payment.value = Get.arguments as PaymentModel;
      HouseRepository houseRepository = HouseRepository(HouseProvider());
      final HouseModel? casa = await houseRepository.getCasa(
        payment.value.casaId!,
      );
      inputCasaId.text = casa!.numeroCasa ?? '';
      casaId = casa.id ?? '';
      inputInquilino.text = payment.value.inquilino ?? '';
      inputFormaPagamento.text = payment.value.formaPagamento ?? '';
      multiController.selectWhere(
        (e) => e.value.name == payment.value.formaPagamento,
      );
      inputValor.text = payment.value.valor?.toString() ?? '';
      dataPagamento = payment.value.dataPagamento?.toString() ?? '';
      inputDataPagamento.text = formatDate(payment.value.dataPagamento);
      isEditing.value = true;
    } else {
      inputCasaId.clear();
      inputInquilino.clear();
      inputFormaPagamento.clear();
      inputValor.clear();
      dataPagamento = '';
      isEditing.value = false;
    }
  }

  getPaymentForms() {
    PaymentForm.values.forEach((element) {
      paymentList.add(
        DropdownItem<PaymentForm>(value: element, label: element.name),
      );
    });
  }

  savePayment() async {
    if (inputCasaId.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A casa do pagamento é obrigatória!');
      return;
    } else if (inputFormaPagamento.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A forma do pagamento é obrigatória!');
      return;
    } else if (inputValor.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O valor do pagamento é obrigatório!');
      return;
    } else if (inputDataPagamento.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A data do pagamento é obrigatória!');
      return;
    }
    isLoading = true;

    if (isEditing.value) {
      payment.value.casaId = casaId;
      payment.value.inquilino = inputInquilino.text;
      payment.value.formaPagamento = inputFormaPagamento.text;
      payment.value.valor = double.tryParse(inputValor.text);
      payment.value.dataPagamento = DateTime.parse(dataPagamento);
      await paymentRepository.update(payment.value);
      showMessageBar('Sucesso!', 'Pagamento editado com sucesso!');
    } else {
      PaymentModel payment = PaymentModel(
        casaId: casaId,
        inquilino: inputInquilino.text,
        formaPagamento: inputFormaPagamento.text,
        valor: double.tryParse(inputValor.text) ?? 0.0,
        dataPagamento: dataPagamento.isNotEmpty
            ? DateTime.parse(dataPagamento)
            : null,
      );
      await paymentRepository.save(payment);
      showMessageBar('Sucesso!', 'Novo pagamento realizado com sucesso!');
    }

    isLoading = false;

    paymentRepository.read();
    Get.offAllNamed('/home');
  }

  selectHouse(BuildContext context) {
    final houseController = Get.find<HouseController>();
    listaCasasDisponiveis = houseController.lista
        .where((e) => e!.inquilino != null)
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
                  'Aqui você pode selecionar uma casa para esse pagamento.',
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
                        inputCasaId.text = house.numeroCasa!;
                        casaId = house.id!;
                        inputInquilino.text = house.inquilino!;
                        Get.back();
                        showMessageBar('Sucesso', 'Casa selecionada!');
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
