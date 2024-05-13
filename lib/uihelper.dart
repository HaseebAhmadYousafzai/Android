import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uihelper{
  static Customtextfield(TextEditingController controller,String text,IconData iconData,bool Tohide) {
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: Tohide,
        decoration: InputDecoration(


            hintText: text ,
            suffixIcon: Icon(iconData),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25)
            )

        ),
      ),
    );
  }
  static Customalertbox(BuildContext context,String text)
  {
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK")
          )],
      );
    });
  }


  static custombutton(VoidCallback voidCallback,String text)
  {
    return SizedBox(

      height: 50,
      width: 150,

      child: ElevatedButton(

        onPressed:() {voidCallback();},
        style: ElevatedButton.styleFrom(

          backgroundColor: Color(0xff330867),

        ),

            child: Text(text,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold )),

      ),
    );
  }

}