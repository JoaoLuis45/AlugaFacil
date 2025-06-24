import 'package:get/get.dart';

class InputFormFieldController extends GetxController {
  final RxBool _isVisible = false.obs;
  get isVisible => _isVisible.value;
  set isVisible(value) => _isVisible.value = value;
}
