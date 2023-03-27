import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatrack/constants/colors.dart';
import 'package:whatrack/views/home_view.dart';

import '../auth/auth.dart';
import '../models/userModel.dart';
import '../shared/loading.dart';
import '../shared/toast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false;
  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.black,
      fontSize: 16,
      backgroundColor: Colors.grey[200],
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user;
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroundDark.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      SizedBox(
                        height: 150,
                        child: Image.asset('assets/images/logo_circle.png'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'WhatTrack',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Welcome, You have been \nmissed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'DMMono',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          controller: _email,
                          style:
                              const TextStyle(color: CustomColors.blackPurple),
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            hintStyle:
                                const TextStyle(color: CustomColors.darkPurple),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: CustomColors.accentPurple,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          controller: _password,
                          style:
                              const TextStyle(color: CustomColors.blackPurple),
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            hintStyle:
                                const TextStyle(color: CustomColors.darkPurple),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: CustomColors.accentPurple,
                                width: 3,
                              ),
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() => loading = true);
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            final String email = _email.text.trim();
                            final String password = _password.text.trim();
                            user = await Auth().signIn(email, password);
                            print(user);
                            if (user == null) {
                              toast("Invalid Username or Password");
                              print('Loggin failed');
                              setState(() {
                                loading = false;
                              });
                              return;
                            }
                            // Home(user!);
                            sharedPreferences.setString('email', email);
                            Navigator.pushNamed(context, '/home');
                            print('Successfully logged In');
                            setState(() {
                              loading = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 22),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'DMMono',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/forgot'),
                        child: const Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Forgot Password',
                              style: TextStyle(
                                fontFamily: 'DMMono',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: const Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Not a Member yet? ',
                              style: TextStyle(
                                fontFamily: 'DMMono',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Register Now',
                                  style: TextStyle(
                                    fontFamily: 'DMMono',
                                    fontSize: 12,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
