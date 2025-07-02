import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HouseController extends GetxController {
  final lista = [].obs;

  final isLoading = false.obs;

  final HouseRepository houseRepository;

  HouseController(this.houseRepository);

  TextEditingController searchController = TextEditingController();
}
