import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class FinanceiroPage extends GetView<FinanceiroPageController> {
  const FinanceiroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Financeiro Page'),
    );
  }
}