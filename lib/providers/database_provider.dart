import 'dart:io';

import 'package:avisos_admin/models/aviso_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database _database;
  static final DbProvider db = DbProvider._();
  DbProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB()async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'avisos.db');
    return await openDatabase(path, version: 1, onOpen: (db){},onCreate: (Database db, int version)async{
      await db.execute('CREATE TABLE avisos(idAviso INTEGER PRIMARY KEY, img TEXT,usrId TEXT, titulo TEXT, descripcion TEXT, fechaFin TEXT, fechaAlta TEXT, prioridad INTEGER)');
    });
  }
  getAvisos()async{
    final db = await database;
    final res = await db.query('avisos');
    return res.isNotEmpty? res.map((aviso)=>AvisoModel.fromJson(aviso)).toList(): [];
  }
  insertAviso ( AvisoModel model )async{
    final db = await database;
    final res = await db.insert('avisos', model.toJson());
    return res;
  }
  deleteAviso( int id )async{
    final db = await database;
    final res = await db.delete('avisos', where: 'idAviso = ?' ,whereArgs: [id]);
    return res;
  }
  updateAviso ( AvisoModel model ) async{
    final db = await database;
    final res = await db.update('avisos', model.toJson(),where: 'idAviso = ?', whereArgs: [model.idAviso]);
    return res;
  }
  deleteAllAvisos()async{
    final db = await database;
    final res = await db.rawDelete('delete from avisos');
    return res;
  }
}