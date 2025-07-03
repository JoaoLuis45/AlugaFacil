import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquilinoPageController extends GetxController{
  final lista = [].obs;

  final isLoading = false.obs;

  final InquilinoRepository inquilinoRepository;

  InquilinoPageController(this.inquilinoRepository);

  TextEditingController searchController = TextEditingController();
}