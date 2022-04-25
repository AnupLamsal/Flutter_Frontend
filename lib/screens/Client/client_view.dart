import 'dart:async';
import 'package:ecommerce_app/http/httpproduct.dart';
import 'package:ecommerce_app/models/item.dart';
import 'package:ecommerce_app/screens/client/productCard.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../signin/signin.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({
    Key? key,
    // required this.product,
  }) : super(key: key);
  static String routeName = "/clientview";

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  Future<List<Item>> products = HttpConnectProduct.getProducts();
  dynamic x;
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          _accelerometerValues = <double>[event.x, event.y, event.z];
          x = _accelerometerValues?.first;
          if (x < -8) {
            clearCard();
          } else if (x > 8) {
            clearCard();
          }
        },
      ),
    );
  }

  void clearCard() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Message'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () async {
                    Navigator.pushNamed(context, SignInScreen.routeName);

                    MotionToast.success(
                            description: const Text("Logout Successfull"))
                        .show(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: const Mydrawer(),
        backgroundColor: Color.fromARGB(255, 27, 27, 27),
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
                        Expanded(
                            child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
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
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
