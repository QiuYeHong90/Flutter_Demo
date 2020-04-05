

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo_app/Dao/DBManger.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDBProvider{
  bool isTableExits = false;
  String columnId = "_id";

  tableSqlString();
  String tableName() {
    var name = this.runtimeType;
    return "$name";
  }

  tableBaseString(String name){
    return '''
    create table $name ($columnId integer primary key autoincrement
    ''';
  }
  @mustCallSuper
  prepare(name,String createSql) async{
     isTableExits = await DBManger.isTableIsExits(name);
     if (!isTableExits){
       Database db = await DBManger.getCurrentDB();
       return await db.execute(createSql);
     }
  }
  @mustCallSuper
  Future<Database> open()async{
    if (!isTableExits){
       await prepare(tableName(), tableSqlString());
    }

    return await DBManger.getCurrentDB();
  }



}