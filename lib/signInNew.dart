import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makaya/signUpNew.dart';

import 'Api/Api.dart';
import 'main.dart';

class signIn extends StatefulWidget {
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  bool _passVisible=true;
  var heading="Welcome,";
  var subHeading="Sign in to continue!";
  var showError=false;
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
              children:[ Container(
                child: Padding(
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

                      Padding(
                        padding: const EdgeInsets.only(bottom:10.0,top: 90),
                        child: textFields(loginEmailController,"Email ID"),
                      ),
                      textFieldsPass(loginPasswordController,"Password"),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forget Password",style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:60.0,bottom: 10),
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed:()
                            {

                             if(formKey.currentState.validate()) {
                              MyApp.showProgressDialog(
                                  context, "Logging in...");
                              Api.login(context, loginEmailController.text,
                                  loginPasswordController.text);
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
                                child: Center(child: Text('Log In', style: TextStyle(color: Colors.white)))),

                          ),
                        ),
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height*0.35,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have an account?",style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: ()  {Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>signUpNew()));},
                            child: Text("Signup ",style: TextStyle(
                                color: Colors.lightGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ]
          ),
        ),
      ),
    );
  }
  Widget textFields(TextEditingController _controller,var text,){
    return Container(
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
    );
  }

Widget textFieldsPass(TextEditingController _controller,var text){
  return Container(
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
  );
}
}
