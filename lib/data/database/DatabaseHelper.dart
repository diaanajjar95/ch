import 'dart:async';
import 'dart:io';
import 'package:ch/data/models/user_response.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // const
  static const int _DB_VERSION = 1;
  static const String _DB_NAME = "coffeehousedb.db";
  static const String TAG = "DatabaseHelper";

  // users table constants
  static const String USERS_TABLE_NAME = "users";
  static const String USERS_TABLE_COLUMN_ID = "Id";
  static const String USERS_TABLE_COLUMN_ACCESS_TOKEN = "AccessToken";
  static const String USERS_TABLE_COLUMN_FCM = "FireBaseAccessToken";
  static const String USERS_TABLE_COLUMN_NAME = "Name";
  static const String USERS_TABLE_COLUMN_PHONE_NUMBER = "PhoneNumber";
  static const String USERS_TABLE_COLUMN_EMAIL = "Email";
  static const String USERS_TABLE_COLUMN_WALET = "Walet";
  static const String USERS_TABLE_COLUMN_POINTS = "Points";

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    print("$TAG : get db");
    if (_db != null) {
      print("$TAG : db already created then only return it");
      return _db;
    }
    print("$TAG : we need to create db");
    _db = await initDb();
    return _db;
  }

  initDb() async {
    print("$TAG : initDb");
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _DB_NAME);
    return await openDatabase(path, version: _DB_VERSION, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    print("$TAG : _onCreate");
    // create users table
    await db.execute(
        "CREATE TABLE $USERS_TABLE_NAME($USERS_TABLE_COLUMN_ID TEXT PRIMARY KEY, $USERS_TABLE_COLUMN_ACCESS_TOKEN TEXT, $USERS_TABLE_COLUMN_NAME TEXT, $USERS_TABLE_COLUMN_FCM TEXT, $USERS_TABLE_COLUMN_EMAIL TEXT, $USERS_TABLE_COLUMN_PHONE_NUMBER INTEGER, $USERS_TABLE_COLUMN_POINTS INTEGER, $USERS_TABLE_COLUMN_WALET REAL)");
  }

  // Users table CRUD functions
  Future<int> saveUser(User user) async {
    print("$TAG : saveUser Fired");
    var dbClient = await db;
    int result = await dbClient.insert(USERS_TABLE_NAME, user.toJson());
    return result;
  }

  Future<bool> isLoggedInUser() async {
    var dbClient = await db;
    var usersList = await dbClient.rawQuery("SELECT * FROM $USERS_TABLE_NAME");
    return usersList.length > 0 ? true : false;
  }

  Future<List> getAllUsers() async {
    print("$TAG : getAllUsers Fired");
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $USERS_TABLE_NAME");
    return result.toList();
  }

  Future<User> getUserById(String userId) async {
    print("$TAG : getUserById Fired");
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $USERS_TABLE_NAME WHERE $USERS_TABLE_COLUMN_ID = $userId");
    if (result.length == 0) {
      return null;
    } else {
      return User.fromJson(result.first);
    }
  }

  Future<int> deleteUser() async {
    print("$TAG : deleteUser Fired");
    var dbClient = await db;
    return await dbClient.delete(USERS_TABLE_NAME);
  }

  Future<int> updateUser(User user) async {
    print("$TAG : updateUser Fired");
    var dbClient = await db;
    return await dbClient.update(USERS_TABLE_NAME, user.toJson(),
        where: "$USERS_TABLE_COLUMN_ID = ?", whereArgs: [user.id]);
  }

  Future close() async {
    print("$TAG : close Fired");
    var dbClient = await db;
    return dbClient.close();
  }
}
