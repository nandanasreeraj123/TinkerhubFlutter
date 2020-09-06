import 'package:flutter/material.dart';
import 'package:tinkerhubflutter1/screens/form/forms.dart';
import 'package:tinkerhubflutter1/screens/homepage.dart';
import 'package:tinkerhubflutter1/screens/showdetails/showalldetails.dart';
import 'screens/homepage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        ShowAllDetail.routeName: (context)=>ShowAllDetail(),
        FormPage.routeName: (context)=>FormPage(),

      },
      home: Homepage()
    );
  }
}

