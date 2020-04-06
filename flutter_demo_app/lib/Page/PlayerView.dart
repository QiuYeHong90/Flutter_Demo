
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter_demo_app/View/BasePageView.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

class PlayerView extends StatefulWidget{
  final String url;
  final String imgPath;
  const PlayerView({Key key, this.url, this.imgPath}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayerViewState(url,imgPath);
  }


}

class _PlayerViewState extends State<PlayerView> {


  VideoPlayerController _controller = null;
  bool _isPlaying = false;
  final String url ;
  final String imgPath ;
  _PlayerViewState(this.url, this.imgPath);


  initMyViewC(){

    if (_controller == null){
      print("======$url");
      _controller = VideoPlayerController.network(url)
      // 播放状态
        ..addListener(() {
          final bool isPlaying = _controller.value.isPlaying;
          print("object ==== 监听");
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
            });
          }
        })
      // 在初始化完成后必须更新界面
        ..initialize().then((_) {
          setState(() {
            _controller.play();
          });
        });
      _controller.setLooping(true);
    }else{
      setState(() {
        _controller.play();
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    initMyViewC();
    super.initState();



  }



  @override
  Widget build(BuildContext context) {
    var top = MediaQueryData.fromWindow(window).padding.top;
    var height = MediaQueryData.fromWindow(window).size.height;
    var width = MediaQueryData.fromWindow(window).size.width;



    // TODO: implement build
    return Stack(
       children: <Widget>[
         ListView(
           padding: EdgeInsets.all(0),
           physics: NeverScrollableScrollPhysics(),
           children: <Widget>[
             Container(
               height: height,
               alignment: Alignment.centerLeft,
               child:  _controller.value.initialized
                   ? AspectRatio(
                 aspectRatio: _controller.value.aspectRatio,
                 child: VideoPlayer(_controller),
               )
                   : Container(
                 child: _isPlaying == false? new Hero(
                        tag: imgPath,
                        child: CachedNetworkImage(
                          imageUrl: imgPath,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) =>
                              Image.asset('images/breeze.jpg'),
                        ),
                    ) :Container(
                   width: width,
                   height: height,
                 ),
               ),
             ),

           ],
         )

       ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    print("释放了   $url");
  }

}
