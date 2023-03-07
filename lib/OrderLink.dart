import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderLink extends StatefulWidget {
  OrderLink({this.url});
  String url;
  @override
  _OrderLinkState createState() => _OrderLinkState();
}

class _OrderLinkState extends State<OrderLink> {
  @override
  void initState() {
    print(widget.url);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(backgroundColor: Colors.lightGreen,),
        body: Container(
          child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: false,
            onPageFinished: (url) {
              setState(() {});
            },
          ),
        ));
  }
}
