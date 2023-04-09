import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../auth/auth.dart';
import '../constants/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundDark.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: Column(children: [
                const SizedBox(height: 100),
                const Text(
                  'Enter your Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: _email,
                    style: const TextStyle(color: CustomColors.blackPurple),
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
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      final String email = _email.text.trim();
                      await Auth().verifyEmail(email)
                          ? Navigator.pushNamed(context, '/login')
                          : Fluttertoast.showToast(
                              msg: "ERROR",
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.black,
                              fontSize: 16,
                              backgroundColor: Colors.grey[200],
                            );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                      child: Text(
                        'Submit',
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
              ]),
            )));
  }
}
