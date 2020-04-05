import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/Dao/Model/ContentModel.dart';
import 'package:flutter_demo_app/View/BasePageView.dart';
import 'package:image_picker/image_picker.dart';



class NewBWL extends StatefulWidget {
  NewBWL({Key key, this.title}) : super(key: key);
  
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  NewBWLPageState createState() => NewBWLPageState();
}

class NewBWLPageState extends State<NewBWL> {
  var dateCurrent  = DateTime.now();
  Image _imgFile = null;
  var _content = "";
  void _incrementCounter(String value) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _content = value;
    });
  }
  
  void showDate(BuildContext context) async{
    var current = dateCurrent;
    var  date = DateTime(2017,12,11,01,10);
    var  lastDate = DateTime(2027,12,11,01,10);


    DateTime reslut = await  showDatePicker(context: context, initialDate: current, firstDate: date, lastDate: lastDate,initialDatePickerMode:DatePickerMode.day );
    print("reslut $reslut");
    if (reslut == null){
      return;
    }
    TimeOfDay  time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    var dd = DateTime.parse("${reslut.year}-${reslut.month}-${reslut.day} ${time.hour}:${time.minute}:00");
    if (time == null){
      return;
    }
    setState(() {

      dateCurrent = dd;
    });
  }
  
  
  void openCamera(ImageSource source) async{

    var abc = await showCupertinoDialog(context: context, builder:  (a){


      return CupertinoAlertDialog(
        title: Text("选择"),
        content:Text("hhhh"),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("你好"),
            onPressed: (){
              Navigator.pop(context,"ddddd");
            },
          )
        ],
      );
    });

    print("===$abc");
//    showDialog(context: context,builder: (a){
//
//
//      return Container(
//        width: 100,
//        height: 100,
//        color: Colors.red,
//      );
//    }
//    );

//    var file = await ImagePicker.pickImage(source: source);
//    var img = Image.file(file);
//    setState(() {
//      _imgFile = img;
//    });
  }
  

  @override
  Widget build(BuildContext context) {

    //获取路由参数  
    var args=ModalRoute.of(context).settings.arguments;
    print(args);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BasePageView(title: widget.title,body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[
//          Container(
//              child: _imgFile == null ? Text("请选择"):_imgFile
//          ),

          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  child: Text("${dateCurrent.year}-${dateCurrent.month}-${dateCurrent.day} ${dateCurrent.hour}-${dateCurrent.minute}-${dateCurrent.second}"),
                ),

                Padding(padding: EdgeInsets.all(15),
                  child: RichText(
                    textAlign: TextAlign.right,
                    //          textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    text: TextSpan(
                      text: 'RichText',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold

                      ),
                        children: [
                          TextSpan(text: '.com',
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300
                              )
                          )
                        ]
                    ),

                  ),
                ),

                Padding(padding: EdgeInsets.all(15),
                  child: TextField(

                    style: TextStyle(

                ),maxLines: 10000,onChanged: (value){
                      _incrementCounter(value);
                },) ,),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 44,
                    color: Colors.yellow,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.date_range),
                          tooltip: 'Search',
                          onPressed: () {
                            showDate(context);
                          },

                        ),
                        IconButton(
                          icon: Icon(Icons.collections),
                          tooltip: 'Search',
                          onPressed: () {
                            openCamera(ImageSource.gallery);
                          },

                        ),
                        IconButton(
                          icon: Icon(Icons.camera_enhance),
                          tooltip: 'Search',
                          onPressed: () {
                            openCamera(ImageSource.camera);
                          },

                        ),
                        IconButton(
                          icon: Icon(Icons.color_lens),
                          tooltip: 'Search',
                          onPressed: () {

                          },

                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          )

        ],
      ),
    ),floatingActionButton: FloatingActionButton(
      onPressed: (){
        var obj = ContentModel(content: _content);
        obj.save();
        Navigator.pop(context,_content);
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ));
  }
}
