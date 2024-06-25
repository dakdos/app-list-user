import 'package:flutter/material.dart';
import '/config/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  SplashScreenState createState() =>  SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>  {
  
  _startLaunching() {
    const duration =  Duration(milliseconds: 500);
    return Timer(duration, () {
        Navigator.pushNamedAndRemoveUntil(context, '/list_user', (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    _startLaunching();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/logo/logo.png',
                      fit: BoxFit.contain,
                      width: 200,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}