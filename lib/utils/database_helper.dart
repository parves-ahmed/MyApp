import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/loginDomain.dart';
// import 'dart:io';

class DatabaseHelper{
  static const _databaseName = 'testData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;

  Future<Database> get database async{
    if(_database!= null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  
  _initDatabase() async{
    // Directory dataDirectory = await getApplicationDocumentsDirectory(); 
    String dbPath = join(await getDatabasesPath(),_databaseName);
    return await openDatabase(dbPath, version:_databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async{
    await db.execute('''
    CREATE TABLE users(
      ${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${User.colName} TEXT NOT NULL,
      ${User.colPassword} TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertUser(User user) async{
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> fetchUser() async{
    Database db = await database;
    List<Map> users =  await db.query('users');
    return users.length == 0 ? [] : users.map((e)=>User.fromMap(e)).toList();
  }

  Future<List> fetchUserByNameAndPassword(String user, String password) async{
    Database db = await database;
    List<Map> users = await db.rawQuery('select id from users where name = ? and password = ?',[user, password]);
    return users.length == 0 ? [] : users.map((e)=>User.fromMap(e)).toList();
  }
}