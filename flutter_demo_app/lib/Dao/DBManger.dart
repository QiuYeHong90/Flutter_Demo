import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBManger{
  /// 数据库版本号
  static const _VERSION = 1;
  static const _DB_NAME = "BWL.db";
  /// 数据库实例
  static  Database _DBA;
  static init() async{
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DB_NAME);
    print("_+_+_+_+_+ $path");
    // 打开数据库
    _DBA = await openDatabase(path,version: _VERSION,onUpgrade: (Database db, int oldVersion, int newVersion) async{

    },onCreate: (Database db, int vers) async{


    });
  }
  static Future<Database> getCurrentDB() async{
      if (_DBA == null){
        await init();
      }
      return  _DBA;
  }
  static Future<bool> isTableIsExits(String tableName) async{
     await getCurrentDB();
     String sql = "select * from Sqlite_master where type = 'table' and name = '$tableName'";
     var res = await _DBA.rawQuery(sql);

     return res != null && res.length>0;
  }

  static close(){
    _DBA?.close();
    _DBA = null;
  }

}