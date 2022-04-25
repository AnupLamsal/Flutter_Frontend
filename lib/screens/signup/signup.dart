import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_app/http/httpuser.dart';
import 'package:ecommerce_app/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName = "/signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  String fullName = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
        title: const Text('Create your account'),
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
                    'Register User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 12, 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (value) {
                    fullName = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    email = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter email',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    password = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: ' Password',
                    hintText: 'Enter password',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.save();
                    User user = User(
                      fullName: fullName,
                      password: password,
                      email: email,
                    );
                    var value = await HttpConnectUser.registerPost(user);
                    if (value == true) {
                      // Navigator.pushNamed(context, ProductList.routeName);
                      MotionToast.success(
                              description: const Text('User Created'))
                          .show(context);
                    } else {
                      MotionToast.error(
                              description:
                                  const Text('Please enter valid data'))
                          .show(context);
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: const Text('Sign In'),
                ),
              ],
            )),
      ),
    );
  }
}
