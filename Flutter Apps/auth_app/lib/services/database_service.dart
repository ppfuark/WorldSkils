import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {

  String _userTableName = "users";
  String _userNameColumnName  = "username";
  String _userPasswordColumnName = "password";

  get userTableName => _userTableName;

  set userTableName(final value) => _userTableName = value;

  get userNameColumnName => _userNameColumnName;

  set userNameColumnName( value) => _userNameColumnName = value;

  get userPasswordColumnName => _userPasswordColumnName;

  set userPasswordColumnName( value) => _userPasswordColumnName = value;

  static Database? _db;

  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "users.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) => {
        db.execute('''
          CREATE TABLE $_userTableName (
            $_userNameColumnName TEXT PRIMARY KEY UNIQUE NOT NULL,
            $_userPasswordColumnName TEXT NOT NULL,
          )
        ''')
      },
    );
    return database;
  }

  Future<Database> get database async{
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

}