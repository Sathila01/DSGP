import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatrack/models/userModel.dart';

import '../auth/auth.dart';
import '../constants/colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  State<Profile> createState() => _ProfileState();
}

enum MenuItem {
  profile,
  aboutUs,
  logout,
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    String? _name = widget.user.name;
    String? _email = widget.user.email;
    String? _regDate = widget.user.regDate;
    String gender = widget.user.gender;
    return Scaffold(
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
                    /// TODO: Uncomment and set route for profile
                    Navigator.pushNamed(context, '/profile');
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
              )
            ],
          ),
        ],
      ),

      ///body
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundLight.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gender == "Male"
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/boyavatar.jpg'),
                        radius: 80,
                      )
                    : const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/female.jpg'),
                        radius: 120,
                      ),
                Text(
                  '\n$_name',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFB298BE),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email: ${_email}",
                          style: const TextStyle(
                            fontSize: 20
                          ),),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Registerd on : ${_regDate} ",
                          style: const TextStyle(
                            fontSize: 20
                          ),),

                          // "Registerd on : ${_regDate!.day} / ${_regDate.month} / ${_regDate.year}")
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
