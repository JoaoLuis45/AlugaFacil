// import 'dart:io';

import 'package:aluga_facil/app/data/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FlutterFireAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  createUserWithEmailAndPassword(
    String name,
    String email,
    String pass,
    // File? avatar,
  ) async {
    
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      await credential.user?.updateDisplayName(name);

      return UserDataModel(email: email, name: name,id: credential.user?.uid);
    
  }

  signInWithEmailAndPassword(String email, String password) async {
    
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserDataModel(
        name: credential.user?.displayName,
        email: credential.user?.email,
        avatar: credential.user?.photoURL,
        id: credential.user?.uid
      );
  }

  Future<void> deleteAccount() async {
    try{
      await _auth.currentUser!.delete();
    } catch (e) {
      throw Exception('Erro ao deletar conta: $e');
    }
  }

  UserDataModel? getLoggedUser() {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }

    return UserDataModel(
      avatar: user.photoURL,
      name: user.displayName,
      email: user.email,
      id: user.uid
    );
  }

  signOut() async {
    await _auth.signOut();
  }
}
