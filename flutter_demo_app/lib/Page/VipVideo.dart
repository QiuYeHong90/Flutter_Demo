
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/Manager/VideoManager.dart';
import 'package:flutter_demo_app/Model/VipUrlItem.dart';
import 'package:flutter_demo_app/Model/VipVideoModel.dart';
import 'package:flutter_demo_app/Route/Route.dart';
import 'package:flutter_demo_app/View/BasePageView.dart';

class VipVideo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipVideoState();
  }


}

class _VipVideoState extends State<VipVideo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePageView(

      title: "看电影",
      body: Container(
        child: Center(
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString("json/vlist.json"),
              builder: (context,snapshot){

                var mydata = json.decode(snapshot.data.toString());
                print("==== $mydata");

                var model = VipVideoModel.fromJson(mydata);
                VideoManager.manage.videoModel = model;
                return ListView.builder(
                  itemBuilder: (BuildContext context ,int index ){
                    var item = model.platformlist[index];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                         GestureDetector(
                           child: Container(
                             height: 50,
                             child:  Text("Name:" + item.name,style: TextStyle(
                                 fontSize: 18
                             )),
                           ),
                           onTap: (){
                             childTap(item, context);
                           },
                         )


                        ],
                      ),
                    );
                  },
                  itemCount: model.platformlist == null ? 0:model.platformlist.length,
                );
              },
            )
        ),
      ),
    );
  }
  void childTap(VipUrlItem model,BuildContext context){

    var toPath = model.url;
    print(toPath);
    if (toPath != null){
      Navigator.of(context).pushNamed(route_WebView,arguments: model);
    }
  }
}
