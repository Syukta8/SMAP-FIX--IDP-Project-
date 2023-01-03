import 'package:flutter/material.dart';

class Popup extends StatefulWidget{
  const Popup();
  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup>{
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'About SMAP-FIX',
        style: TextStyle(
          color: Color(0xff2661fa),
        ),
        ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
        ],
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Color(0xff00a896),
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }

  Widget _buildAboutText() {
    return new RichText(
      text: new TextSpan(
        text: 'With SMAP-FIX, you are one step closer to being the best version of yourself. SMAP-FIX allows you to live a healthy life. It enables you to keep track of your previous and current posture in order to easily adjust your habits and strengthen your posture. You can lead a horse to the river but not force it to drink.\n',
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}