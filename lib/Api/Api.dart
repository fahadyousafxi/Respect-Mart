

import 'dart:convert';
import 'dart:io';

import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../User.dart';
import '../models/listAttributes.dart';
import '../main.dart';

class Api {

  static Future <bool> addFav () async
  {
    String device_id=await DeviceId.getID;
    String str="";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id=pref.getString("id");
    str +=jsonEncode(MyApp.witems.map((f)=>f.toJsonAttr(id)).toList());
    print(str);

    final response = await http.post(
        MyApp.base_url+"/favorite",
        body: jsonEncode({
          "data":str,
          "deviceId":device_id}
        ), headers: {
      HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
      HttpHeaders.contentTypeHeader:"application/json"
    });

    print(response.body);
    var data = json.encode(response.body);

    print(data);


    return true;

  }
  static Future Shipment () async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id=pref.getString("id");
    String device_id=await DeviceId.getID;
    String str="";
    str +=jsonEncode(MyApp.aitems.map((f)=>f.toJsonAttr(id)).toList());
    print(str);
    print(jsonEncode({
      "data":str,
      "device_id":"$device_id"
    }));
    final response = await http.post(
        MyApp.base_url+"/place/order",
        body: jsonEncode({
          "data":str,
          "device_id":"$device_id"
        }), headers: {
      HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
      HttpHeaders.contentTypeHeader:"application/json"
    });

    print(response.statusCode);
    var data = json.decode(response.body);

