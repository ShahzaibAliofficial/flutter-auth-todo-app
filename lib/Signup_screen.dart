import 'package:flutter/material.dart';
import 'Login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen>{
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  IconData _eyeIcon = Icons.visibility_off;
  bool _isObscure = true;
  bool _isObscure1 = true;
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
      ),
      body:
           SingleChildScrollView(
             child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: Text("Let's Get Started",style: TextStyle(fontSize: 30),)),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: name, 
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: Colors.black
                        ),
                        suffixIcon: Icon(Icons.person,color: Colors.purpleAccent.shade700,),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                   width: 350,
                    height: 50,
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        filled: true,
                        suffixIcon: Icon(Icons.email,color: Colors.purpleAccent.shade700,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                   height: 30,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: password,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        suffixIcon:IconButton(
                            icon: Icon(_eyeIcon,color: Colors.purpleAccent.shade700,),
                            onPressed: (){
                              setState(() {
                                if(_isObscure == true){
                                  _isObscure = false;
                                  _eyeIcon = Icons.visibility;
                                } else{
                                  _isObscure = true;
                                  _eyeIcon = Icons.visibility_off;
                                }
                              });
                            },) ,
                        labelStyle: TextStyle(
                          color: Colors.black
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: confirmPassword,
                      obscureText: _isObscure1,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: Colors.black
                        ),
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(_eyeIcon,color: Colors.purpleAccent.shade700,),
                          onPressed: (){
                            setState(() {
                              if(_isObscure1 == true){
                                _isObscure1 = false;
                                _eyeIcon = Icons.visibility_off;
                              }
                              else{
                                _isObscure1 = true;
                                _eyeIcon = Icons.visibility;
                              }
                            });
                          }),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(onPressed: () async {
                      try {

                        if(name.text.isEmpty ||
                            email.text.isEmpty ||
                            password.text.isEmpty ||
                            confirmPassword.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill all fields')),
                          );
                          return;
                        }

                        if(password.text != confirmPassword.text){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Password don't match")),
                          );
                          return;
                        }

                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setString('name', name.text.trim());
                        await prefs.setString('email', email.text.trim());
                        await prefs.setString('password', password.text.trim());

                        if(!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign Up Successfully')),
                        );

                        await Future.delayed(Duration(seconds: 1));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );

                      } catch (e) {

                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );

                      }
                    }

                    ,style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent.shade700,
                    ), child: Text('Sign Up',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                    )
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 280,
                    child: Row(
                      children: [
                        Expanded(child: Divider(
                          thickness: 3,
                        )),
                        Text('  OR  '),
                        Expanded(child: Divider(
                          thickness: 3,
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',style: TextStyle(
                        fontSize: 17,
                      ),),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                        child: Text(' Sign In',style: TextStyle(
                          color: Colors.purpleAccent.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
           ),
    );
  }
}