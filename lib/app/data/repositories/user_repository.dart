import 'package:aluga_facil/app/data/models/user_data_model.dart';
import 'package:aluga_facil/app/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider provider;

  UserRepository(this.provider);

  Future<UserDataModel?> login(email, password) {
    return provider.login(email, password);
  }

  Future<UserDataModel?> signUp(email, password, name) {
    return provider.signup(email, password, name);
  }

  getUserData() {
    return provider.getUserData();
  }

  deleteUserAccount() {
    provider.deleteUserAccount();
  }

  logout() {
    provider.signOutUser();
  }
}
