import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:idp_group15/Homepage/homebackground.dart';
import 'package:idp_group15/Homepage/popup.dart';
import 'package:idp_group15/Setting/Setting.dart';


class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBackground(
        child: SafeArea(
          child: Stack(
          children: <Widget>[

            //welcome text
            Container(
              alignment: Alignment(0,-0.79),
              child: Container(
                width: 200,height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: const BorderRadius.all(const Radius.circular(20))
                ),
                child: Text(
                  'SMAP-FIX',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 35, 
                    color: Colors.black, 
                    fontWeight: FontWeight.w500
                    ),
                ),
              ),
            ),

            //SettingButton
            new Container(
              child: Positioned(
                top: 20,left: 20,
                child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting()));
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Image.asset(
                      'assets/images/setting.png',
                      fit: BoxFit.scaleDown,
                    ),
                    padding: EdgeInsets.all(3.0),
                    shape: CircleBorder(),
                  ),
              ),
            ),
            
            //Question
            new Container(
              child: Positioned(
                top: 20,right: 20,
                child: RawMaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Popup(),
                      );
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Image.asset(
                      'assets/images/question.png',
                      fit: BoxFit.scaleDown,
                    ),
                    padding: EdgeInsets.all(3.0),
                    shape: CircleBorder(),
                  ),
              ),
            ),

            //postureAngle
            new Container(
              alignment: Alignment(0,-0.25),
              child: CircleAvatar(
                radius: 130.0,
                backgroundColor: Color(0xff00a896),
                child: CircleAvatar(
                  radius: 120.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 100.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}