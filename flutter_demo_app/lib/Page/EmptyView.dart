
import 'package:flutter/material.dart';

class EmptyView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EmptyViewState();
  }
  
  
}

class _EmptyViewState extends State<EmptyView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Text("no Data"),
      ),
    );
  }
  
}
