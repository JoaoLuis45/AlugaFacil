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
}
