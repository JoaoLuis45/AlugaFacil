import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';

class InquilinoRepository {
  final InquilinoProvider inquilinoProvider;

  InquilinoRepository(this.inquilinoProvider);

  Future<void> save(InquilinoModel inquilino) {
    return inquilinoProvider.save(inquilino);
  }

  Future<void> remove(InquilinoModel inquilino) {
    return inquilinoProvider.remove(inquilino);
  }

  Future<void> read() {
    return inquilinoProvider.read();
  }

  Future<InquilinoModel?> getInquilino(cpf) {
    return inquilinoProvider.getInquilino(cpf);
  }

  Future<void> setCasa(InquilinoModel inquilino) {
    return inquilinoProvider.setCasa(inquilino);
  }

  Future<void> unsetCasa(InquilinoModel inquilino) {
    return inquilinoProvider.unsetCasa(inquilino);
  }
}
