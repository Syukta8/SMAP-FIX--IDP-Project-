import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:idp_group15/Homepage/bluetoothOFF.dart';
import 'package:idp_group15/Homepage/intro.dart';

class checkConnection extends StatefulWidget{
  @override
  _checkConnection createState() => _checkConnection();
}

class _checkConnection extends State<checkConnection>{

  @override 
  Widget build(BuildContext context){
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return trialHome();
            }
            return BluetoothOffScreen(state: state);
          }
    );
  }
}