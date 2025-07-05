import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PaymentModel extends GetxController{
  String? casaId;
  String? inquilino;
  String? formaPagamento;
  double? valor;
  String? id;
  DateTime? dataPagamento;
  final isExpanded = false.obs;

  PaymentModel({
    this.casaId,
    this.inquilino,
    this.formaPagamento,
    this.valor,
    this.dataPagamento,
    String? id,
  }) : id = id ?? const Uuid().v4();

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      casaId: json['casaId'],
      inquilino: json['inquilino'],
      formaPagamento: json['formaPagamento'],
      valor: json['valor'],
      id: json['id'],
      dataPagamento: json['dataPagamento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'casaId': casaId,
      'inquilino': inquilino,
      'formaPagamento': formaPagamento,
      'valor': valor,
      'id': id,
      'dataPagamento': dataPagamento?.toIso8601String(),
    };
  }
}
