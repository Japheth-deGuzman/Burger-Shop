// import 'dart:io';
// import 'package:favorite/models/models.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class LocalDataBase {
//   LocalDataBase._privateConstrutor();
//   static final LocalDataBase instance = LocalDataBase._privateConstrutor();

//   static Database? _database;
//   Future<Database> get database async => _database ?? await _initDatabase();

//   Future<Database> _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, 'burger.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//    CREATE TABLE tblburgercart(
//     id INTEGER PRIMARY KEY,
//     name TEXT
//     )
//     ''');
//     await db.execute('''
//    CREATE TABLE tblburgerfav(
//     id INTEGER PRIMARY KEY,
//     name TEXT
//     )
//     ''');
//   }

// // Add To Cart Operation
//   Future<List<BurgerCart>> getburgercart() async {
//     Database db = await instance.database;
//     var bcart = await db.query('tblburgercart');
//     List<BurgerCart> burgercartlist = bcart.isNotEmpty
//         ? bcart.map((c) => BurgerCart.fromMap(c)).toList()
//         : [];
//     return burgercartlist;
//   }

//   Future<int> addburgertocart(BurgerCart burgercart) async {
//     Database db = await instance.database;
//     return await db.insert('tblburgercart', burgercart.toMap());
//   }

//   Future<int> removeburgertocart(String name) async {
//     Database db = await instance.database;
//     return await db
//         .delete('tblburgercart', where: 'name = ?', whereArgs: [name]);
//   }

// // Add To Fav Operation
//   Future<List<BurgerFav>> getburgerfav() async {
//     Database db = await instance.database;
//     var bcart = await db.query('tblburgerfav');
//     List<BurgerFav> burgercartlist =
//         bcart.isNotEmpty ? bcart.map((c) => BurgerFav.fromMap(c)).toList() : [];
//     return burgercartlist;
//   }

//   Future<int> addburgertofav(BurgerFav burgercart) async {
//     Database db = await instance.database;
//     return await db.insert('tblburgerfav', burgercart.toMap());
//   }

//   Future<int> removeburgertofav(int id) async {
//     Database db = await instance.database;
//     return await db.delete('tblburgerfav', where: 'id = ?', whereArgs: [id]);
//   }
// }
