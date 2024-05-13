import 'dart:async';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterfirst/loginpage.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2),(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff30cfd0),
              Color(0xff330867),

            ]
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/pngfirst.png'),

              Text("Eventify",style: TextStyle(fontWeight:FontWeight.bold,fontSize:50 ,color:Colors.purple.shade400     ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: Text("(Plan, Manage, Celebrate)",style:TextStyle(fontWeight:FontWeight.bold,fontSize:25 ,color:Colors.purpleAccent.shade700  ),),
              ),
            ],
          ),


          
        ),
      ),

    );
  }
}
