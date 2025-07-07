import 'package:firebase_database/firebase_database.dart';
class DbRealtime {
  DbRealtime._();
  static final DbRealtime _instance = DbRealtime._();
  final FirebaseDatabase _realtime = FirebaseDatabase.instance;

  static FirebaseDatabase get() {
    return _instance._realtime;
  }
}
