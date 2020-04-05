
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app/Page/PlayerView.dart';
import 'dart:ui';
import 'package:flutter_demo_app/View/BasePageView.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

class VideoPlayView extends StatefulWidget{


  const VideoPlayView({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoPlayViewState();
  }


}

class _VideoPlayViewState extends State<VideoPlayView> {


  var selIndex = 0;
  PageController _pageController ;

  String url ;
  List aweme_list = [];
   _VideoPlayViewState();

   initPageView(){
     _pageController = PageController(
         initialPage: selIndex,
         keepPage: true,
         viewportFraction: 1.0
     );
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrientationPlugin.setEnabledSystemUIOverlays([]);



  }

  Map getItemModel(int index,List aweme_list){
    if(aweme_list.length>0) {
      var obj = aweme_list[index];
      return obj;
    }
    return null;
  }
  String getVideoUri(int index,List aweme_list){
     var obj = getItemModel(index,aweme_list);
     if (obj != null){
       var video = obj["video"];
       List listaa = video["play_addr_lowbr"]["url_list"];
       return listaa.first;
     }


     return null;
  }
  Widget getChildsView(double height,BuildContext context ,int index){

    var obj = getItemModel(index,aweme_list);
    if (obj != null){
      var desc = obj["desc"];
      var video = obj["video"];
      if (video == null){
        return Container(
          color: Colors.white,
        );
      }

//      print("object == ${video.toString()}");
      var cover = video["cover"];
      var imgPath = "";
      if (cover != null){

        imgPath = cover["url_list"][0];
      }
      var temp = this.getVideoUri(index, aweme_list);

      return Container(
        height: height,
        alignment: Alignment.centerLeft,
        child: PlayerView(
            url: temp,
            imgPath: imgPath
        ),
      );

    }

     return null;
  }

  @override
  Widget build(BuildContext context) {
    var top = MediaQueryData.fromWindow(window).padding.top;
    var height = MediaQueryData.fromWindow(window).size.height;
    if(url == null){
      Map args = ModalRoute.of(context).settings.arguments;
      var data  = args["data"];
      var index = args["index"];
      var ts = this.getVideoUri(index,data);

      initPageView();
      setState(() {
        selIndex = index;
        aweme_list = data;

      });


    }




    // TODO: implement build
    return BasePageView(
      isShowAppBar: false,
      title: "看电影",
      body: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child:PageView.builder(

                        itemBuilder: (context,index){
                            return this.getChildsView(height,context,index);
                        },
                       itemCount: aweme_list.length,
                       scrollDirection: Axis.vertical,
//                       reverse: true,
                       physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
                       controller: _pageController,
                       onPageChanged: (index){
                          print("index $index");
                          setState(() {
                            selIndex = index;
                            url = this.getVideoUri(index,aweme_list);

                          });
                       },

                      )
                    ),
//                  Positioned(
//                    top: 0,
//                    right: 0,
//                    bottom: 0,
//                    left: 0,
//                    child: ListView(
//                      padding: EdgeInsets.all(0),
//                      physics: NeverScrollableScrollPhysics(),
//                      children: <Widget>[
//                        Container(
//                          height: height,
//                          color: Colors.red,
//                          alignment: Alignment.centerLeft,
//                          child: _controller.value.initialized
//                              ? AspectRatio(
//
//                            aspectRatio: _controller.value.aspectRatio,
//                            child: VideoPlayer(_controller),
//                          )
//                              : Container(
//                            child: Text("00-=-=-=-"),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
                  Positioned(
                    top: top,
                    left: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(22)) ,
                      child: Container(
                        width: 44,
                        height: 44,
                        color: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        )),

    );
  }

  @override
  void dispose() {
    super.dispose();
    OrientationPlugin.setPreferredOrientations(DeviceOrientation.values);
    OrientationPlugin.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  }

}
