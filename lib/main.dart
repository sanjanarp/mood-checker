import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './smiley_controller.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: Color.fromRGBO(238, 255, 249, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mood Checker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _rating = 5.0;
  String _currentAnimation = "5+";
  SmileyController _smileyController = SmileyController();


  _message() {
    String message;
    setState(() {
      if(_rating >= 4.0)
      {
       message ="Share your happiness!";
      }
      if(_rating == 3.0)
      {
       message = "Time to get some work done!";
      }
      if(_rating <= 2.0)
      {
       message = "Reminder: Drink some water";
      }
    });
    return message;
  }


  String _mood(){
    String mood = "hello";
    setState(() {
      if(_rating == 5.0)
      {
          mood = "Very Happy";
      }
      if(_rating == 4.0)
      {
        mood = "Happy";
      }
      if(_rating == 3.0)
      {
        mood = "Neutral";
      }
      if(_rating == 2.0)
      {
        mood = "Sad";
      }
      if(_rating == 1.0)
      {
        mood = "Very Sad";
      }
    });
    return mood;

  }

  void _onChanged(double value){
    if(_rating==value) return;

    setState(() {
      var direction = _rating<value ? '+':'-';
      _rating = value;
      _currentAnimation ='${value.round()}$direction';
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: FlareActor(
                    "assets/happiness_emoji.flr",
                   alignment: Alignment.center,
                   fit: BoxFit.contain,
                  controller: _smileyController,
                  animation:_currentAnimation,
                ),
              height: 300,
              width: 300,
            ),
            Slider(
              value: _rating,
              divisions: 4,
              onChanged: _onChanged,
              max: 5,
              min: 1,
              label: _mood(),
            ),
            Text(
              '$_rating',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 60,
            ),
            RaisedButton(

              onPressed: () =>  showInfoFlushBar(),
              color: Colors.purple,
                splashColor: Colors.pink,
              elevation: 10,
              child: Text("OK", style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
              padding: EdgeInsets.all(15),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(45),
                 side: BorderSide(
                   color: Colors.white,
                    width: 4
                 )
               )
            ),
          ],
        ),
      ),
   );
  }


  void showInfoFlushBar() {
    Flushbar(
      title: "Tip:",
      message: _message(),
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue,
      ),
      leftBarIndicatorColor: Colors.blue,
      duration: Duration(seconds: 3),
    )..show(context);
  }

}

