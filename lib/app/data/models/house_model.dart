import 'package:uuid/uuid.dart';

class HouseModel {
  String? logradouro;
  String? bairro;
  String? cidade;
  String? numeroCasa;
  String? fotoCasa;
  double? valorAluguel;
  String? id;
  DateTime? dataAluguel;
  String? inquilino;

  HouseModel({
    this.logradouro,
    this.bairro,
    this.cidade,
    this.numeroCasa,
    this.fotoCasa,
    this.valorAluguel,
    String? id,
    this.dataAluguel,
    this.inquilino,
    }) : id = id ?? const Uuid().v4();

    factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      numeroCasa: json['numeroCasa'],
      fotoCasa: json['fotoCasa'],
      valorAluguel: json['valorAluguel'],
      id: json['id'],
      dataAluguel: json['dataAluguel'],
      inquilino: json['inquilino'], 
    );
    }

    Map<String, dynamic> toJson() {
    return {
      'logradouro': logradouro,
      'bairro': bairro,
      'cidade': cidade,
      'numeroCasa': numeroCasa,
      'fotoCasa': fotoCasa,
      'valorAluguel': valorAluguel,
      'id': id,
      'dataAluguel': dataAluguel?.toIso8601String(),
      'inquilino': inquilino,
    };
    }
}
