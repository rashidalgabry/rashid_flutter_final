import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  Future _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      phone TEXT NOT NULL
    )
  ''');

  await db.execute('''
    CREATE TABLE recents (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      phone TEXT NOT NULL,
      time TEXT NOT NULL
    )
  ''');
}
// INSERT recent call
Future<int> insertRecent(String phone) async {
  final db = await instance.database;
  return await db.insert('recents', {
    'phone': phone,
    'time': DateTime.now().toString(),
  });
}

// SELECT recents
Future<List<Map<String, dynamic>>> getRecents() async {
  final db = await instance.database;
  return await db.query(
    'recents',
    orderBy: 'id DESC',
  );
}


  // INSERT
  Future<int> insertContact(Contact contact) async {
    final db = await instance.database;
    return await db.insert('contacts', contact.toMap());
  }

  // SELECT
  Future<List<Contact>> getAllContacts() async {
    final db = await instance.database;
    final result = await db.query('contacts');
    return result.map((e) => Contact.fromMap(e)).toList();
  }

  // UPDATE
  Future<int> updateContact(Contact contact) async {
    final db = await instance.database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  // DELETE
  Future<int> deleteContact(int id) async {
    final db = await instance.database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
}
