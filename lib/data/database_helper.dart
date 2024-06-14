import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('finanzas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE compras(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        monto REAL NOT NULL,
        categoria TEXT NOT NULL,
        fecha TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE categorias(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL
      )
    ''');

    await db.insert('categorias', {'nombre': 'Comida'});
  }

  Future<int> insertCompra(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('compras', row);
  }

  Future<void> insertCategoria(Map<String, dynamic> row) async {
    final db = await instance.database;
    await db.insert('categorias', row);
  }

  Future<List<Map<String, dynamic>>> fetchCompras() async {
    final db = await instance.database;
    return await db.query('compras');
  }

  Future<List<String>> consultarDatos() async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('categorias', columns: ['nombre']);
    return List.generate(result.length, (index) => result[index]['nombre'] as String);
  }

  Future<int> updateCompra(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('compras', row, where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
