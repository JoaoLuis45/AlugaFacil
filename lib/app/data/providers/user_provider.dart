import 'package:aluga_facil/app/data/models/user_data_model.dart';
import 'package:aluga_facil/app/data/services/flutter_fire_auth.dart';

class UserProvider extends FlutterFireAuth {
  Future<UserDataModel?> login(String email, String password) async {
    final user = await signInWithEmailAndPassword(email, password);
    return user;
  }

  Future<UserDataModel?> signup(
    String email,
    String password,
    String name,
  ) async {
    final user = await createUserWithEmailAndPassword(name, email, password);
    return user;
  }

  getUserData()  {
    final user = getLoggedUser();
    return user;
  }

  signOutUser() {
    signOut();
  }
}
