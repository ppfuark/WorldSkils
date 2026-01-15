import 'package:auth_app/models/user.dart';
import 'package:auth_app/services/database_service.dart';

class UserWidgets {
  final DatabaseService _databaseService = DatabaseService.instance;

  Future<List<User>?> getUsers() async {
    final db = await _databaseService.database;
    final data = await db.query(_databaseService.userTableName);

    List<User> users = data
        .map(
          (e) => User(
            username: e['username'] as String,
            password: e['password'] as String,
          ),
        )
        .toList();
    return users;
  }

  void addUser(User user) async {
    final db = await _databaseService.database;

    await db.insert(_databaseService.userTableName, {
      _databaseService.userNameColumnName: user.password,
      _databaseService.userNameColumnName: user.username,
    });
  }

  // String hashPassword(String password){

  // }
}
