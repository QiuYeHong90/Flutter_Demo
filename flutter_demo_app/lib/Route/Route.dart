
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/Page/DouYinVideo.dart';
import 'package:flutter_demo_app/Page/EmptyView.dart';
import 'package:flutter_demo_app/Page/NewBWL.dart';
import 'package:flutter_demo_app/Page/StreamVideo.dart';
import 'package:flutter_demo_app/Page/VideoPlayView.dart';
import 'package:flutter_demo_app/Page/VipVideo.dart';
import 'package:flutter_demo_app/Page/YQWebView.dart';
import 'package:flutter_demo_app/src/editor_page.dart';
import 'package:flutter_demo_app/src/form.dart';
import 'package:flutter_demo_app/src/full_page.dart';
import 'package:flutter_demo_app/src/view.dart';

// 编辑
final route_newbwl = "/new_page";
final route_empty = "/empty";
final route_editor = "/editor";
final route_fullPage = "/fullPage";
final route_form = "/form";
// 查看
final route_view = "/view";
final route_VipVideo = "/VipVideo";
final route_WebView = "/WebView";
final route_DouYinVideo = "/DouYinVideo";
final route_VideoPlayView = "/VideoPlayView";
final route_StreamVideo = "/StreamVideo";

final Map<String, WidgetBuilder> routes = {
  route_newbwl:(context) => NewBWL(title: "编辑备忘录"),
  route_empty:(context) => EmptyView(),
  route_editor: (context) => EditorPage(),
  route_fullPage: (context) => FullPageEditorScreen(),
  route_form: (context) => FormEmbeddedScreen(),
  route_view: (context) => ViewScreen(),
  route_VipVideo: (context) => VipVideo(),
  route_WebView: (context) => YQWebView(),
  route_DouYinVideo: (context) => DouYinVideo(),
  route_VideoPlayView: (context) => VideoPlayView(),
  route_StreamVideo: (context) => StreamVideo(),

};



