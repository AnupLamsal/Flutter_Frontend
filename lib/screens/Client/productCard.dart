import 'package:ecommerce_app/screens/Client/detail.dart';
import 'package:flutter/material.dart';
import '../../models/item.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Item product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 25, 26, 25),
            Color.fromARGB(255, 98, 98, 99)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 182, 181, 181),
            blurRadius: 4,
            spreadRadius: 0.8,
            offset: Offset(4, 4),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(1),
                // Border width
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: SizedBox.fromSize(
                          child: Image.asset(widget.product.image),
                        )),
                  ],
                )),
            flex: 3,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.name,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir',
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Text(
                    'Rs. ' + widget.product.price,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Avenir',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 0, 0, 0),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(left: 11, right: 11)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ))),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    detailScreen.routeName,
                    arguments: ProductArguments(product: widget.product),
                  ),
                  child: const Text(
                    'Detail',
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
