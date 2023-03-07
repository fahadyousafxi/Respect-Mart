import 'dart:io';
import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/dom.dart' as a;
import 'package:html/parser.dart';
import 'package:makaya/Api/Api.dart';
import 'package:makaya/Profile.dart';
import 'package:makaya/ViewFavItems.dart';
import 'package:makaya/nointernet.dart';
import 'package:makaya/signInNew.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:makaya/test.dart';
import 'package:badges/badges.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';
import '../BottomBar.dart';
import '../ViewCart.dart';
import '../login.dart';
import '../main.dart';
import 'package:badges/badges.dart' as badge;

class EbayWebView extends StatefulWidget {
  String url = "";
  bool check = false;

  EbayWebView(this.url);

  @override
  EbayWebViewState createState() {
    try {
      return new EbayWebViewState(this.url);
    } catch (Exception) {
      print(Exception);
    }
  }
}

class EbayWebViewState extends State<EbayWebView> {

  Stores store=new Stores();

  Future<bool> _showMyDialog(var features) async {
    for (int i = 0; i < features.length; i++) {
      var feature = features[i];
      String name = feature.attributes["name"];
      List<a.Element> elements = feature.children;
      print(name);
      for (int j = 0; j < elements.length; j++) {
        print(elements[j].innerHtml);
      }
      dropdowns.add(MyStatefulWidget(name, elements, this));
      dropdownvalue[name] = elements[0].innerHtml;
    }
    if (dropdownvalue.containsValue("- Select -")) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Features'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please select the required features of your product')
                ],
              ),
            ),
            actions: <Widget>[
              ...dropdowns,
              ElevatedButton(
                child: Text('DONE'),
                onPressed: () {
                  if (dropdownvalue.containsValue("- Select -")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please Select all Features',textAlign: TextAlign.center,),
                          backgroundColor:Colors.blueAccent ,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }
  static int counter = 0;

  List<Widget> dropdowns = new List<Widget>();
  Map<String, String> dropdownvalue = new Map<String, String>();

  bool _visible = true;
  bool _appIndicator = false;
  bool _nav_visibilty = false;
  String url = "";

  EbayWebViewState(this.url);

  Completer<WebViewController> _controller = Completer<WebViewController>();
  String temporyurl = "";

  @override
  void initState() {
    super.initState();

    if (this.url.contains("/itm/")) {
      _showAddToCartButton(true);
      temporyurl = url;
      MyApp.url = url;
    } else {
      MyApp.ebay_obj.reset();
      _showAddToCartButton(false);
    }

    startTimer();
  }

  _showAddToCartButton(bool check) {
    setState(() {
      _nav_visibilty = check;
      MyApp.enteredProductPage = check;
    });
  }

  _showAppBarIndicator(bool check) {
    setState(() {
      _appIndicator = check;
    });
  }

  int _incrementTab() {
    int count = 0;
    setState(() {
      count = MyApp.aitems.length;
    });
    return count;
  }


  static int count = 0;


  Future<bool> addtofav(String url) async {
    String device_id = await DeviceId.getID;

    print(MyApp.base_url + "/User/addtofav");

    final response = await http.post(MyApp.base_url + "/User/addtofav",
        body: {"url": url, "deviceid": device_id});

    var data = json.decode(response.body);

    print(data["success"]);

    if (data["success"] == true) {
      if (Navigator.canPop(context)) Navigator.pop(context);

      Alert(
        context: context,
        type: AlertType.success,
        title: "Done",
        desc: data["message"],
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 60,
          )
        ],
      ).show();
    } else {
      if (Navigator.canPop(context)) Navigator.pop(context);

      Alert(
        context: context,
        type: AlertType.error,
        title: "OOPS",
        desc: data["message"],
        buttons: [
          DialogButton(
            color:Colors.redAccent,
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 60,
          )
        ],
      ).show();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Key _key = new Key("webview");

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  Future<void> loadHtmlFromAssets(String filename, controller) async {
    String fileHtmlContents =
        await rootBundle.loadString("assets/nointernet.html");
    controller.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  Widget isLoginText;
  Widget UserLoggedin;

  Timer _timer;
  int _start = 10;

  void startTimer() {
    // const oneSec = const Duration(seconds: 1);
    // _timer = new Timer.periodic(
    //   oneSec,
    //   (Timer timer) => setState(
    //     () {
    //       _checkState();
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    bool isParsing = false;

    Widget webScreen = new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: -10,
        title: Container(
            height: 100,
            width: 200,
            child: Image.asset('assets/images/makaya_appbar.jpg')),
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: MyApp.primarycolor,
        actions: <Widget>[
          Visibility(
            visible: _appIndicator,
            child: new Container(
                width: 50.0,
                height: 50.0,
                color: MyApp.primarycolor,
                child: new CircularProgressIndicator()),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10,left: 20),
              child:GestureDetector(
                  child: new Icon(
                FontAwesomeIcons.heart,
                color: Colors.white,
                    size: 20,
              ),
              onTap: () {
                // _showAppBarIndicator(true);
                _controller.future.then((test) {
                  test.currentUrl().then((value) {
                    print("\n\n\n\n\n");
                    print(value);
                    print("\n\n\n\n\n");
                    temporyurl = value;
                    if (temporyurl.contains("/itm/")) {
                      showProgressDialog(context, "Adding to favourite");

                      MyApp.ebay_obj
                          .viewProduct(temporyurl, context,dropdownvalue)
                          .then((success) {
                        if (MyApp.ebay_obj.parsedSuccess && success) {
                          print("Done Scrapping");
                          int check = MyApp.ebay_obj.addTofav(temporyurl);
                          String desc = "";
                          String title = "";
                          AlertType alertType = AlertType.success;

                          if (check == 0) {
                            alertType = AlertType.error;
                            desc = "Something not right Please try again";
                            title = "Error";
                          } else if (check == 1) {
                            alertType = AlertType.success;
                            title = "Success";
                            desc = "Item Added to favourite";
                          } else if (check == 2) {
                            alertType = AlertType.info;
                            title = "Info";
                            desc = "Item already in favourite";
                          } else {
                            alertType = AlertType.error;
                            title = "OOPs";
                            desc =
                                "Please Select all attributes before adding to cart";
                          }
                          _incrementTab();
                          if (Navigator.canPop(context)) Navigator.pop(context);

                          Alert(
                            context: context,
                            type: alertType,
                            title: title,
                            desc: desc,
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 60,
                                color: check==0?Colors.redAccent:check==1?Colors.green:check==2?Colors.blueAccent:Colors.redAccent,

                              )
                            ],
                          ).show();
                          // _showAppBarIndicator(false);
                        } else {
                          Navigator.pop(context);
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Sorry",
                            desc: "the product is not available at the moment",
                            buttons: [
                              DialogButton(
                                color:Colors.redAccent,
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 60,
                              )
                            ],
                          ).show();
                        }
                      });
                    }
                  });
                });
              })),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child:GestureDetector(
                  child: new Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                _controller.future.then((onValue) {
                  navigate(context, onValue, goBack: true);

                  _controller.future.then((value) {
                    value.currentUrl().then((value) {
                      String url = value;
                      if (url.contains("/dp/") || url.contains("/d/")) {
                        _showAddToCartButton(true);
                      } else {
                        _showAddToCartButton(false);
                      }
                    });
                  });
                });
              })),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child:GestureDetector(
              child: new Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onTap: () {
                _controller.future.then((onValue) {
                  checkInternet().then((check) {
                    if (check) {
                      onValue.currentUrl().then((url) {
                        if (url.contains("/itm/")) {
                          _showAddToCartButton(true);
                        }

                        onValue.loadUrl(url);
                      });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoInternet(onValue)));
                    }
                  });
                });
              })),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                child: new Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onTap: () {
                  print("wait");
                  _controller.future.then((onValue) {
                    navigate(context, onValue, goBack: false).then((nothing) {
                      onValue.currentUrl().then((url) {
                        print(url);
                        if (url.contains("/itm/")) {
                          _showAddToCartButton(true);
                        }
                      });
                    });
                  });
                }),
          ),
          badge.Badge(
            // animationType: BadgeAnimationType.slide,
            // position: BadgePosition(top: 0, start: 0),
            // badgeColor: Colors.white,
            badgeContent: Text(_incrementTab().toString()),
            child: new IconButton(
                icon: new Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Api.addCart();
                  MyApp.aitems.length<1?   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No Item Added To Cart',textAlign: TextAlign.center,),
                        backgroundColor:Colors.lightGreen ,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )): Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCartItems()));   }),
          ),
        ],
      ),
      body: WebView(
        key: _key,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
              name: 'Print',
              onMessageReceived: (JavascriptMessage message) {
                print("hello world");
                print(message.message);
              })
        ]),
        initialUrl: url,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        navigationDelegate: (NavigationRequest nav) {
          checkInternet().then((check) {
            if (check) {
              print(nav.url);
              String value = nav.url;
              MyApp.url = nav.url;
              temporyurl = value;
              if (nav.url.contains("/itm/")) {
                if (isParsing == false) {
                  isParsing = true;
                  _showAddToCartButton(true);
                  temporyurl = value;

                  _controller.future.then((webviewtest) {
                    webviewtest
                        .evaluateJavascript(
                            "document.getElementById('productTitle').innerHTML")
                        .then((something) {
                      print(something);
                    });
                  });
                }
              } else {
                MyApp.ebay_obj.reset();
                _showAddToCartButton(false);
              }

              //  return NavigationDecision.navigate;

            } else {
              _showAddToCartButton(false);
              _controller.future.then((value) {
                //loadHtmlFromAssets("",value);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NoInternet(value)));
              });
            }
          });

          return NavigationDecision.navigate;
        },
        onPageFinished: (url) {
          setState(() {
            print("====your page is load");

            print(url);
          });
        },

      ),
      floatingActionButton: new Visibility(
        visible: _nav_visibilty,
        child: new FloatingActionButton.extended(
            label: new Text(
              'Add to RespectMart Cart                       ',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () async {
              //_showAppBarIndicator(true);
              //   _showMyDialog();

              dropdowns = new List<Widget>();
              dropdownvalue = new Map<String, String>();

              _controller.future.then((test) {
                test.currentUrl().then((value) async {
                  var menu;
                  menu = await http.get(value);
                  var document = parse(menu.body);

                  var features = document.getElementsByClassName("msku-sel");

                  _showMyDialog(features).then((ve) => {
                        if(!dropdownvalue.containsValue('- Select -')){
                          checkInternet().then((check) {
                            if (check) {
                              print("\n\n\n\n\n");
                              print(value);
                              print("\n\n\n\n\n");
                              temporyurl = value;

                              showProgressDialog(context, "Adding to Cart");

                              MyApp.ebay_obj
                                  .viewProduct(temporyurl, context,dropdownvalue)
                                  .then((success) {
                                if (MyApp.ebay_obj.parsedSuccess && success) {
                                  print("Done Scrapping");
                                  int check =
                                  MyApp.ebay_obj.addTocart(temporyurl);
                                  String desc = "";
                                  String title = "";
                                  AlertType alertType = AlertType.success;

                                  if (check == 0) {
                                    alertType = AlertType.error;
                                    desc = "Something not right Please try again";
                                    title = "Errror";
                                  } else if (check == 1) {
                                    alertType = AlertType.success;
                                    title = "Success";
                                    desc = "Item Added to Cart";
                                  } else if (check == 2) {
                                    alertType = AlertType.info;
                                    title = "Success";
                                    desc = "Item Updated in Cart";
                                  } else {
                                    alertType = AlertType.error;
                                    title = "OOPs";
                                    desc =
                                    "Please Select size and color before adding to cart";
                                  }
                                  _incrementTab();
                                  if (Navigator.canPop(context))
                                    Navigator.pop(context);

                                  Alert(
                                    context: context,
                                    type: alertType,
                                    title: title,
                                    desc: desc,
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 60,
                                        color: check==0?Colors.redAccent:check==1?Colors.green:check==2?Colors.blueAccent:Colors.redAccent,

                                      )
                                    ],
                                  ).show();
                                  // _showAppBarIndicator(false);
                                } else {
                                  Navigator.pop(context);
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "Sorry",
                                    desc:
                                    "the product is not available at the moment",
                                    buttons: [
                                      DialogButton(
                                        color:Colors.redAccent,
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 60,

                                      )],
                                  ).show();
                                }
                              });
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NoInternet(test)));
                            }
                          })
                        }else{

                        }
                      });
                  print("dialog");
                });
              });
            }),
      ),
      //floatingActionButton: NavigationControls(_controller.future),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      drawer: store.drawermenu(context),
      // Container(
      //   color: MyApp.primarycolor,
      //   child: Container(
      //     width: 230,
      //     height: MediaQuery.of(context).size.height,
      //     child: ListView(
      //       children: <Widget>[
      //         Container(
      //           color: MyApp.primarycolor,
      //           child: DrawerHeader(
      //             decoration: BoxDecoration(
      //               image: DecorationImage(
      //                 image: ExactAssetImage('assets/images/makaya.png'),
      //               ),
      //             ),
      //           ),
      //         ),
      //         UserLoggedin,
      //         Container(
      //           color: MyApp.primarycolor,
      //           child: ListTile(
      //             title: Text(
      //               'Cart',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             leading: new Icon(
      //               Icons.shopping_cart,
      //               color: Colors.white,
      //             ),
      //             onTap: () {
      //               addCart().then((value) {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ViewCartItems()));
      //               });
      //             },
      //           ),
      //         ),
      //         Container(
      //           color: MyApp.primarycolor,
      //           child: ListTile(
      //             title: new Text(
      //               'Stores',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             leading: new Icon(Icons.store, color: Colors.white),
      //             onTap: () {
      //               Alert(
      //                 context: context,
      //                 type: AlertType.error,
      //                 title: "Sorry!!",
      //                 desc: "we'll be adding more stores soon!!",
      //                 buttons: [
      //                   DialogButton(
      //                     color:Colors.redAccent,
      //                     child: Text(
      //                       "OK",
      //                       style: TextStyle(
      //                           color: Colors.white, fontSize: 20),
      //                     ),
      //                     onPressed: () => Navigator.pop(context),
      //                     width: 60,
      //                   )
      //                 ],
      //               ).show();
      //
      //               // Navigator.push(context,MaterialPageRoute(builder: (context) => ViewCartItems()));
      //
      //               // Navigator.pop(context);
      //             },
      //           ),
      //         ),
      //         Container(
      //           color: MyApp.primarycolor,
      //           child: ListTile(
      //             title: new Text(
      //               'favourite',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             leading:
      //                 new Icon(FontAwesomeIcons.heart, color: Colors.white),
      //             onTap: () {
      //               addFav().then((sucess) {
      //                 print("adding to favorites");
      //
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ViewFavItems()));
      //               });
      //             },
      //           ),
      //         ),
      //         Container(
      //           child: isLoginText,
      //         )
      //
      //         /* ListTile(
      //
      //         title: new Text('Feedback'),
      //         leading: new Icon(Icons.feedback),
      //
      //         onTap: () {
      //
      //           Navigator.pop(context);
      //         },
      //       ),*/
      //         /*ListTile(
      //
      //         title: new Text('Account'),
      //         leading: new Icon(Icons.person),
      //
      //         onTap: () {
      //
      //           Navigator.pop(context);
      //         },
      //       ),*/
      //       ],
      //     ),
      //   ),
      // ),

      bottomNavigationBar: BottomBar(),
    );

    return webScreen;
  }

  bool _islogintrue = false;

  _checkState() {
    setState(() {
      if (MyApp.user != null) {
        UserLoggedin = ListTile(
          title: new Text(
            MyApp.user.email,
            style: TextStyle(color: Colors.white),
          ),
          leading: new Icon(
            Icons.person,
            color: Colors.white,
          ),
          onTap: () {
            if (MyApp.user != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            } else {}

            //  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        );
        print("doodh wari");

        isLoginText = ListTile(
          title: new Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          leading: new Icon(Icons.power_settings_new, color: Colors.white),
          onTap: () {
            Alert(
              context: context,
              type: AlertType.warning,
              title: "Logout",
              desc: "Are you sure you want to logout? ",
              buttons: [
                DialogButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    MyApp.user = null;
                    _checkState();
                    Navigator.pop(context);
                  },
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                ),
                DialogButton(
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(116, 116, 191, 1.0),
                    Color.fromRGBO(52, 138, 199, 1.0)
                  ]),
                )
              ],
            ).show();
          },
        );

        _islogintrue = true;
      } else {
        UserLoggedin = Container(
          height: 0.0,
        );

        isLoginText = ListTile(
          title: new Text("Login", style: TextStyle(color: Colors.white)),
          leading: new Icon(
            Icons.power_settings_new,
            color: Colors.white,
          ),
          onTap: () {
            if (MyApp.user != null) {
              /*
              Alert(
                context: context,
                type: AlertType.warning,
                title: "Logout",
                desc: "Are you sure you want to logout? ",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () =>  Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage())),
                    color: Color.fromRGBO(0, 179, 134, 1.0),
                  ),
                  DialogButton(
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(116, 116, 191, 1.0),
                      Color.fromRGBO(52, 138, 199, 1.0)
                    ]),
                  )
                ],
              ).show();
              */

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => signIn()));
            }

            //  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        );

        _islogintrue = false;
      }
    });
  }

  Future<void> navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack
          ? controller.goBack().then((value) {})
          : controller.goForward().then((val) {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sem histórico anterior")),
      );
    }
  }

  static showProgressDialog(BuildContext context, String title) {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Flexible(
                      flex: 8,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            );
          });
    } catch (e) {
      print(e.toString());
    }
  }
}

class MyStatefulWidget extends StatefulWidget {
  String name;
  List<a.Element> elements;
  EbayWebViewState ebayWebViewState;

  MyStatefulWidget(String name, List<a.Element> elements,
      EbayWebViewState ebayWebViewState) {
    this.name = name;
    this.elements = elements;
    this.ebayWebViewState = ebayWebViewState;
  }

  @override
  _MyStatefulWidgetState createState() =>
      _MyStatefulWidgetState(name, elements, ebayWebViewState);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String name;
  List<a.Element> elements;

  EbayWebViewState ebayWebViewState;

  _MyStatefulWidgetState(name, elements, EbayWebViewState ebayWebViewState) {
    this.ebayWebViewState = ebayWebViewState;

    this.name = name;
    this.elements = elements;
  }

  String feature = '- Select -';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: feature,
        items: elements.map((a.Element value) {
          return new DropdownMenuItem<String>(
            value: value.innerHtml,
            child: new Text(value.innerHtml),
          );
        }).toList(),
        onChanged: (String newValue) {
          setState(() {
            feature = newValue;
            ebayWebViewState.dropdownvalue[name] = newValue;
            print(ebayWebViewState.dropdownvalue[name]);
          });
        });
  }

/* return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );*/
}
