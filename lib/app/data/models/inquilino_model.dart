class InquilinoModel {
  String? nome;
  String? celular;
  String? telefone;
  String? email;
  String? cpf;
  DateTime? dataNascimento;
  String? casaNumero;
  String? casaId;

  InquilinoModel({
    this.nome,
    this.celular,
    this.telefone,
    this.email,
    this.cpf,
    this.dataNascimento,
    this.casaNumero,
    this.casaId
});

  factory InquilinoModel.fromJson(Map<String, dynamic> json) {
    return InquilinoModel(
      nome: json['nome'],
      celular: json['celular'],
      telefone: json['telefone'],
      email: json['email'],
      cpf: json['cpf'],
      dataNascimento: json['dataNascimento'],
      casaNumero: json['casaNumero'],
      casaId: json['casaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'celular': celular,
      'telefone': telefone,
      'email': email,
      'cpf': cpf,
      'casaNumero': casaNumero,
      'casaId': casaId,
      'dataNascimento': dataNascimento?.toIso8601String(),
    };
  }
}
