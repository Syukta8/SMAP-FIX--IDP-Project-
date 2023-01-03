import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:idp_group15/Homepage/checkConnection.dart';

// ignore: unused_import
import 'package:idp_group15/Homepage/home_page.dart';
import './Homepage/bluetoothOFF.dart';
import './Homepage/intro.dart';
// import 'Login/login_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) => MaterialApp(
     title: 'SMAP-FIX',
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
        primaryColor: Color(0xFF4EBBA3),
     ),
    home: checkConnection(), 
   );
}