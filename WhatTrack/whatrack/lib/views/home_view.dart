import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatrack/constants/colors.dart';
import 'package:whatrack/shared/loading.dart';
import 'package:whatrack/views/profile_view.dart';
import '../auth/auth.dart';
import '../models/userModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum MenuItem {
  profile,
  aboutUs,
  logout,
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel user = UserModel(email: "", gender: "");
  bool loading = true;
  getUser() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    print(firebaseUser);
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
            user = UserModel(
                email: ds.get('email'),
                name: ds.get('name'),
                // id: uid,
                gender: ds.get("gender"),
                regDate: ds.get("regDate"));
            print(user.name);
          })
          .whenComplete(() => setState(() {
                loading = false;
              }))
          .catchError((e) {
            print(e);
          });
    }
  }

  Future<void> profile() async {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => Profile(
              user: user,
            )));
  }

  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : WillPopScope(
            onWillPop: () {
              return Future(() => false);
            },
            child: Scaffold(
              /// Top app bar
              appBar: AppBar(
                backgroundColor: CustomColors.appBarPurple,

                /// Logo
                leading: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(
                      'assets/images/logo_circle.png',
                    ),
                  ),
                ),

                /// Title
                title: const Text(
                  'WhatTrack',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),

                /// Dropdown menu
                actions: [
                  PopupMenuButton<MenuItem>(
                    onSelected: (value) async {
                      switch (value) {
                        case MenuItem.profile:
                          {
                            profile();
                            break;
                          }
                        case MenuItem.aboutUs:
                          {
                            /// TODO: Uncomment and set route for aboutUs
                            Navigator.pushNamed(context, '/aboutUs');
                            break;
                          }
                        case MenuItem.logout:
                          {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.remove('email');
                            Auth().logout();
                            Navigator.pushNamed(context, '/login');
                          }
                      }
                    },
                    icon: const Icon(
                      Icons.menu_outlined,
                      size: 35,
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: MenuItem.profile,
                        child: Text('Profile'),
                      ),
                      const PopupMenuItem(
                        value: MenuItem.aboutUs,
                        child: Text('About Us'),
                      ),
                      const PopupMenuItem(
                        value: MenuItem.logout,
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ],
              ),

              ///Body
              body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgroundLight.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),

                    /// Real Body
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'WELCOME',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          user.name.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    /// TODO: Uncomment and set route for Music Genre classification
                                    Navigator.pushNamed(context, '/musicGenre');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    constraints: const BoxConstraints.expand(),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        /// TODO: set image
                                        image: AssetImage(
                                            'assets/images/Home_image.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Align(
                                      alignment: AlignmentDirectional.topCenter,
                                      child: const Text(
                                        'Music Genre\nClassification',

                                        /// TODO: set appropriate style after setting image
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff042172),
                                          
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    /// TODO: Uncomment and set route for Major & minor prediction
                                    Navigator.pushNamed(
                                        context, '/major-minor');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    constraints: const BoxConstraints.expand(),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        /// TODO: image
                                        image: AssetImage(
                                            'assets/images/Home_image.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: const Text(
                                        'Major & Minor\nPrediction',

                                        /// TODO: text style
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                            color: Color(0xff042172),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    /// TODO: Uncomment and set route for instrument prediction
                                    Navigator.pushNamed(context, '/instrument');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    constraints: const BoxConstraints.expand(),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        /// TODO: image
                                        image: AssetImage(
                                            'assets/images/Home_image.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: const Text(
                                        'Instrument\nPrediction',

                                        /// TODO: text style
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                            color: Color(0xff042172),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