    print("........................................................................................................................."+response.body.toString());
    if(data['status']==true)
    return data['url'];
    else
      return false;

  }
  static Future <bool> login (context,String email,String pass) async
  {

    final response = await http.post(
        MyApp.base_url+"/login",
        body: {
          "email": email.toString(),
          "password": pass.toString(),
        });
    var data = json.decode(response.body);
    print(response.body+" "+response.statusCode.toString());
    print(data["user"]);

    if (data["status"] != false) {
      MyApp.user = new User(
          data["user"]["id"].toString(), data["user"]["name"], data["user"]["email"],
          data["user"]["address"]);
      MyApp.login=true;
      session(data["user"]["id"]);
      Navigator.pop(context);
      Navigator.pop(context);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("login",true);
      pref.setString("id", data["user"]["id"].toString());
      pref.setString("name", data["user"]["name"].toString());
      pref.setString("email", data["user"]["email"].toString());
      pref.setString("address", data["user"]["address"].toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('LogIn Successfully',textAlign: TextAlign.center,),
            backgroundColor:Colors.lightGreen ,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ));
      return true;
    }
    else {

      Navigator.pop(context);

      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "Name or Password is incorrect.",
        buttons: [
          DialogButton(
            color: Colors.redAccent,
            child: Text(
              "BACK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      return false;
    }
    /* Map<String, dynamic> user = jsonDecode(data);

            print('Howdy, ${user['name']}!');
            print('We sent the verification link to ${user['email']}.');*/



  }


  static  Future <List> session (int userid) async
  {
    String device_id=await DeviceId.getID;
    var now = new DateTime.now();
    final response = await http.post(
        MyApp.base_url+"/create/session",
        body: {
          "device_id":device_id ,
          "userid":userid.toString(),
          "date": new DateFormat("dd-MM-yyyy").format(now),
        });


  }
  static  Future <List> signUp (context,String mobile,String fname,String sname,String email,String password,String retype) async
  {
    if(password != retype){
      Navigator.pop(context);
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "Password And ReType Do Not Match!!!",
        buttons: [
          DialogButton(
            color: Colors.redAccent,
            child: Text(
              "BACK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      return [];
    }

    final response = await http.post(
        "https://app.respectmart.com/api/register",
        body:jsonEncode( {
          "first_name": fname,
          "surname": sname,
          "email": email,
          "mobile":mobile,
          "password": password,
        }),
      headers: {
          HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
        HttpHeaders.contentTypeHeader:"application/json"
      }

        );
    print(jsonEncode(response.statusCode));
    print(response.body);

    var data = jsonDecode(response.body);
    print(data);
    if(data["success"]!=true)
    {
      // Alert(
      //   context: context,
      //   type: AlertType.success,
      //   title: "Success",
      //   desc: "Account Created you can Login now!!",
      //   buttons: [
      //     DialogButton(
      //       child: Text(
      //         "BACK",
      //         style: TextStyle(color: Colors.white, fontSize: 20),
      //       ),
      //       onPressed: () => Navigator.pop(context),
      //       width: 120,
      //     )
      //   ],
      // ).show();

    }
    else
    {
      Navigator.pop(context);
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: data["error"],
        buttons: [
          DialogButton(
            color: Colors.redAccent,
            child: Text(
              "BACK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }


  }

  static Future <bool> addCart () async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id=pref.getString("id");
    String device_id=await DeviceId.getID;
    String str="";
    str +=jsonEncode(MyApp.aitems.map((f)=>f.toJsonAttr(id)).toList());
    print('id: $id Str is : $str ');

    final response = await http.post(
        MyApp.base_url+"/cart",
        body:jsonEncode( {
          "device_id":device_id,
          "data":str,
        }),
        headers: {
    HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
    HttpHeaders.contentTypeHeader:"application/json"
    }
        );
    print(device_id+response.statusCode.toString());
    print(response.body+response.statusCode.toString());
    var data = json.encode(response.body);

    print(' data is : $data ${response.statusCode}');

    return true;

  }

  static  Future<List<all_listAttributes>> getFav() async
  {
    String device_id=await DeviceId.getID;

    print(MyApp.base_url+"/get_favorite?"+device_id);

    var favs=await http.get(MyApp.base_url+"/fav.php"+device_id, headers: {
      HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
      HttpHeaders.contentTypeHeader:"application/json"
    });
    var jsonData=json.decode(favs.body);

    print(jsonData);

    List<all_listAttributes> favor = List();

    if(jsonData["success"]!=null)
      for(var m in jsonData["success"])
      {
        all_listAttributes item=new all_listAttributes(m["name"],m["price"],m["type"],int.parse(m["quantity"]),m["wegiht"],m["color"],m["image"],m["merchant"],m["size"],m["url"]);
        favor.add(item);
        print(m["name"]);

      }
    MyApp.witems = favor;
    return MyApp.witems;
  }

  static  Future<bool> deleteItem(int index) async {
    String device_id=await DeviceId.getID;
    final response = await http.post(
        MyApp.base_url+"/User/deleteFavItem",
        body: jsonEncode({
          "name":MyApp.witems[index].title,
          "deviceId":device_id
        },),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
          HttpHeaders.contentTypeHeader:"application/json"
        }
    );  // make DELETE request
    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);
    return true;
  }

  static  Future<List<all_listAttributes >> getCart() async
  {
    String device_id=await DeviceId.getID;

    var carts=await http.get(MyApp.base_url+"/get_cart?"+device_id, headers: {
      HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
      HttpHeaders.contentTypeHeader:"application/json"
    });
    var jsonData=json.decode(carts.body);
    print(jsonData);

    List<all_listAttributes > cart = List();

    if(jsonData["success"]!=null)
      for(var m in jsonData["success"])
      {
        all_listAttributes  item=new all_listAttributes (m["name"],m["price"],m["type"],int.parse(m["quantity"]),m["weight"],m["color"],m["image"],m["merchant"],m["size"],m["url"]);
        cart.add(item);
        print(m["name"]);

      }
    MyApp.aitems = cart;
    return MyApp.aitems;
  }
  static Future<bool> deleteCartItem(int index) async {
    String device_id=await DeviceId.getID;
    final response = await http.post(
        MyApp.base_url+"/User/deleteCartItem",
        body:jsonEncode( {
          "name":MyApp.aitems[index].title,
          "deviceId":device_id
        }),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2I0Y2RmMTM4OThjNTVmNTliNDdiZjcyZjMwN2ZmODdiZTM1MmJjNzc2M2RkMGE5YzMxODQyMzdiM2JjY2YyOTA0ODUyM2NiNzliMTZhMGIiLCJpYXQiOjE2NDE4MDA1OTAuNzMwMDUyLCJuYmYiOjE2NDE4MDA1OTAuNzMwMDU1LCJleHAiOjE2NzMzMzY1OTAuNzIwMDk5LCJzdWIiOiI0MiIsInNjb3BlcyI6W119.TSrpoA_p8rL2gCizDU5O1VBAUvb1iVw1lPeR4Y4CA08NoZj8F2lHLxfJ7wBBk05CvtqitzPDXMHzUnNY1TC1W830EHYRY8ieqoNj_3VbAWFmle4yKqEub3zhQFtCIGuqNfWNWM6NLfgqky7Fl7nAfS4N0iW5WZDpduD1pL4rOX2GHO2z38kjjHGvaRdX9I8dKj1b8dJDgzcoU2EqOAsvnt4Kcasczi75J5h8K1o-2-NhN8vsWQSvWzd7dHLxHhuleghcllNc17GF3ivNn0Yhia3xTsMnesqu4IcDOi2KWwmj-Ffl-Uy-3INeDCe2WIxiLPsPa-vDJeOfyNmPZi6bEFLE2KlgsRns-weheg5Ie3b4lo8mhiWCAZV_z5yvw62bR2n_ZFaCET6_2fkSGVoVhSf7ff2qMd7nt3e9X7eOpNZ1Yt7mxuD4LhMwt0-Jwosy94lO3Xu6fru53n1ef8J5FGdtagPeY9ut1921XbaOdnDBTsmWKHmuney3m5jTpm9fIMUDFWZEWqPGWjSvAuax9ASpjBYeJPA5nqy3Udez_da3IEX70U2BkU59RvBEl2WChIlDM-uoFMKZuBj28VdhYyYSogz8jWekXSfiaF63pe9BLvQjsWvSVdmEJw8JHyXNLJQ5ybM4PiyXGQfPJwyl0nQxFa_M1cyLY22YSg5VRKM",
          HttpHeaders.contentTypeHeader:"application/json"
        }
    );  // make DELETE request
    int statusCode = response.statusCode;
    print(statusCode);
    return true;
  }



}