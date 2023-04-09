import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../auth/auth.dart';
import '../constants/colors.dart';
import '../models/userModel.dart';
import '../shared/loading.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _name = TextEditingController();
  String? _gender;
  bool loading = false;

  final List<String> _genders = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    _gender = _genders[0];

    String datetime = DateTime.now().toString();
    print(datetime);
  }

  bool emailValidator(email) {
    final bool isValid = EmailValidator.validate(email);
    return isValid;
  }

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
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// Logo and Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 80,
                              child:
                                  Image.asset('assets/images/logo_circle.png'),
                            ),
                            const SizedBox(
                              width: 20,
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
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Welcome message
                        const Text(
                          'It\'s your First Time! \nSign Up with us.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DMMono',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 25),

                        /// Email
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: _email,
                            style: const TextStyle(
                                color: CustomColors.blackPurple),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                  color: CustomColors.darkPurple),
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
                        const SizedBox(height: 8),

                        /// Password
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: _password,
                            style: const TextStyle(
                                color: CustomColors.blackPurple),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                  color: CustomColors.darkPurple),
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
                        const SizedBox(height: 8),

                        /// Confirm Password
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: _confirmPassword,
                            style: const TextStyle(
                                color: CustomColors.blackPurple),
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                  color: CustomColors.darkPurple),
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
                        const SizedBox(height: 8),

                        /// Profile Name
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: _name,
                            style: const TextStyle(
                                color: CustomColors.blackPurple),
                            decoration: InputDecoration(
                              hintText: 'Profile Name',
                              hintStyle: const TextStyle(
                                  color: CustomColors.darkPurple),
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
                        const SizedBox(height: 8),

                        /// Gender
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          // color: Colors.white,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              RadioListTile(
                                title: Text(_genders[0]),
                                value: _genders[0],
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: Text(_genders[1]),
                                value: _genders[1],
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        /// Button
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            onPressed: () async {
                              final String email = _email.text.trim();
                              final String name = _name.text.trim();
                              final String password = _password.text.trim();
                              final String confirmPassword =
                                  _confirmPassword.text.trim();
                              print(password);
                              if (!emailValidator(email)) {
                                toast("Please Enter a valid Email");
                              } else if (password == "" ||
                                  confirmPassword == "") {
                                toast("Please Input a Password");
                              } else if (password != confirmPassword) {
                                toast("ERROR : Passwords Mismatch");
                                setState(() {
                                  loading = false;
                                });
                              } else if (name == "") {
                                toast("Please Enter a Name");
                              } else {
                                setState(() => loading = true);
                                final UserModel _user = UserModel(
                                  email: email,
                                  gender: _gender.toString(),
                                );
                                DateTime curDate = DateTime.now();
                                _user.name = name;
                                _user.regDate =
                                    "${curDate.day}/${curDate.month}/${curDate.year}";
                                bool res =
                                    await Auth().register(_user, password);
                                if (res == false) {
                                  toast("Could Not Register User");
                                  setState(() {
                                    loading = false;
                                  });
                                  print(res);
                                } else {
                                  print(res);
                                  toast("User Registered Successfully");
                                  Navigator.pushNamed(context, '/login');
                                }
                              }
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
                                'Sign Up',
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

                        /// Login option
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/login'),
                          child: const Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'Already a Member? ',
                                style: TextStyle(
                                  fontFamily: 'DMMono',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Login Now',
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
