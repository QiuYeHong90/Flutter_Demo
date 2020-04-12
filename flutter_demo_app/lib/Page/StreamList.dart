
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/Model/VipUrlItem.dart';
import 'package:flutter_demo_app/Route/Route.dart';
import 'package:flutter_demo_app/View/BasePageView.dart';
import 'package:flutter_demo_app/View/ClipRRectContainer.dart';


class StreamList extends StatefulWidget{

  var data = [
    {
      "style":1,
      "title":"直播列表",
      "data":[
        {
          "toPath":route_StreamVideo,
          "params":"http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8",
          "icon":"",
          "title":"CCTV6高清",
        },
        {
          "toPath":route_StreamVideo,
          "params":"http://ivi.bupt.edu.cn/hls/cctv5phd.m3u8",
          "icon":"",
          "title":"CCTV5+高清",
        },
        {
          "toPath":route_StreamVideo,
          "params":"http://ivi.bupt.edu.cn/hls/cctv5hd.m3u8",
          "icon":"",
          "title":"CCTV5高清",
        },
        {
          "toPath":route_StreamVideo,
          "params":"http://ivi.bupt.edu.cn/hls/cctv3hd.m3u8",
          "icon":"",
          "title":"CCTV3高清",
        },
        {
          "toPath":route_StreamVideo,
          "params":"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8",
          "icon":"",
          "title":"CCTV1高清",
        },
        {
          "toPath":route_StreamVideo,
          "params":"rtmp://58.200.131.2:1935/livetv/hunantv",
          "icon":"",
          "title":"湖南卫视",
        }


      ],
    }
  ];




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StreamListState();
  }


}

class _StreamListState extends State<StreamList> {
  Image _imgFile = null;
  var tableData = [];
  var isFirst = true;
  var text = "";
  void loadData(){
    var jj = [];
    var temp = widget.data;
    temp.forEach((f){
      var aaa = f;
      aaa["style"] = 1;

      jj.add(aaa);
      List ab = f["data"];
      if (ab != null){
        ab.forEach((t){
          Map bbb = t;

//          bbb["style"] = 2;
          jj.add(bbb);
        });
      }

    });
    setState(() {
      isFirst = false;
      tableData = jj;
    });

  }


  @override
  Widget build(BuildContext context) {
    if (isFirst){
      loadData();
    }
    // TODO: implement build
    return BasePageView(
      title: "直播",
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  height: 44,
//                  color: Colors.red,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
//                          cursorColor: Colors.white,

                            decoration:InputDecoration(
                              hintText: "请输入直播地址"
                            ),
                          onChanged: (value){
                            setState(() {
                              this.text = value;
                              print(value);
                            });
                          },
                        ),

                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: (){
                          var toPath = route_StreamVideo;
                          var model = this.text;
                           Navigator.of(context).pushNamed(toPath,arguments:model);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
//            Container(
//              color: Colors.red,
//              height: 40,
//              width: 40,
//              child: Row(
//                children: <Widget>[
//                  TextField(
//
//                  ),
//                  IconButton(
//                    icon: Icon(Icons.arrow_back),
//                  )
//                ],
//              ),
//            ),
            Expanded(

                child: Container(

                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

                  child: Container(
                    color: Colors.white,

                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: tableData.length,

//                      itemExtent: 50.0, //强制高度为50.0
                        itemBuilder: (BuildContext context, int index) {
                          Map model = tableData[index];
                          int style = model["style"];
                          print("style ==$style");
                          if (style == 1) {
                            return Container(
                              alignment:Alignment.centerLeft ,
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              color: Colors.grey,
                              height: 40,
                              child: GestureDetector(
                                child: Text(model["title"],maxLines: 1,style: TextStyle(
                                    fontSize: 18
                                ),),
                                onTap: (){
                                  childTap(model,context);
                                },
                              ),
                            );
                          }
//                        vlist.json

                          return GestureDetector(
                            child: ListTile(title: Text(model["title"],maxLines: 1,style:TextStyle(
                                color: Colors.green,
//                            backgroundColor: Colors.yellow,
                                fontSize: 18
                            ))),
                            onTap: (){
                              childTap(model,context);
                            },
                          );
                        }),
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }

  void childTap(Map model,BuildContext context){
    debugPrint("====");
    var toPath = model["toPath"];
    var params = model["params"];

    if (toPath != null){
      if (route_WebView == toPath){
        var model =  VipUrlItem.fromJson({
          "name":"点赞",
          "url":params
        });
        print(model);
        Navigator.of(context).pushNamed(toPath,arguments:model);
      }else{
        Navigator.of(context).pushNamed(toPath,arguments: params);
      }

    }
  }

}
