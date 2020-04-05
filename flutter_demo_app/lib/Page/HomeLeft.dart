
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/Model/VipUrlItem.dart';
import 'package:flutter_demo_app/Route/Route.dart';
import 'package:flutter_demo_app/View/ClipRRectContainer.dart';
import 'package:image_picker/image_picker.dart';

class HomeLeft extends StatefulWidget{

  var data = [
    {
      "style":1,
      "title":"备忘录",
      "data":[
        {
          "style":2,
          "icon":"",
          "title":"备忘录(7)",
        },
        {
          "icon":"",
          "title":"待办",
        },
        {
          "icon":"",
          "title":"提醒",
        },
        {
          "icon":"",
          "title":"我的收藏",
        },
      ],
    },{
      "title":"标签",
      "data":[
        {
          "style":2,
          "icon":"",
          "title":"个人(7)",
        },
        {
          "icon":"",
          "title":"待办",
        },
        {
          "toPath":route_WebView,
          "params":"https://github.com/QiuYeHong90/Flutter_Demo",
          "icon":"",
          "title":"点赞",
        },
        {
          "toPath":route_VipVideo,
          "icon":"",
          "title":"看电影",
        },
        {
          "toPath":route_DouYinVideo,
          "icon":"",
          "title":"抖音",
        },
        {
          "toPath":route_DouYinVideo,
          "icon":"",
          "title":"抖音",
        }


      ],
    }
  ];




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeLeftState();
  }


}

class _HomeLeftState extends State<HomeLeft> {
  Image _imgFile = null;
  var tableData = [];
  var isFirst = true;
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
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.red,
            height: 200,
            child: Center(

              child: ClipRRectContainer(color: Colors.white


                ),
            ),
          ),
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
    );
  }

  void childTap(Map model,BuildContext context){
      debugPrint("====");
      var toPath = model["toPath"];
      var params = model["params"];

      if (toPath != null){
        if (route_WebView == toPath){

          Navigator.of(context).pushNamed(toPath,arguments: VipUrlItem(url:params));
        }else{
          Navigator.of(context).pushNamed(toPath,arguments: params);
        }

      }
  }

}
