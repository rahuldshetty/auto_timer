import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(TimerApp());

class MyApp extends State<TimerApp> {
  // This widget is the root of your application.

  static const duration = const Duration(seconds: 1);

  Timer timer;

  int secondsPassed = 0;
  bool isActive = false;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if(timer==null){
      timer = Timer.periodic(duration, (Timer t){
        handleTick();
      });
    }

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(label: 'HRS', value: hours.toString().padLeft(2,'0')),
                  CustomTextContainer(label: 'MIN', value: minutes.toString().padLeft(2,'0')),
                  CustomTextContainer(label: 'SEC', value: seconds.toString().padLeft(2,'0'))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top:20),
                child: RaisedButton(
                  child: Text(isActive ? 'STOP' : 'START'),
                  onPressed: (){
                      setState(() {
                        isActive = !isActive;
                      });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:20),
                child: RaisedButton(
                  child: Text('RESET'),
                  onPressed: (){
                    setState(() {
                      isActive = false;
                      secondsPassed = 0;
                    });
                  },
                ),
              )
            ],
          )
        )
      )
    );
  }
}

class TimerApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyApp();
  }
}

class CustomTextContainer extends StatelessWidget{

  final String value, label;

  CustomTextContainer({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87
      ),
      child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$value',
              style: TextStyle(
                color: Colors.white,
                fontSize: 54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$label',
              style: TextStyle(
                color: Colors.white70,
              ),
            )
          ],
        )
    );
  }
}
