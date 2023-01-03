import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:idp_group15/Homepage/checkConnection.dart';

import './homebackground.dart';
import './popup.dart';
import 'package:idp_group15/Setting/Setting.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  bool isReady;
  Stream<List<int>> stream;
  List<double> traceDust = List();

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  connectToDevice() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    new Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        _Pop();
      }
    });

    await widget.device.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _Pop();
    }
    widget.device.disconnect();
    
  }

  discoverServices() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;

            setState(() {
              isReady = true;
            });
          }
        });
      }
    });

    if (!isReady) {
      _Pop();
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) =>
            new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to disconnect device and exit?'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No')),
                new FlatButton(
                    onPressed: () {
                      disconnectFromDevice();
                      Navigator.of(context).pop(true);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => checkConnection()));
                    },
                    child: new Text('Yes')),
              ],
            ) ??
            false);
  }

  _Pop() {
    Navigator.of(context).pop(true);
  }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
      initialData: BluetoothState.on,
      builder: (c, snapshot){
        final state = snapshot.data;
            if (state == BluetoothState.off) {
              widget.device.disconnect();
              return checkConnection();
            }
            return WillPopScope(
              onWillPop: _onWillPop,
                child: Scaffold(
                body: HomeBackground(
                  child: SafeArea(
                    child: !isReady ? Center(
                              child: Text(
                                "Waiting...",
                                style: TextStyle(fontSize: 24, color: Colors.red),
                              ),
                            )
                  : Stack(
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
                              fontSize: 35,
                              fontFamily: 'Montserrat', 
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

                      //angle
                      StreamBuilder<List<int>>(
                              stream: stream,
                              builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot){
                                  if (snapshot.hasError)
                                    return Text('Error: ${snapshot.error}');
                                  
                                  if (snapshot.connectionState == ConnectionState.active) {
                                    var currentValue = _dataParser(snapshot.data);
                                    var currentColor = 0xff7e7e7e;

                                    if(currentValue == '110' || currentValue == '109' || currentValue == '108'|| currentValue == '107' || currentValue == '106' || currentValue == '105'
                                    || currentValue == '104' || currentValue == '103' || currentValue == '102' || currentValue == '101' || currentValue == '100' || currentValue == '99'
                                    || currentValue == '98' || currentValue == '97' || currentValue == '96' || currentValue == '95' || currentValue == '94' || currentValue == '93'
                                    || currentValue == '92' || currentValue == '91' || currentValue == '90' || currentValue == '89' || currentValue == '88' || currentValue == '87' 
                                    || currentValue == '86' || currentValue == '85'){

                                      currentColor = 0xff00ff00;
                                    }else{
                                      currentColor = 0xffff0000;
                                    }

                                    return Container(
                                      alignment: Alignment(0,-0.25),
                                      child: !isReady ? Container(
                                        child: Text('Waiting...',
                                        style: TextStyle(fontSize: 24, color: Colors.red),),
                                      ): CircleAvatar(
                                        radius: 130.0,
                                        backgroundColor: Color(currentColor),
                                        child: new CircleAvatar(
                                          radius: 120,
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            '${currentValue}°',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 100,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                            ),
                                          ),
                                        ),
                                      )
                                    );
                                  }else{
                                    Text(
                                      'Check',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 60,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                      ),
                                    );
                                  }
                              },
                      ),

                      // //reset button
                      // Container(
                      //   alignment: Alignment(0,0.28),
                      //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      //   child: RaisedButton(
                      //     onPressed:(){},
                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      //     textColor: Colors.white,
                      //     padding: const EdgeInsets.all(0),

                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       height: 40.0, width: 110,
                      //       decoration: new BoxDecoration(
                      //         borderRadius: BorderRadius.circular(80.0),
                      //         color: Color(0xff2661fa).withOpacity(0.8),
                      //       ),
                      //       padding: const EdgeInsets.all(0),
                      //       child: Text(
                      //         'RESET',
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(
                      //           fontFamily: 'Lato',
                      //           fontSize: 25,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //Sitting
                      Container(
                        alignment: Alignment(0.45,0.80),
                        child: SizedBox(
                            width: 70.0,height: 180.0,
                            child: new Container(
                              alignment: Alignment(0.0,-0.9),
                              decoration: BoxDecoration(
                                color: Color(0xffedb236),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              
                              child: new Container(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children:<Widget>[
                                    Positioned(
                                      top: 5,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          'assets/images/sit.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 60,
                                      child: Text(
                                        '6.5',
                                        style: TextStyle(
                                          fontSize:35,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 25,
                                      child: Text(
                                        'HOURS',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ),
                          ),
                      ),

                      //Walking
                      Container(
                        alignment: Alignment(-0.45,0.80),
                        child: SizedBox(
                            width: 70.0,height: 180.0,

                            child: new Container(
                              decoration: BoxDecoration(
                                color: Color(0xffedb236),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),],
                              ),

                              child: new Container(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children:<Widget>[
                                    Positioned(
                                      top: 5,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          'assets/images/walk.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 60,
                                      child: Text(
                                        '3.5',
                                        style: TextStyle(
                                          fontSize:35,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 25,
                                      child: Text(
                                        'HOURS',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
    );
    

  }

}