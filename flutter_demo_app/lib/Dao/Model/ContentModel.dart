import 'package:flutter_demo_app/Dao/BaseDBProvider.dart';
import 'package:flutter_demo_app/Dao/DBManger.dart';
import 'package:sqflite/sqflite.dart';


class ContentModel extends BaseDBProvider {
    String content = "";
    int userID = 0;
    int contentID = 0;

    ContentModel({this.content, this.userID, this.contentID}) ;

    factory ContentModel.fromJson(Map<String, dynamic> json) {
        print("json['_id'] ${json['_id']}");
        return ContentModel(
            content: json['content'], 
            userID: json['userID'],
            contentID:json['_id']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['content'] = this.content == null ? "":this.content;
        data['userID'] = this.userID == null ? 0 :this.userID;
        return data;
    }



  @override
  tableSqlString() {
    // TODO: implement tableSqlString
     var map  = this.toJson();

     var sql = "";

     for(int i=0;i<map.keys.toList().length;i++)

     {
         var key = map.keys.toList()[i];
         var value = map[key];
         var d = ",";
         if (i+1 == map.keys.toList().length){
           d = "";
         }
         if (value != null){
             if (value is String){
                 sql = sql + "$key"+" text" + d;

             }else if (value is int){
                 sql = sql + "$key"+" integer" + d;
             }else if (value is double){
                 sql = sql + "$key"+" double" + d;
             }

             print(value);
         }


     }
     print("map == $map");
     String la = tableBaseString(this.tableName());
     if (sql.length>0){
       sql =la + "," + sql + ")";
     }else{
       sql =la + ")";
     }
     print("sql == $sql");


     return sql;
  }

  Future save() async{
        Database db = await DBManger.getCurrentDB();
        var map  = this.toJson();

        var data = await db.query(this.tableName(),where: "$columnId = $contentID");
        if (data.length == 0 ){
          return await db.insert(this.tableName(), map);
        }

        return await db.update(this.tableName(),map,where: "$columnId = $contentID");



  }

    Future<int> delete() async{
      Database db = await DBManger.getCurrentDB();
      print(this);

      print("$columnId = $contentID");
      var data = await db.query(this.tableName(),where: "$columnId = $contentID");
      print("data  ==== $data");
      return await db.delete(this.tableName(),where: "$columnId = $contentID");
    }



  Future<List<ContentModel>> FindList() async{
        String databasesPath = await getDatabasesPath();
        print(databasesPath);
        Database db = await this.open();
        List<Map<String,dynamic>> datas = await db.query(this.tableName());
        print("datas=== $datas");
        if (datas.length>0){
          List<ContentModel> list = datas.map((f)=> ContentModel.fromJson(f)).toList();

//            List<ContentModel> list = datas.map => ContentModel.fromJson(item).toList();
            return list;

        }

        return null;

    }
}