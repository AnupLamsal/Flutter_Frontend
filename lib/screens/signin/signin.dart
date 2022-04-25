import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_app/http/httpuser.dart';
import 'package:ecommerce_app/screens/Admin/admin_view.dart';
import 'package:ecommerce_app/screens/Client/client_view.dart';
import 'package:ecommerce_app/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/models/user.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/signin";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 38, 38, 39),
        title: const Text('New User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  // color: Colors.amberAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 12, 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (value) {
                    email = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  onSaved: (newValue) {
                    password = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter password',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.save();
                    String credEmail = email;

                    String credPassword = password;

                    var res = await HttpConnectUser.loginPosts(
                        credEmail, credPassword);
                    var hello = res['user']['role'];
                    var user = res['user']['fullName'];
                    if (res == null) {
                      MotionToast.error(
                              description: Text('Invalid Credentials'))
                          .show(context);
                    } else {
                      if (hello == false) {
                        Navigator.pushNamed(context, ClientScreen.routeName);

                        MotionToast.success(
                                description: Text('Welcome back Mr.${user}'))
                            .show(context);
                      } else {
                        Navigator.pushNamed(context, AdminScreen.routeName);

                        MotionToast.success(
                                description: Text('Welcome back Mr.${user}'))
                            .show(context);
                      }
                    }
                  },
                  child: const Text('Log In'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            )),
      ),
    );
  }
}
