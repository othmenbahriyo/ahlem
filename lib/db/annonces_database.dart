import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/data/local/dao/annonce_doa/annonce_dao.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class AnnoncesDatabase {
  static final AnnoncesDatabase instance = AnnoncesDatabase._init();
  static Database? _database;
  AnnoncesDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('annonces.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final etatType = 'ETAT NOT NULL';
    final StringType = 'STRING NOT NULL';
    final DateTimeType = 'DATE TIME NOT NULL';
    final integerType = 'INTEGER NOT NULL';





    await db.execute('''
CREATE TABLE $tableAnnonces (
  ${AnnonceFields.id} $idType, 
  ${AnnonceFields.etat} $etatType,
  ${AnnonceFields.localisation} $StringType,
  ${AnnonceFields.temps} $DateTimeType,
  ${AnnonceFields.details} $StringType,
  ${AnnonceFields.nombre} $integerType,
  ${AnnonceFields.description} $StringType,
  ${AnnonceFields.imageUrl} $StringType,

  )
''');

  

  }
  Future<Annonce> create(Annonce annonce) async {
    final db = await instance.database;
    final json = annonce.toJson();
    final columns =
        '${AnnonceFields.etat}, ${AnnonceFields.localisation}, ${AnnonceFields.temps}, ${AnnonceFields.details}, ${AnnonceFields.nombre}, ${AnnonceFields.description}, ${AnnonceFields.imageUrl}';
    final values =
        '${json[AnnonceFields.etat]}, ${json[AnnonceFields.localisation]}, ${json[AnnonceFields.temps]}, ${json[AnnonceFields.details]},${json[AnnonceFields.nombre]},${json[AnnonceFields.description]}, ${json[AnnonceFields.imageUrl]}';
    final id = await db
        .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

   // final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    // id = await db.insert(tableAnnonces, annonce.toJson());
    return annonce.copy(id: id);
  }
  Future<Annonce> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAnnonces,
      columns: AnnonceFields.values,
      where: '${AnnonceFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Annonce.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Annonce>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${AnnonceFields.temps} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableAnnonces, orderBy: orderBy);

    return result.map((json) => Annonce.fromJson(json)).toList();
  }
  Future updateAnnonce(int id,Annonce annonce) async {
    TaskDatabaseHelper taskDatabaseHelper = TaskDatabaseHelper();
    try {
      await taskDatabaseHelper.update(annonce,id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteAnnonce(int id) async {
        TaskDatabaseHelper taskDatabaseHelper = TaskDatabaseHelper();

    try {
      await taskDatabaseHelper.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> update(Annonce annonce) async {
    final db = await instance.database;

    return db.update(
      tableAnnonces,
      annonce.toJson(),
      where: '${AnnonceFields.id} = ?',
      whereArgs: [annonce.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableAnnonces,
      where: '${AnnonceFields.id} = ?',
      whereArgs: [id],
    );
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }


}