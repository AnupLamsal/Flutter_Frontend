import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/http/httpproduct.dart';
import 'package:ecommerce_app/models/item.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);
  static String routeName = "/updateForm";

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formkey = GlobalKey<FormState>();

  String name = '';
  String detail = '';
  String price = '';
  String image = "";
  final picker = ImagePicker();
  Uint8List? imageBytes;
  String? imageData;

  @override
  Widget build(BuildContext context) {
    final ProductArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductArguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 64, 64),
        title: const Text('Product Details'),
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
                  margin: const EdgeInsets.only(top: 25),
                  child: const Text(
                    'Update Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 53, 53, 53),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: args.product.name,
                  onSaved: (value) {
                    name = value!;
                  },
                  // maxLength: 30,
                  decoration: const InputDecoration(
                    labelText: 'Name:',
                    hintText: 'Enter product name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: args.product.detail,
                  onSaved: (newValue) {
                    detail = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description:',
                    hintText: 'Enter product description',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: args.product.price,
                  onSaved: (newValue) {
                    price = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price',
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
                    Item item = await Item(
                        id: args.product.id,
                        name: name,
                        detail: detail,
                        price: price,
                        image: imageData!);
                    print(item);
                    var value =
                        await HttpConnectProduct.updateProductPosts(item);
                    print(value);
                    if (value == "updated") {
                      // Navigator.pushNamed(context, ProductList.routeName);
                      MotionToast.success(
                              description:
                                  const Text('Product updated successfully'))
                          .show(context);
                    } else {
                      MotionToast.error(
                              description: Text('Failed to update product'))
                          .show(context);
                    }
                  },
                  child: const Text('Update'),
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

class ProductArguments {
  final Item product;

  ProductArguments({required this.product});
}
