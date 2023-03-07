import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';

class How_it_works extends StatefulWidget {
  const How_it_works({Key key}) : super(key: key);

  @override
  _How_it_worksState createState() => _How_it_worksState();
}

class _How_it_worksState extends State<How_it_works> {
 bool Visible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.black,
      leading: Icon(Icons.add,color: Colors.black,),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
              child: new Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
      ],
      ),
      body:
         Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.22,),
              Container(
                height: MediaQuery.of(context).size.height*0.35,
                child: Stack(
                  children:[
                    WebView(
                    initialUrl: "https://www.youtube.com/watch?v=jSnf43N-u7s",
                    javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: false,
                      onPageFinished: (url){
                      setState(() {
                        Future.delayed(Duration(seconds: 45)).then((value) =>{
                          Navigator.pop(context),
                        });
                        Visible=false;
                      });
                      },
                  ),
                    Positioned(
                      top: MediaQuery.of(context).size.height*0,
                      left: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.08,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,

                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height*0,
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width*0.5,
                        color: Colors.transparent,

                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height*0.15,
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,

                      ),
                    ),
                  // Positioned(
                  //   bottom: 0,
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height*0.5,
                  //     width: MediaQuery.of(context).size.width,
                  //     color: Colors.white,
                  //     child:  Visible? Column(
                  //       children: [
                  //         Container(height:30,width:30,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.lightGreen))),
                  //       ],
                  //     ):Text(""),
                  //   ),
                  // )
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
