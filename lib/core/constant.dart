   import 'package:flutter/material.dart';

   final darkTheme = ThemeData(
     scaffoldBackgroundColor: Colors.blue.withOpacity(0.9),
     primarySwatch: Colors.grey,
     primaryColor: Colors.white,
     brightness: Brightness.dark,
     backgroundColor: const Color(0xFF212121),
     accentColor: Colors.white,
     accentIconTheme: IconThemeData(color: Colors.black),
     dividerColor: Colors.black12,
     textTheme:const TextTheme(
       bodyText1: TextStyle(color: Colors.white,fontSize: 25),
       bodyText2: TextStyle(color: Colors.white,fontSize: 12),
       headline1: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold),
     ),
   );

   final lightTheme = ThemeData(


     primarySwatch: Colors.grey,
     primaryColor: Colors.white,
     brightness: Brightness.light,
     backgroundColor: const Color(0xFFE5E5E5),
     accentColor: Colors.black,
     accentIconTheme: IconThemeData(color: Colors.white),
     dividerColor: Colors.white54,
   );

customShowDialog(BuildContext context,String text){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
        );
      });

}




