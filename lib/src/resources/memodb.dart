import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../models/memomodel.dart';
import 'dart:async';

class MemoDbProvider{

  Future<Database> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path,"memos.db");

      return await openDatabase(
        path,
        version: 1,
        onCreate: (Database newDb,int version) async{
          await newDb.execute("""
          CREATE TABLE Memos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          content TEXT,
          date Text)"""
      );
    });
  }

  Future<int> addItem(MemoModel item) async{
    final db = await init();
    return db.insert("Memos", item.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<MemoModel>> fetchMemos() async{
    
    final db = await init();
    final maps = await db.query("Memos");

    return List.generate(maps.length, (i) {
      return MemoModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        date: maps[i]['date'],
      );
  });
  }

  Future<int> deleteMemo(int id) async{
    final db = await init();
    int result = await db.delete(
      "Memos",
      where: "id = ?",
      whereArgs: [id]
    );

    return result;
  }

  Future<int> updateMemo(int id, MemoModel item) async{
    final db = await init();
    int result = await db.update(
      "Memos", 
      item.toMap(),
      where: "id = ?",
      whereArgs: [id]
      );
      return result;
  }

}