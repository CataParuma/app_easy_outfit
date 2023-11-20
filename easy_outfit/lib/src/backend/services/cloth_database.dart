import 'package:easy_outfit/src/backend/models/cloth_model.dart';
import 'package:easy_outfit/src/backend/models/outfit_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easy_outfit/src/backend/models/user_model.dart';

class ClothDatabase {
  static final ClothDatabase instance = ClothDatabase._init();

  static Database? _database;

  ClothDatabase._init();

  final String tableUsers = 'users';
  final String tableClothes = 'clothes';
  final String tableOutfits = 'outfits';
  final String nameDatabase = 'easyoutfit_data.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    debugPrint("entro a la db");

    _database = await _initDB(nameDatabase);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    debugPrint(path);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableUsers(
    name TEXT PRIMARY KEY,
    password TEXT,
    email TEXT,
    country TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE $tableClothes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    clothtype INTEGER,
    clothstyle TEXT,
    color TEXT,
    image TEXT,
    username TEXT,
    lastweekday INTEGER,
    lastweekyear INTEGER,
    timesused INTEGER
    )
    ''');
    await db.execute('''
    CREATE TABLE $tableOutfits(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    weekyear INTEGER,
    weekday INTEGER,
    shirtid INTEGER,
    pantsid INTEGER,
    shoesid INTEGER,
    username TEXT
    )
    ''');
  }

  //Users methods

  Future<void> createUser(User user) async {
    final db = await instance.database;
    await db.insert(tableUsers, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getAllUsers() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableUsers);

    return List.generate(maps.length, (i) {
      return User(
        name: maps[i]['name'],
        password: maps[i]['password'],
        email: maps[i]['email'],
        country: maps[i]['country'],
      );
    });
  }

  Future<User> getUserByName(String name) async {
    final db = await instance.database;
    

    final List<Map<String, dynamic>> maps =
        await db.query(tableUsers, where: 'name = ?', whereArgs: [name]);

    return User(
      name: maps[0]['name'],
      password: maps[0]['password'],
      email: maps[0]['email'],
      country: maps[0]['country'],
    );
  }

  Future<bool> existUserByName(String name) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query(tableUsers, where: 'name = ?', whereArgs: [name]);

    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> existUserByEmail(String email) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query(tableUsers, where: 'email = ?', whereArgs: [email]);

    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> deleteUser(String name) async {
    final db = await instance.database;
    return await db.delete(
      tableUsers,
      where: "name = ?",
      whereArgs: [name],
    );
  }

  Future<int> updateUser(User item) async {
    final db = await instance.database;
    return await db.update(
      tableUsers,
      item.toMap(),
      where: "name=?",
      whereArgs: [item.name],
    );
  }

   //Clothes methods

  Future<int> createCloth(Cloth cloth) async {

    
    final db = await instance.database;
    
    int result = await db.insert(tableClothes, cloth.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
        debugPrint("----------------------Add Cloth: ${result}");
    return result;
  }

  Future<List<Cloth>> clothListByUser(String username) async {
    final db = await instance.database;
    final List<Map<String, Object?>> queryResult = await db
        .query(tableClothes, where: 'username=?', whereArgs: [username]);
    return queryResult.map((e) => Cloth.fromMap(e)).toList();
  }

  Future<List<Cloth>> clothListByUserAndType(
      String username, int clothtype) async {

    
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableClothes,
        where: 'username=? and clothtype=?', whereArgs: [username, clothtype]);
       
     return List.generate(maps.length, (i) {
      debugPrint("entro: $i");
      return Cloth(
        id: maps[i]['id'],
        clothtype: maps[i]['clothtype'],
        clothstyle: maps[i]['clothstyle'],
        color: maps[i]['color'],
        image: maps[i]['image'],
        username: maps[i]['username'],
        lastweekday: maps[i]['lastweekday'],
        lastweekyear: maps[i]['lastweekyear'],
        timesused: maps[i]['timesused'],
      );
    });
  }

  Future<Cloth> getClothById(int id) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query(tableClothes, where: 'id=?', whereArgs: [id]);

    return Cloth(
        id: maps[0]['id'],
        clothtype: maps[0]['clothtype'],
        clothstyle: maps[0]['clothstyle'],
        color: maps[0]['color'],
        image: maps[0]['image'],
        username: maps[0]['username'],
        lastweekday: maps[0]['lastweekday'],
        lastweekyear: maps[0]['lastweekyear'],
        timesused: maps[0]['timesused']);
  }

  Future<int> deleteCloth(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableClothes,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateCloth(Cloth item) async {
    final db = await instance.database;
    return await db.update(
      tableClothes,
      item.toMap(),
      where: "id=?",
      whereArgs: [item.id],
    );
  }

   //Outfits methods

  Future<int> createOutfit(Outfit outfit) async {

    
    final db = await instance.database;
    
    int result = await db.insert(tableOutfits, outfit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
        debugPrint("----------------------Add Outfit: ${result}");
    return result;
  }

  Future<List<Outfit>> outfitListByUser(String username) async {
    final db = await instance.database;
    final List<Map<String, Object?>> queryResult = await db
        .query(tableOutfits, where: 'username=?', whereArgs: [username]);
    return queryResult.map((e) => Outfit.fromMap(e)).toList();
  }

 

  Future<Outfit> getOutfitById(int id) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query(tableOutfits, where: 'id=?', whereArgs: [id]);

    return Outfit(
        id: maps[0]['id'],
        weekyear: maps[0]['weekyear'],
        weekday: maps[0]['weekday'],
        shirtid: maps[0]['shirtid'],
        pantsid: maps[0]['pantsid'],
        shoesid: maps[0]['shoesid'],
        username: maps[0]['username']);
  }

  Future<Outfit> getOutfitByDate(String user, int weekyear, int weekday) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query(tableOutfits, where: 'username=? and weekyear=? and weekday=?', whereArgs: [user, weekyear, weekday]);
  if(maps.isEmpty){
    return Outfit(weekyear: -1, weekday: -1, shirtid: -1, pantsid: -1, shoesid: -1, username: user);
  }
    return Outfit(
        id: maps[0]['id'],
        weekyear: maps[0]['weekyear'],
        weekday: maps[0]['weekday'],
        shirtid: maps[0]['shirtid'],
        pantsid: maps[0]['pantsid'],
        shoesid: maps[0]['shoesid'],
        username: maps[0]['username']);
  }

  Future<int> deleteOutfit(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableOutfits,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateOutfit(Outfit item) async {
    final db = await instance.database;
    return await db.update(
      tableOutfits,
      item.toMap(),
      where: "id=?",
      whereArgs: [item.id],
    );
  }
}
