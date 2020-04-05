//OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app/Http/Http.dart';
import 'package:flutter_demo_app/Route/Route.dart';
import 'package:flutter_demo_app/View/BasePageView.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:orientation/orientation.dart';

class DouYinVideo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DouYinVideoState();
  }


}

class _DouYinVideoState extends State<DouYinVideo> {
  List aweme_list = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    print("object-=-=-=-=");
    loadData();
  }

  loadData() async{
    print("data === ");
    Map model = await Http.awemeNearbyFeed();
    setState(() {
      aweme_list  = model["aweme_list"];
    });
    print("data === ${model}");
  }
  loadMore() async{
    print("data === ");
    Map model = await Http.awemeNearbyFeed();
    setState(() {

      aweme_list  += model["aweme_list"];
    });
    print("data === ${model}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    OrientationPlugin.setPreferredOrientations(DeviceOrientation.values);
    OrientationPlugin.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return BasePageView(

        title: "抖音",
        body: Center(
        child: EasyRefresh(
            onRefresh: () async{
                loadData();
            },
            onLoad:() async{
              loadMore();
            },
//          refreshHeader: ClassicsHeader(
//            key: _headerKey,
//            bgColor: Colors.white,
//            textColor: Colors.pink,
//            moreInfoColor: Colors.pink,
//            refreshReadyText: '下拉刷新',
//            refreshingText: '正在努力刷新',
//            refreshedText: '加载完成',
//            showMore: true,
//            moreInfo: '正在加载中',
//          ),
//          refreshFooter: ClassicsFooter(
//            key: _footerKey,
//            bgColor: Colors.white,
//            textColor: Colors.pink,
//            moreInfoColor: Colors.pink,
//            showMore: true,
//            noMoreText: '暂时没有更多了',
//            loadReadyText: '上拉加载',
//            loadedText: '加载完毕',
//            loadText: '上拉加载更多',
//            loadingText: '正在努力加载更多',
//            moreInfo: '正在加载中',
//          ),

          child: aweme_list == null? Text("no Data"):StaggeredGridView.countBuilder(
            itemCount: aweme_list.length,
            primary: false,
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            itemBuilder: (BuildContext context,i){
              var obj = aweme_list[i];
              var desc = obj["desc"];
              var video = obj["video"];


              final size = MediaQuery.of(context).size;
              double w = (size.width - 15)/2.0;
              double rate = 1;
              double h = w * rate;
              if (video == null){
                return Container(
                  color: Colors.white,
                );
              }
              print("object == ${video.toString()}");
              var cover = video["cover"];
              var imgPath = "";
              if (cover != null){
                double width = double.parse(video["width"].toString());
                double height = double.parse(video["height"].toString());
                rate = height/width;
                h = w * rate;
                imgPath = cover["url_list"][0];
              }




              return Container(
                child: new Material(
                  elevation: 8.0,
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(8.0),
                  ),
                  child: new InkWell(
                      onTap: () {
                        List listaa = video["play_addr_lowbr"]["url_list"];
                        if (listaa != null&&listaa.length>0){
                          print("url_list == ${listaa.toString()}");
                          Navigator.of(context).pushNamed(route_VideoPlayView,arguments: {
                            "data":this.aweme_list,
                            "index":i
                          });
                        }

                      },
                      child: Container(
                          child: Column(
                            children: <Widget>[
                              new Hero(
                                tag: imgPath,
                                child: CachedNetworkImage(
                                  imageUrl: imgPath,
                                  fit: BoxFit.fitWidth,
                                  placeholder: (context, url) =>
                                      Image.asset('images/breeze.jpg'),
                                ),
                              ),
                              Text(desc)
                            ],
                          )

                      )
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
          ),
        ),
    ));
  }

}
