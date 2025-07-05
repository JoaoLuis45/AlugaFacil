import 'package:aluga_facil/app/controllers/create_payment_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/controllers/input_form_field_controller.dart';
import 'package:aluga_facil/app/ui/widgets/input_form_field.dart';
import 'package:aluga_facil/app/utils/mask_formatters.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CreatePaymentPage extends GetView<CreatePaymentPageController> {
  CreatePaymentPage({super.key});
  final _dates = [DateTime.now()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: brownColorTwo,
          iconTheme: IconThemeData(color: goldColorThree),
          title: Text(
            'Criar Pagamento',
            style: TextStyle(fontSize: 20, color: goldColorThree),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [brownColorTwo, goldColorTwo],
              begin: AlignmentDirectional.bottomStart,
              end: AlignmentDirectional.topEnd,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 5),
                    Text(
                      'Informações do Pagamento',
                      style: TextStyle(
                        fontSize: 20,
                        color: goldColorThree,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    TextFormField(
                      controller: controller.inputCasaId,
                      onTap: () async {
                        controller.selectHouse(context);
                      },
                      readOnly: true,
                      style: const TextStyle(
                        color: goldColorTwo,
                        fontFamily: 'Raleway',
                      ),
                      decoration: InputDecoration(
                        fillColor: brownColorTwo,
                        filled: true,
                        labelText: 'Escolha a Casa',
                        labelStyle: TextStyle(color: goldColorTwo),
                        prefixIcon: Icon(
                          Icons.home_outlined,
                          color: goldColorTwo,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: goldColorTwo, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: goldColorTwo, width: 2),
                        ),
                      ),
                    ),
                    Spacer(),
                    TextFormField(
                      controller: controller.inputDataPagamento,
                      inputFormatters: [maskFormatterDate],
                      onTap: () async {
                        List<DateTime?>? results =
                            await showCalendarDatePicker2Dialog(
                              context: context,
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(),
                              dialogSize: const Size(325, 400),
                              value: _dates,
                              borderRadius: BorderRadius.circular(15),
                            );
                        if (results != null && results.isNotEmpty) {
                          controller.inputDataPagamento.text = formatDate(
                            results.first,
                          );
                          controller.dataPagamento = results.first.toString();
                        }
                      },
                      readOnly: true,
                      style: const TextStyle(
                        color: goldColorTwo,
                        fontFamily: 'Raleway',
                      ),
                      decoration: InputDecoration(
                        fillColor: brownColorTwo,
                        filled: true,
                        labelText: 'Data de Pagamento',
                        labelStyle: TextStyle(color: goldColorTwo),
                        prefixIcon: Icon(
                          Icons.today_outlined,
                          color: goldColorTwo,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: goldColorTwo, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: goldColorTwo, width: 2),
                        ),
                      ),
                    ),
                    Spacer(),
                    MultiDropdown(
                      controller: controller.multiController,
                      items: controller.paymentList,
                      onSelectionChange: (selectedItems) {
                        if (selectedItems.isNotEmpty) {
                          controller.inputFormaPagamento.text =
                              selectedItems.first.name;
                        } else {
                          controller.inputFormaPagamento.text = '';
                        }
                      },
                      singleSelect: true,
                      searchEnabled: false,
                      fieldDecoration: FieldDecoration(
                        labelText: 'Forma de Pagamento',
                        showClearIcon: false,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: goldColorTwo,
                        ),
                        hintStyle: TextStyle(color: goldColorTwo),
                        backgroundColor: brownColorTwo,
                        prefixIcon: Icon(
                          Icons.monetization_on_outlined,
                          color: goldColorTwo,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: goldColorTwo, width: 2),
                        ),
                        labelStyle: TextStyle(color: goldColorTwo),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: goldColorTwo, width: 2),
                        ),
                      ),
                      dropdownDecoration: DropdownDecoration(
                        backgroundColor: brownColorTwo,
                        elevation: 8,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      dropdownItemDecoration: DropdownItemDecoration(
                        textColor: goldColorTwo,
                        selectedTextColor: goldColorThree,
                        selectedBackgroundColor: brownColorOne,
                      ),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'valor',
                      iconImage: Icons.attach_money_sharp,
                      isPassword: false,
                      keyboardType: TextInputType.number,
                      textController: controller.inputValor,
                      title: 'Valor',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(flex: 3),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [goldToBrownColor, brownColorTwo],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Obx(() {
                        return TextButton(
                          onPressed: () {
                            controller.savePayment();
                          },
                          child: controller.isLoading
                              ? CircularProgressIndicator(color: goldColorOne)
                              : Text(
                                  controller.isEditing.value
                                      ? 'Editar Pagamento'
                                      : 'Criar Pagamento',
                                  style: TextStyle(
                                    color: goldColorThree,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                        );
                      }),
                    ),
                    Spacer(flex: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
