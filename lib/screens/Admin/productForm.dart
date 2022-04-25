import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/http/httpproduct.dart';
import 'package:ecommerce_app/models/item.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static String routeName = "/productForm";

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();

  String name = '';
  String details = '';
  String price = '';
  String image = "";
  final picker = ImagePicker();
  Uint8List? imageBytes;
  String? imageData;
  dynamic x;
  List<double>? _accelerometerValues;
  final _streamSub = <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    super.initState();
    _streamSub.add(accelerometerEvents.listen((AccelerometerEvent event) {
      _accelerometerValues = <double>[event.x, event.y];
      x = _accelerometerValues?.first;
      if (x < -7) {
        return clearCard();
      } else if (x > 7) {
        return clearCard();
      }
    }));
  }

  void clearCard() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Message'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 71, 212, 236),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: const Text('Yes'),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/adminCard');

                        const Duration(seconds: 2);
                        MotionToast.warning(
                                description: const Text("Logout Successfull"))
                            .show(context);
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 71, 212, 236),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/productForm');
                      },
                    ),
                  ],
                ))
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    for (final sub in _streamSub) {
      sub.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    _accelerometerValues?.map((double g) => g.toStringAsFixed(1)).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 64, 64),
        title: const Text('New Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  // color: Colors.amberAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (value) {
                    name = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name:',
                    hintText: 'Enter the productname',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    details = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Details:',
                    hintText: 'Enter product details',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    price = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price:',
                    hintText: 'Enter price',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.gallery),
                    icon: imageBytes == null
                        ? const Icon(Icons.image)
                        : Image.memory(imageBytes!, height: 40, width: 40),
                    label: imageData == null
                        ? const Text('Gallery')
                        : const Text('Image selected')),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.save();
                    if (imageData != null) {
                      Item item = Item(
                          name: name,
                          detail: details,
                          price: price,
                          id: '',
                          image: imageData!);
                      var value =
                          await HttpConnectProduct.addProductPosts(item);

                      if (value == "added") {
                        // Navigator.pushNamed(context, ProductList.routeName);
                        MotionToast.success(
                                description: const Text('Product added'))
                            .show(context);
                      } else {
                        MotionToast.error(
                                description:
                                    const Text('Failed to add product'))
                            .show(context);
                      }
                    }
                  },
                  child: const Text('Add Product'),
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),
    );
  }

  _getImage(ImageSource imageSource) async {
    var imageFile = (await picker.pickImage(source: imageSource));
    if (imageFile == null) return '';
    var _image = File(imageFile.path);
    imageBytes = _image.readAsBytesSync();
    Uint8List bytes = Uint8List.fromList(imageBytes!);
    imageData = 'data:image/jpeg;base64,' + base64.encode(bytes);
    return imageData;
  }
}
