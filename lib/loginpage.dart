import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfirst/Splashscreen.dart';
import 'package:flutterfirst/homepage.dart';
import 'package:flutterfirst/uihelper.dart';
class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController PassswordController=TextEditingController();
  login(String email,String password)async{
    if (email=="" || password=="")
    {
      return Uihelper.Customalertbox(context, "Enter fields");
    }
    else{
      UserCredential? usercrediential;
      try {
        usercrediential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage())));
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.Customalertbox(context, ex.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      resizeToAvoidBottomInset:false ,
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:const Color(0xff330867) ,
        title:const  Text("Eventify",style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white ) ,),
        centerTitle: true,
      ),
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff30cfd0),
              Color(0xff330867),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(height: 5,),
            ConstrainedBox(constraints: const BoxConstraints(
              maxWidth:350,
              minWidth: 350,
              maxHeight: 250,
              minHeight: 200,

            ),
              child:Image.asset('assets/pngfirst.png'),


            ),
            // SizedBox(height: 20,),
            Uihelper.Customtextfield(emailController, "Email", Icons.mail, false),
           const  SizedBox(height: 10,),
            Uihelper.Customtextfield(PassswordController, "Password", Icons.password, true),
           const  SizedBox(height: 10,),
            Uihelper.custombutton(() {login(emailController.text.toString(),PassswordController.text.toString()); }, "Login"),
           const  SizedBox(height: 5),
            Row(
              mainAxisAlignment:MainAxisAlignment.center ,
              children: [
               const  Text("New to Eventify??",style:TextStyle(fontSize: 15,color:Colors.white ) ,),

                //////SIGNUP BUTTON INCOMPLETE::::
                TextButton(onPressed: (){}, child: Text("SignUp" ,style:TextStyle(decoration:TextDecoration.underline,decorationColor:Colors.white  ,color:Colors.indigo.shade200,fontWeight: FontWeight.bold, ) ,))
              ],
            )


          ],
        ),
      ),
    );
  }
}
