import 'package:aluga_facil/app/controllers/dashboard_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends GetView<DashboardPageController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Painel de Controle',
                style: TextStyle(
                  color: brownColorTwo,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pagamentos',
                  style: TextStyle(
                    color: brownColorTwo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.getCurrentMonthNamePtBr(),
                  style: TextStyle(
                    color: brownColorTwo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                elevation: 8,
                color: brownColorTwo,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recebidos',
                            style: TextStyle(
                              color: goldColorThree,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
                            color: goldColorThree,
                            size: 40,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Text(
                              // 'R\$ ${controller.totalPendingPayments.value.toStringAsFixed(2)}',
                              'R\$ ${controller.totalPaymentsReceivedAmout.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: goldColorThree,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                          Obx(() {
                            return Text(
                              'Total: ${controller.totalPaymentsReceivedNumber.value}',
                              style: TextStyle(
                                color: goldColorThree,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                elevation: 8,
                color: goldColorThree,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pendentes',
                            style: TextStyle(
                              color: brownColorTwo,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.monetization_on_outlined,
                            color: brownColorTwo,
                            size: 40,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // 'R\$ ${controller.totalPendingPayments.value.toStringAsFixed(2)}',
                              'R\$${controller.totalPaymentsPendingAmout.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: brownColorTwo,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              // 'R\$ ${controller.totalPendingPayments.value.toStringAsFixed(2)}',
                              'Total: ${controller.totalPaymentsPendingNumber.value}',
                              style: TextStyle(
                                color: brownColorTwo,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() {
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(color: goldColorThree),
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: MajorGridLines(
                    width: 1,
                    color: goldColorThree,
                  ),
                  majorTickLines: MajorTickLines(
                    width: 1,
                    color: goldColorThree,
                  ),
                  labelStyle: TextStyle(color: goldColorThree),
                  interval: 20,
                ),
                // Chart title
                title: ChartTitle(
                  text: 'Pagamentos por Mês',
                  textStyle: TextStyle(
                    color: goldColorThree,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                plotAreaBorderColor: goldColorThree,
                plotAreaBorderWidth: 1,
                legend: Legend(
                  isVisible: true,
                  textStyle: TextStyle(color: goldColorThree),
                ),
                tooltipBehavior: controller.tooltipBehavior,
                borderColor: goldColorThree,
                borderWidth: 2,
                palette: [goldColorThree, brownColorTwo],
                backgroundColor: brownColorTwo,
                series: <LineSeries<dynamic, String>>[
                  LineSeries<dynamic, String>(
                    name: 'Quantidade de Pagamentos',
                    // ignore: invalid_use_of_protected_member
                    dataSource: controller.listPaymentsData.value,
                    xValueMapper: (dynamic sales, _) => sales.month,
                    yValueMapper: (dynamic sales, _) => sales.amount,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              );
            }),
          ),
          SizedBox(height: 10),
          Obx(() {
            return controller.listPaymentsTypeData.isEmpty
                ? Center(
                    child: Text(
                      'Nenhum dado disponível',
                      style: TextStyle(
                        color: goldColorThree,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : SfCircularChart(
                    title: ChartTitle(
                      text: 'Pagamentos por Tipo (Mensal)',
                      textStyle: TextStyle(
                        color: brownColorTwo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.right,
                      textStyle: TextStyle(color: brownColorTwo),
                    ),
                    palette: [
                      goldColorOne,
                      goldColorTwo,
                      goldColorThree,
                      goldToBrownColor,
                      brownColorOne,
                      brownColorTwo,
                      brownColor,
                      Colors.amber,
                    ],
                    tooltipBehavior: controller.tooltipBehavior,
                    series: [
                      PieSeries<dynamic, String>(
                        // ignore: invalid_use_of_protected_member
                        dataSource: controller.listPaymentsTypeData.value,
                        xValueMapper: (dynamic data, _) => data.type,
                        yValueMapper: (dynamic data, _) => data.amount,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        explode: true,
                        explodeIndex: 0,
                      ),
                    ],
                  );
          }),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Imóveis e Inquilinos',
              style: TextStyle(
                color: brownColorTwo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: Get.width * 0.4,
              child: Card(
                elevation: 8,
                color: brownColorTwo,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(Icons.home, color: goldColorThree, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Imóveis',
                            style: TextStyle(
                              color: goldColorThree,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.totalHousesAvailable.value
                                      .toString(),
                                  style: TextStyle(
                                    color: goldColorThree,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Disponíveis',
                                  style: TextStyle(
                                    color: goldColorThree,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.totalHousesRented.value.toString(),
                                  style: TextStyle(
                                    color: goldColorThree,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Alugados',
                                  style: TextStyle(
                                    color: goldColorThree,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: Get.width * 0.4,
              child: Card(
                elevation: 8,
                color: goldColorThree,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(Icons.person, color: brownColorTwo, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Inquilinos',
                            style: TextStyle(
                              color: brownColorTwo,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.totalTenantsUpToDate.value
                                      .toString(),
                                  style: TextStyle(
                                    color: brownColorTwo,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Em dia',
                                  style: TextStyle(
                                    color: brownColorTwo,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.totalTenantsOwing.value.toString(),
                                  style: TextStyle(
                                    color: brownColorTwo,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Devendo',
                                  style: TextStyle(
                                    color: brownColorTwo,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
