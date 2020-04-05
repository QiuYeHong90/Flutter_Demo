
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo_app/Model/VipVideoModel.dart';

class VideoManager{
    static VideoManager manage = VideoManager.init();
    VipVideoModel  videoModel;

    static VideoManager init(){
      var m = VideoManager();

      return m;
    }

}