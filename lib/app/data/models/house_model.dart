class HouseModel {
  String? logradouro;
  String? numeroCasa;
  String? fotoCasa;
  double? valorAluguel;
  int? id;
  DateTime? dataAluguel;
  String? inquilino;

  HouseModel({
    this.logradouro,
    this.numeroCasa,
    this.fotoCasa,
    this.valorAluguel,
    this.id,
    this.dataAluguel,
    this.inquilino,
    });

    factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      logradouro: json['logradouro'],
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
      'numeroCasa': numeroCasa,
      'fotoCasa': fotoCasa,
      'valorAluguel': valorAluguel,
      'id': id,
      'dataAluguel': dataAluguel?.toIso8601String(),
      'inquilino': inquilino,
    };
    }
}
