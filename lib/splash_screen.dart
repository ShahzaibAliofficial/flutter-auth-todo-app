import 'dart:async';

import 'package:flutter/material.dart';
import 'Signup_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen(),
      ));
    }

    );
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Image.asset('Assets/Images/Splash_logo.png'),
      ),
    );
  }
}