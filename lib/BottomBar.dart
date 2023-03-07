import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makaya/test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Api/Api.dart';
import 'ViewFavItems.dart';
import 'amazon/webview.dart';
import 'main.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 65.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0)),
                color: MyApp.primarycolor),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 65.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  new IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.storeAlt,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GridLayout()));
                                      }),
                                  new Text(
                                    "Stores",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              new IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.conciergeBell,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WebViewAmazon(MyApp.url)));
                                  }),
                              new Text(
                                "Recent",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new IconButton(
                                  icon: Icon(
                                    MdiIcons.calendarHeart,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Api.addFav();
                                    print("adding to favorites");
                                    if (MyApp.witems.isEmpty) {
                                      // Alert(
                                      //   context: context,
                                      //   type: AlertType.error,
                                      //   title: "Sorry!",
                                      //   desc: "No Item Added To favourite",
                                      //   buttons: [
                                      //     DialogButton(
                                      //       color: Colors.redAccent,
                                      //       child: Text(
                                      //         "OK",
                                      //         style: TextStyle(
                                      //             color: Colors.white,
                                      //             fontSize: 20),
                                      //       ),
                                      //       onPressed: () =>
                                      //           Navigator.pop(context),
                                      //       width: 80,
                                      //     )
                                      //   ],
                                      // ).show();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('No Item Added To Favourite',textAlign: TextAlign.center,),
                                            backgroundColor:Colors.lightGreen ,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewFavItems()));
                                    }
                                  }),
                              new Text(
                                "favourite",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),

                          /*new IconButton(icon: new Icon(Icons.more,color: MyApp.primarycolor,), onPressed: (){


                          }),*/
                        ],
                      )),
                ])));
  }
}
