import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  IconData _eyeIcon = Icons.remove_red_eye;
  bool _isObscure = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.purpleAccent.shade700,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: SvgPicture.asset(
                  'Assets/Images/loginperson.svg',
                  width: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  suffixIcon: Icon(
                    Icons.mail,
                    color: Colors.purpleAccent.shade700,
                  ),
                  filled: true,
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 350,
              height: 50,
              child: TextField(
                controller: password,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  suffixIcon: IconButton(
                      icon: Icon(_eyeIcon, color: Colors.purpleAccent.shade700,),
                      onPressed: (){
                       setState(() {
                         if(_isObscure == true){
                           _isObscure = false;
                           _eyeIcon = Icons.visibility_off;
                         }
                         else{
                           _isObscure = true;
                           _eyeIcon = Icons.visibility;
                         }
                       });
                      }),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                onPressed: () async {
                  String enteredEmail = email.text.trim();
                  String enteredPassword = password.text.trim();
                  if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please Enter both Email and Password!!',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                    return;
                  }
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String savedEmail = '';
                  String savedPassword = '';

                  if (prefs.containsKey('email')) {
                    savedEmail = prefs.getString('email')!;
                  } else {
                    savedEmail = '';
                  }
                  if (prefs.containsKey('password')) {
                    savedPassword = prefs.getString('password')!;
                  } else {
                    savedPassword = '';
                  }
                  if (savedEmail == '' || savedPassword == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Account not fount! Please create account first!!!',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                    return;
                  }
                  if (enteredEmail == savedEmail &&
                      enteredPassword == savedPassword) {
                    if(!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Login Successfully!!',
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid email or password!!',style: TextStyle(
                      color: Colors.red
                    ),)));
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent.shade700,
                ),
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 280,
              child: Row(
                children: [
                  Expanded(child: Divider(thickness: 3)),
                  Text('OR'),
                  Expanded(child: Divider(thickness: 3)),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 17),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      ' Sign Up',
                      style: TextStyle(
                        color: Colors.purpleAccent.shade700,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
