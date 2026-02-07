import 'package:flutter/material.dart';
import 'splash_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget{
  const ToDoApp({super.key});

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}
