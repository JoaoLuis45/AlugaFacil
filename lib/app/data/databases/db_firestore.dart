import 'package:cloud_firestore/cloud_firestore.dart';

class DbFirestore {
  DbFirestore._();
  static final DbFirestore _istance = DbFirestore._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseFirestore get() {
    return DbFirestore._istance._firestore;
  }
}
