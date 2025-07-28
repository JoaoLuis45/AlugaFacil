import 'package:aluga_facil/app/data/models/user_data_model.dart';
import 'package:aluga_facil/app/data/services/flutter_fire_auth.dart';

class UserProvider extends FlutterFireAuth {
  Future<UserDataModel?> login(String email, String password) async {
    return await signInWithEmailAndPassword(email, password);
  }

  Future<UserDataModel?> signup(
    String email,
    String password,
    String name,
  ) async {
    return await createUserWithEmailAndPassword(name, email, password);
  }

  getUserData()  {
    return getLoggedUser();
  }

   deleteUserAccount() async {
    UserDataModel? user = getUserData();
    if (user == null) {
      throw Exception('Usuário não encontrado');
    }
    return await deleteAccount();
  }

  signOutUser() {
    signOut();
  }
}
