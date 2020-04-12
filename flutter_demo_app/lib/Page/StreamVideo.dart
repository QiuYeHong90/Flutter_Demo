import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class StreamVideo extends StatefulWidget {


  StreamVideo();

  @override
  _StreamVideoState createState() => _StreamVideoState();
}

class _StreamVideoState extends State<StreamVideo> {
  final FijkPlayer player = FijkPlayer();
  var url = null;
  _StreamVideoState();

  @override
  void initState() {
    super.initState();
//    player.setDataSource(widget.url, autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    if( url == null){
      setState(() {
        url = ModalRoute.of(context).settings.arguments;
        player.setDataSource(url, autoPlay: true);
      });
    }


    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
          child: FijkView(
            player: player,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}