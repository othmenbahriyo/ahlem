import 'dart:async';
import 'package:flutter_application_1/data/local/db/annonces_database.dart';
import 'package:flutter_application_1/data/local/models/annonce.dart';

class TaskDatabaseHelper  {
  DB database = DB();
  String nameTable = 'annonces';
  String colId = 'id';

  TaskDatabaseHelper._createInstance();

  static TaskDatabaseHelper _databaseHelper = TaskDatabaseHelper._createInstance();

  factory TaskDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = TaskDatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  @override
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    var db = await database.database;
    var result = await db!.query(nameTable);
    return result;
  }

  @override
  Future<int> insert(note) async {
    var db = await database.database;
    var result = await db!.insert(nameTable, note);
    return result;
  }

  Future<int> update(note, int id) async {
    var db = await database.database;
    var result = await db!.update(nameTable, note, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<List<Annonce>> getNotsync() async {
    var noteMapList = await getNoteMapList();
    var count = noteMapList.length;
    var noteList = <Annonce>[];
    for (var i = 0; i < count; i++) {
      if (noteMapList[i]['issync'] == 'false') {
        noteList.add(Annonce.fromJson(noteMapList[i]));
      }
    }

    return noteList;
  }

  Future<int> delete(int id) async {
    var db = await database.database;
    var result =
    await db!.rawDelete('DELETE FROM $nameTable WHERE $colId = $id');
    return result;
  }


  Future<List> getALLAnnonce() async {
    var db = await database.database;
    var result = await db!.rawQuery("SELECT * FROM $nameTable");
    return result;
  }

  Future<List> getALLIdNote() async {
    var db = await database.database;
    var result = await db!.rawQuery("SELECT idTaskSync FROM $nameTable WHERE idTaskSync IS NOT NULL ORDER BY rank DESC ");
    print('xxxxxxxxxxxxxxxxxxxx$result');
    return result;
  }

  Future<List> getNotSync() async {
    var db = await database.database;
    var result = await db!.rawQuery("SELECT * FROM $nameTable WHERE isSync ='0'");

    print("wwwwwwwwwwwwwwwwwwww$result");
    return result;
  }

  Future<List> getUpdated() async {
    var db = await database.database;
    var result = await db!.rawQuery("SELECT * FROM $nameTable WHERE isSync ='1' and idTaskSync IS NOT NULL");
    print("wwwwwwwwwwwwwwwwwwww$result");
    return result;
  }

  Future<List> getNotSyncForDelete() async {
    var db = await database.database;
    var result = await db!.rawQuery("SELECT id FROM $nameTable WHERE isSync = '1' and idTaskSync IS NOT NULL ");
    print("wwwwwwwwwwwwwwwwwwww$result");
    return result;
  }


}
