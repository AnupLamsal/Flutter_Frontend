import 'package:ecommerce_app/screens/Admin/admin_view.dart';
import 'package:ecommerce_app/screens/Admin/updateForm.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../http/httpproduct.dart';
import '../../models/item.dart';
import 'admin_view.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  static String routeName = "/adminCard";

  final Item product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.product.image);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 69, 70, 69),
            Color.fromARGB(255, 77, 76, 76)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 42, 42, 43),
            blurRadius: 4,
            spreadRadius: 0.8,
            offset: Offset(4, 4),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(1),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: SizedBox.fromSize(
                          child: Image.asset(widget.product.image),
                          // child: Image.asset("assets/images/heater.jpg"),
                        )),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 17, 17, 17),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(left: 11, right: 11)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ))),
                      onPressed: () async {
                        var del = await HttpConnectProduct.deleteProduct(
                            widget.product.id.toString());

                        if (del == "deleted") {
                          Navigator.pushNamed(context, AdminScreen.routeName);

                          MotionToast.success(
                                  description:
                                      Text('Product deleted successfully'))
                              .show(context);

                          // setState(() {
                          //   snapshot.data!.removeAt(index);
                          //   totalPrice = HttpConnectOrder.getPrice();
                          // });
                        } else {
                          MotionToast.error(
                                  description: Text('Failed to delete product'))
                              .show(context);
                        }
                      },
                      child: const Text(
                        'Del',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Avenir',
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )),
            flex: 3,
          ),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.name,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir',
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Text(
                    'Rs.' + widget.product.price,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 20, 20, 20),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(left: 11, right: 11)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ))),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    UpdateProductScreen.routeName,
                    arguments: ProductArguments(product: widget.product),
                  ),
                  child: const Text(
                    'Upd',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
