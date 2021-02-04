import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tasks_app/exceptions/user_not_exist_exception.dart';

final _database = FirebaseDatabase.instance;
final _auth = FirebaseAuth.instance;

class ApiProvider {
  User _user;
  DatabaseReference _dbRef;

  ApiProvider() {
    _user = getUser();
    _dbRef = getDbRef();
  }

  User get user => _user;

  DatabaseReference get dbRef => _dbRef;

  static User getUser() {
    final user = _auth.currentUser;

    if (user == null) throw UserNotExistException();

    return user;
  }

  static DatabaseReference getDbRef() {
    return _database.reference();
  }
}
