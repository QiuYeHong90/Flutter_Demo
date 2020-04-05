


import 'package:dio/dio.dart';
enum HttpRequestType{
  Get,
  Post
}
class Http{


  static Dio dio = Dio();
  static String baseUrl = "https://api3-core-c-hl.amemv.com/";

  static Future<Response> request(HttpRequestType method,String path,{Map params}) async{
    Response response;
    var http = Http.dio;

    var temp = {"max_cursor":"0",
      "min_cursor":"0",
      "count":"20",
      "feed_style":"1",
      "filter_warn":"0","city":"500000",
      "latitude":"latitude","longitude":"longitude","poi_class_code":"0",
      "pull_type":"1","location_permission":"1","nearby_distance":"0","roam_city_name":"roam_city_name","insert_fresh_aweme_ids":"insert_fresh_aweme_ids","insert_fresh_type":"0","os_api":"23","device_type":"MI%205s","device_platform":"android","ssmix":"a","iid":"110689126481","manifest_version_code":"100401","dpi":"512","uuid":"008796757122987","version_code":"100400","app_name":"aweme","cdid":"42844fe2-16ed-41a0-93b3-8789dce3e5ea","version_name":"10.4.0","ts":"1586019765","openudid":"45778e9ff9b3eeb4","device_id":"70487440373","resolution":"1280*2048","os_version":"6.0.1","language":"zh","device_brand":"Xiaomi","app_type":"normal","ac":"wifi","update_version_code":"10409900","aid":"1128","channel":"tengxun_new","_rticket":"1586019766494"};
    if ( params != null){
      temp.addAll(params);
    }

    print("data === ${temp}");
    var url = "${Http.baseUrl}${path}";
    if (method == HttpRequestType.Get){
      response = await http.get(url,queryParameters: temp);
    }else{
      response = await http.post(url,data: temp);
    }

    print("data === ${response.data}");

    return response;
  }

  static Future<Map> awemeNearbyFeed() async{
    var path = "aweme/v1/nearby/feed/";

    Response response  = await request(HttpRequestType.Get, path);

    return response.data;
  }

}