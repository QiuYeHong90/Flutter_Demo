import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_app/Page/EmptyView.dart';
import 'package:flutter_demo_app/Page/HomeLeft.dart';
import 'package:flutter_demo_app/Route/Route.dart' as myRoute;
import 'package:flutter_demo_app/View/ClipRRectContainer.dart';
import 'package:flutter_demo_app/src/images.dart';
import 'package:orientation/orientation.dart';
import 'package:zefyr/zefyr.dart';
import 'Dao/Model/ContentModel.dart';
import 'Page/VideoPlayView.dart';
import 'Route/Route.dart';
import 'package:quill_delta/quill_delta.dart';

void main() {
  OrientationPlugin.setPreferredOrientations(DeviceOrientation.values);
  OrientationPlugin.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '备忘录',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.

          primarySwatch: Colors.yellow,
        ),
        home: Center(child: MyHomePage(title: '备忘录')),
//        routes: myRoute.routes,
        onGenerateRoute:(RouteSettings settings){
          var name = settings.name;
//        if (name == myRoute.route_newbwl){
//            name = myRoute.route_empty;
//        }
          print("路由===$name settings ${settings.arguments}");
          WidgetBuilder builder =  myRoute.routes[name];
          if (builder == null){
            assert(builder != null);
          }
          return MaterialPageRoute(builder: builder,settings: settings);
        }

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isGrid = true;
  var isFirst = true;
  List<ContentModel> _data = null;

  DeviceOrientation _deviceOrientation;

  StreamSubscription<DeviceOrientation> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    subscription = OrientationPlugin.onOrientationChange.listen((value) {
//      // If the widget was removed from the tree while the asynchronous platform
//      // message was in flight, we want to discard the reply rather than calling
//      // setState to update our non-existent appearance.
//      if (!mounted) return;
//
//      setState(() {
//        _deviceOrientation = value;
//      });
//
//      OrientationPlugin.forceOrientation(value);
//    });
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    subscription?.cancel();
  }

  void _incrementCounter(BuildContext context) async {

//    route_newbwl route_editor route_fullPage
    var result = await Navigator.of(context).pushNamed(route_editor,arguments: {
      "aaa":"ddd"
    });
    print("ssss"+result);
    this.loadData();

  }


  void loadData() async{


    isFirst = false;
    List<ContentModel> list = await ContentModel().FindList();
//    print("list.length $list.length");
    setState(() {
      if (list != null){
        _data = list;
      }else{
        _data = null;
      }

    });

  }
  void toEditPage(BuildContext context,ContentModel m) async{
    var reslut = await Navigator.of(context).pushNamed(myRoute.route_fullPage,arguments: m);
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    NotusDocument getDoc(String doc) {
      var data = Delta.fromJson(json.decode(doc) as List);

      return NotusDocument.fromDelta(data);
    }

    var childrens = null;
    if (_data == null) {
      print("为空");
      childrens = null;
    } else {
      childrens = _data.map((f) {
        ContentModel m = f;
        var con = m.content;
        return Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: GestureDetector(
            onTap: () {
              print(m.toJson());
              toEditPage(context, m);
            },
            child: Container(
                color: Colors.yellow,
                child: Expanded(
                    child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ZefyrView(
                      document: getDoc(con),
                      imageDelegate: CustomImageDelegate(),
                    )
                  ],
                ))),
          ),
        );
      }).toList();
    }

    Widget dataW = GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                childrens == null ? 1 : isGrid == true ? 3 : 1, //横轴三个子widget
            childAspectRatio:
                childrens == null ? 1 : isGrid == true ? 1 : 3 //宽高比为1时，子widget
            ),
        children: childrens == null
            ? [
                Container(
                  alignment: Alignment.center,
                  child: Text("没有数据"),
                )
              ]
            : childrens);

    if (isFirst == true) {
      loadData();
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.

        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => debugPrint('Search button is pressed'),
          ),
          IconButton(
            icon: Icon((this.isGrid == true) ? Icons.grid_on : Icons.list),
            tooltip: 'Search',
            onPressed: () {
              setState(() {
                this.isGrid = !this.isGrid;
              });
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: HomeLeft(),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(child: dataW),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter(context);
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Color(0xff3c1618),
          size: 30,
          textDirection: TextDirection.rtl,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
