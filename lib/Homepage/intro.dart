import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import './homebackground.dart';
import './popup.dart';
import './BondedDevice.dart';
import 'package:idp_group15/Setting/Setting.dart';

class trialHome extends StatefulWidget {
  @override
  _trialHome createState() => _trialHome();
}

class _trialHome extends State<trialHome>{

  final FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) =>
            new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit?'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No')),
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    child: new Text('Yes')),
              ],
            ) ??
            false);
  }

  @override 
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      body: HomeBackground(
        child: SafeArea(
          child: Stack(
          children: <Widget>[

            //SMAP-FIX
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
            Container(
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
            Container(
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

            //ExploreDevice
            Container(
              alignment: Alignment(0,0.45),
              child: RaisedButton(
                onPressed: () async{
                  final BluetoothDevice Mydevice = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context){
                      return BondedDevicePage();
                    })
                  );

                  if (Mydevice != null){
                    print('Connect -> selected');
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.black,
                padding: const EdgeInsets.all(0),

                child: Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  width: size.width * 0.45,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    color: Color(0XFFEDB230),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    'Explore Device',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
            ),

            //postureAngle
            Container(
              alignment: Alignment(0,-0.25),
              child: CircleAvatar(
                radius: 130.0,
                backgroundColor: Colors.blueGrey,
                child: new CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/smap_fix.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              ),

          ],
        ),
        ),
      ),
    ),
  );
      
  }
}