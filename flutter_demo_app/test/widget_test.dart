// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo_app/main.dart';


class Persion extends Object{
  String abck(){

    print(this.runtimeType);
    return this.toString();
  }
}

class Son extends Persion{


}


void main() {

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    var b = testAbc();
    print(b);
    print(say("你好", "先生","haha"));

    Son().abck();
    enableFlags(bold: true);




  });


}



bool testAbc(){

  var param = "max_cursor=0&min_cursor=0&count=20&feed_style=1&filter_warn=0&city=500000&latitude&longitude&poi_class_code=0&pull_type=1&location_permission=1&nearby_distance=0&roam_city_name&insert_fresh_aweme_ids&insert_fresh_type=0&os_api=23&device_type=MI%205s&device_platform=android&ssmix=a&iid=110689126481&manifest_version_code=100401&dpi=512&uuid=008796757122987&version_code=100400&app_name=aweme&cdid=42844fe2-16ed-41a0-93b3-8789dce3e5ea&version_name=10.4.0&ts=1586019765&openudid=45778e9ff9b3eeb4&device_id=70487440373&resolution=1280*2048&os_version=6.0.1&language=zh&device_brand=Xiaomi&app_type=normal&ac=wifi&update_version_code=10409900&aid=1128&channel=tengxun_new&_rticket=1586019766494";
  List data = param.split("&");
  var dict = {};
  var lists = data.map((e){
    String b = e ;
    List temp = b.split("=");
    dict[temp.first] = temp.last;
    return {
      temp.first:temp.last
    };

  }).toList();


  print("====== \n  ${json.encode(dict)}");

  return false;
}

String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

void enableFlags({bool bold, bool hidden}) {
  // ...
  if (bold == null){

  }
//  Future.delayed(new Duration(seconds: 2),(){
//    return "hi world!";
//  }).then((data){
//    print(data);
//  });

}