
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ClipRRectContainer extends StatefulWidget {
//  borderRadius: BorderRadius.all(Radius.circular(50))


  final Color color;
  final Widget child;
  const ClipRRectContainer({Key key, this.color, this.child}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ClipRRectContainerState(color,child);
  }
}

class _ClipRRectContainerState extends State<ClipRRectContainer>{
  final Color color;
  final Widget child;
  Image _img;
  void openCamera(ImageSource source) async{
    var file = await ImagePicker.pickImage(source: source);
    var img = Image.file(file,scale: 0.5,fit: BoxFit.cover);

    setState(() {
      _img = img;

    });
  }

  _ClipRRectContainerState(this.color, this.child);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)) ,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Container(
          color: color,
          child: Stack(
            children: <Widget>[

              Container(
                width: 100,
                height: 100,
                child: IconButton(
                  icon: Icon(Icons.camera_enhance),

                  tooltip: 'Search',
                  onPressed: () {
                    openCamera(ImageSource.gallery);
                  },
                ),
              ),

              Positioned(
                child: Container(
                 
                  width: _img == null ? 0:100,
                  height: _img == null ? 0:100,
                  color: Colors.grey,
                  child:_img,
                ),
              )
            ],
          )
        ),
      ),
    );

  }

}