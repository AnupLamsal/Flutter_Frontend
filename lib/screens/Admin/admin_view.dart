import 'dart:async';
import 'dart:typed_data';

import 'package:ecommerce_app/http/httpproduct.dart';
import 'package:ecommerce_app/models/item.dart';
import 'package:ecommerce_app/screens/Admin/productCard.dart';
import 'package:ecommerce_app/screens/Admin/productForm.dart';
import 'package:ecommerce_app/screens/Admin/updateForm.dart';
import 'package:ecommerce_app/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({
    Key? key,
    // required this.product,
  }) : super(key: key);
  static String routeName = "/adminview";

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Future<List<Item>> products = HttpConnectProduct.getProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: const Mydrawer(),
        backgroundColor: Color.fromARGB(255, 56, 56, 56),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Bazzar',
            style: TextStyle(
              color: Color.fromARGB(255, 241, 242, 242),
              shadows: [
                Shadow(
                  color: Color.fromARGB(255, 63, 62, 62),
                  offset: Offset(0, 5),
                  blurRadius: 20,
                ),
              ],
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SizedBox(
            child: FutureBuilder<List<Item>>(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 26, 25, 25),
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.only(left: 11, right: 11)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ))),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AddProductScreen.routeName);
                            },
                            child: const Text("Add Product")),
                        Expanded(
                            child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          children: [
                            ...List.generate(
                              snapshot.data!.length,
                              (index) {
                                return ProductCard(
                                    product: snapshot.data![index]);
                              },
                            ),
                          ],
                        )),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 15, 15, 15),
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.only(left: 11, right: 11)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                             ))),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                              MotionToast.success(
                                      description: Text('Logged Out'))
                                  .show(context);
                            },
                            child: const Text("Logout")),
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
