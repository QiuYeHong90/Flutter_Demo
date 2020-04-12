import 'package:flutter/material.dart';
import 'package:flutter_demo_app/Dao/Model/ContentModel.dart';



class BasePageView extends StatefulWidget {
  BasePageView({Key key, this.title = "", this.body, this.floatingActionButton, this.actions, this.isShowAppBar = true}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final bool isShowAppBar  ;
  final  List<Widget> actions;
  final String title;
  final Widget body;
  final FloatingActionButton floatingActionButton;
  @override
  BasePageViewPageState createState() => BasePageViewPageState();
}

class BasePageViewPageState extends State<BasePageView> {

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
    return Scaffold(
      appBar: widget.isShowAppBar? AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions:widget.actions,
      ) : null,
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,

    );
  }
}
