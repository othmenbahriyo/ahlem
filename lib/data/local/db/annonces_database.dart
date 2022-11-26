import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB  {
  Database? _database ;
  static  DB db = DB._createInstance();

  DB._createInstance();
  factory DB() {
    if (db == null) {
      db = DB._createInstance();
    }
    return db;
  }

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'demo.db');
    var fideliteDatabase =
    await openDatabase(path, version: 8, onCreate: _createDB);
    return fideliteDatabase;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const etatType = 'TEXT NOT NULL';
    const StringType = 'TEXT NOT NULL';
    const BoolType = 'BOOLEAN';
    const DateTimeType = 'TEXT NOT NULL';
    const integerType = 'TEXT NOT NULL';

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
  ${AnnonceFields.isSync} $BoolType
  ${AnnonceFields.isUpdate} $BoolType
  )
''');
  }

}
