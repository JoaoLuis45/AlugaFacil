import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';

class HouseRepository {
  final HouseProvider houseProvider;

  HouseRepository(this.houseProvider);

  Future<void> save(HouseModel casa) {
    return houseProvider.save(casa);
  }

  Future<void> remove(HouseModel casa) {
    return houseProvider.remove(casa);
  }

  Future<void> read() {
    return houseProvider.read();
  }
}
