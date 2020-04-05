
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/Manager/VideoManager.dart';
import 'package:flutter_demo_app/Model/VipUrlItem.dart';
import 'package:flutter_demo_app/View/BasePageView.dart';
import 'package:webview_flutter/webview_flutter.dart';


class YQWebView extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YQWebViewState();
  }


}

class _YQWebViewState extends State<YQWebView> {
  WebViewController _controller;
  var isShow = false;
  VipUrlItem args;
  var url = "";
  var title = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (url == ""){
      args = ModalRoute.of(context).settings.arguments;
      url = args.url;
      title  = args.name;
    }
    print("-=-=-=url  $url");
    return BasePageView(
      isShowAppBar: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: (){
            setState(() {
              isShow = !isShow;

            });
            handlePopupItemSelected(context);
          },
        )
      ],
      title: title,

      body: WebView(
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          _controller.evaluateJavascript("document.title").then((result){
            setState(() {
              title = result;
            });
          }
          );
        },

        initialUrl: url,
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request){
          print("即将打开 ${request.url}");
          //对于需要拦截的操作 做判断
          if(request.url.startsWith("myapp://")) {
            print("即将打开 ${request.url}");
            //做拦截处理
            //pushto....

//            Application.push(context, request.url);
            return NavigationDecision.prevent;
          }

          //不需要拦截的操作
          return NavigationDecision.navigate;
        },
      ),
    );
  }



  handlePopupItemSelected(BuildContext context) async {

    var data = VideoManager.manage.videoModel.list.map((e){
      return SimpleDialogOption(
        child: Text("${e.name}"),
        onPressed: (){

          Navigator.pop(context, e);
        },
      );
    }).toList();

    VipUrlItem model = await showDialog(context: context,builder: (BuildContext context){
      return SimpleDialog(
        children: data,
      );
    });
    print("url===$url");

    _controller.evaluateJavascript("document.location.href").then((result){
      var originUrl = result.split("url=").toList().last;
      print("originUrl===$originUrl");
      bool flag = true;
      print("flag === $flag");
      if (flag){
        setState(() {
          print("originUrl===$originUrl");
          url = model.url + originUrl;
          print("url===$url");
          _controller.loadUrl(url);
        });
      }

      }
    );
  }

}
