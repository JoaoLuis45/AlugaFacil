// import 'dart:io';

import 'package:aluga_facil/app/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class FlutterFireAuth {
  FlutterFireAuth(this._context);

  final BuildContext _context;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  createUserWithEmailAndPassword(
    String name,
    String email,
    String pass,
    // File? avatar,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      await credential.user?.updateDisplayName(name);

      return {
        'user': UserDataModel(email: email, name: name),
        'credential': credential,
      };
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Ocorreu um erro desconhecido!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        _context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {
        'user': UserDataModel(
          name: credential.user?.displayName,
          email: credential.user?.email,
          avatar: credential.user?.photoURL,
        ),
        'credential': credential,
      };
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Ocorreu um erro desconhecido!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        _context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return null;
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
    );
  }

  signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/');
  }
}
