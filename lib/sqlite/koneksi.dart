import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'buku.dart'; // berisi class Saham

// $conn = mysqli_connect('localhost', 'root', '', 'perpustakaan')

Future<Database> openDb() async{
  final database = await openDatabase(
    join(await getDatabasesPath(), 'database_perpustakaan.db'),
    version: 4,
    onCreate: (db, version) async{
      db.execute('''
          CREATE TABLE saham (
            tickerid INTEGER PRIMARY KEY AUTOINCREMENT,
            ticker TEXT NOT NULL,
            open INTEGER,
            high INTEGER,
            last INTEGER,
            change REAL
          )
          ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async{
      if (oldVersion < 2) {
        db.execute('''
        CREATE TABLE penerbit (
          penerbitid INTEGER PRIMARY KEY AUTOINCREMENT,
          nama_penerbit TEXT NOT NULL,
          alamat TEXT NOT NULL
        )
        ''');
      }

      if (oldVersion < 3) {
        db.execute('''
        CREATE TABLE pengarang (
          pengarangid INTEGER PRIMARY KEY AUTOINCREMENT,
          nama_pengarang TEXT NOT NULL
        )
        ''');
      }

      // untuk Create table saham
      if (oldVersion < 4) {
        db.execute('''
        CREATE TABLE saham (
          tickerid INTEGER PRIMARY KEY AUTOINCREMENT,
          ticker TEXT NOT NULL,
          open INTEGER,
          high INTEGER,
          last INTEGER,
          change REAL
        )
        ''');
      }
    },
    onDowngrade: (db, oldVersion, newVersion) async{
      await db.execute('DROP TABLE IF EXISTS saham');
      await openDb();
    },
  );
  return database;
}

// class saham untuk tambah, seed, ambil semua
class SahamQueryHandler {
  Future<Database> database() async {
    return openDb();
  }

  Future<int> tambahSaham(String ticker, int open, int high, int last, double change) async {
    final db = await database();
    // INSERT INTO saham (ticker, open, high, last, change) VALUES (?, ?, ?, ?, ?)
    final id = await db.rawInsert(
      'INSERT INTO saham (ticker, open, high, last, change) VALUES (?, ?, ?, ?, ?)',
      [ticker, open, high, last, change],
    );
    return id;
  }

  Future<void> seedSaham() async {
    await tambahSaham('TLKM', 3380, 3500, 3490, 2.05);
    await tambahSaham('AMMN', 6750, 6750, 6500, -3.7);
    await tambahSaham('BREN', 4500, 4610, 4580, 1.78);
    await tambahSaham('CUAN', 5200, 5525, 5400, 3.85);
  }

  Future<List<Saham>> ambilSemuaSaham() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM saham');

    return List.generate(maps.length, (i) {
      return Saham.fromJson(maps[i]);
    });
  }
}
