import 'package:aluga_facil/app/controllers/dashboard_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DashboardPage extends GetView<DashboardPageController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Dashboard Page'),);
  }
}