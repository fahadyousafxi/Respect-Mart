import 'dart:convert';
import 'package:device_id/device_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makaya/signInNew.dart';
import 'package:makaya/test.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'Api/Api.dart';
import 'main.dart';

class signUpNew extends StatefulWidget {
  @override
  _signUpNewState createState() => _signUpNewState();
}

class _signUpNewState extends State<signUpNew> {
  bool _passVisible=true;
  bool login=false;

  var heading="Create Account";
  var subHeading="Sign up to get started!";
  TextEditingController firstname=new TextEditingController();
  TextEditingController surname=new TextEditingController();
  TextEditingController Email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController confirmPass=new TextEditingController();
  TextEditingController mobile=new TextEditingController();
  final formKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
              children:[ Padding(
                padding: const EdgeInsets.symmetric(horizontal:30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text("$heading",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                    Text("$subHeading",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 40,),
                    textFields(firstname,"First name"),
                    textFields(surname,"Surname"),
                    textFields(mobile,"Mobile"),
                    textFieldsEmail(Email,"Email ID"),
                    textFieldsPass(password,"Password"),
                    textFieldsPass(confirmPass,"Retype Password"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            if(formKey.currentState.validate()){MyApp.showProgressDialog(context,"Signing up ...");
                            var email = Email.text;
                            var mobil = mobile.text;
                            var fname = firstname.text;
                            var sname = surname.text;
                            var pass = password.text;
                            var retype = confirmPass.text;
                            if(pass!=retype){
                              Navigator.pop(context);
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "ERROR",
                                desc: "Password dosent match",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "BACK",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }else{
                              Api.signUp(context, mobil, fname, sname, email, pass,retype).then((value) => {
                                  Api.login(context, email, pass),
                                Navigator.pop(context),
                              });
                            }
                            //session();
                            MyApp.aitems.clear();
                            }
                          },
                          //sign buttons
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.lightGreen),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                          child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Center(child: Text('Sign Up', style: TextStyle(color: Colors.white)))),
                        ),
                      ),
                    ),
                    /*   Container(
                    height: 50,
                    child: FlatButton(
                      //sign buttons
                      color: Colors.grey.withOpacity(0.3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.facebookSquare,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5,),
                              Text('Connect With Facebook', style: TextStyle(color: Colors.grey)),
                            ],
                          ))),
                    ),
                  ),*/
                    SizedBox(height:MediaQuery.of(context).size.height*0.25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: ()  {Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>signIn()));},
                          child: Text("SignIn ",style: TextStyle(
                              color: Colors.lightGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),]
          ),
        ),
      ),
    );
  }

  Widget textFields(TextEditingController _controller,var text,){
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        height: 50,
        child: TextFormField(

          controller:_controller,

          decoration: InputDecoration(

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius. circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius. circular(10.0),
            ),
            labelText: '$text',
            labelStyle: TextStyle(
                color:  Colors.grey,
                fontSize: 20
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
  Widget textFieldsEmail(TextEditingController _controller,var text,){
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        height: 50,
        child: TextFormField(
          validator: (value){
            if(value.isEmpty) {
              return "Please Fill this field";
            }else if(!value.contains("@")){
              return "Please enter valid email";
            }else if(!value.contains(".com")){
              return "Please enter valid email";
            };
          },
          controller:_controller,

          decoration: InputDecoration(

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius. circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius. circular(10.0),
            ),
            labelText: '$text',
            labelStyle: TextStyle(
                color:  Colors.grey,
                fontSize: 20
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
  Widget textFieldsPass(TextEditingController _controller,var text){
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        height: 50,
        child: TextFormField(
          validator: (value){
            if(value.isEmpty)
              return "Please Fill this field";
          },
          controller:_controller,
          obscureText: _passVisible,

          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passVisible = !_passVisible;
                });
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius. circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius. circular(10.0),
            ),
            labelText: '$text',
            labelStyle: TextStyle(
                color:  Colors.grey,
                fontSize: 20
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

}
