class InquilinoModel {
  String? nome;
  String? celular;
  String? telefone;
  String? email;
  String? cpf;
  DateTime? dataNascimento;

  InquilinoModel(this.nome,this.celular,this.telefone,this.email,this.cpf,this.dataNascimento);

  factory InquilinoModel.fromJson(Map<String, dynamic> json) {
    return InquilinoModel(
      json['nome'],
      json['celular'],
      json['telefone'],
      json['email'],
      json['cpf'],
      json['dataNascimento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'celular': celular,
      'telefone': telefone,
      'email': email,
      'cpf': cpf,
      'dataNascimento': dataNascimento?.toIso8601String(),
    };
  }
}
