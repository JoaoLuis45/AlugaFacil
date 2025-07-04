import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FinanceiroPageController extends GetxController{
  final lista = [].obs;

  final isLoading = false.obs;

  final PaymentRepository paymentRepository;

  FinanceiroPageController(this.paymentRepository);

  TextEditingController searchController = TextEditingController();
}