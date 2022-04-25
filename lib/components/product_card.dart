// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/details/details_screen.dart';
// import '../models/item.dart';

// import '../constants.dart';
// import '../size_config.dart';

// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     Key? key,
//     this.width = 140,
//     this.aspectRetio = 1.02,
//     required this.product,
//   }) : super(key: key);

//   final double width, aspectRetio;
//   final Item product;

//   @override
//   Widget build(BuildContext context) {
//     var image = product.image;
//     final UriData? data = Uri.parse(image).data;
//     Uint8List? myImage = data!.contentAsBytes();

//     return Padding(
//       padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
//       child: SizedBox(
//         width: getProportionateScreenWidth(width),
//         child: GestureDetector(
//           onTap: () => Navigator.pushNamed(
//             context,
//             DetailsScreen.routeName,
//             arguments: ProductDetailsArguments(product: product),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AspectRatio(
//                 aspectRatio: 1.02,
//                 child: Container(
//                   padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//                   decoration: BoxDecoration(
//                     color: kSecondaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Hero(
//                     tag: product.id.toString(),
//                     child: Image.memory(myImage),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 product.name,
//                 style: TextStyle(color: Colors.black),
//                 maxLines: 2,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Rs ${product.price}",
//                     style: TextStyle(
//                       fontSize: getProportionateScreenWidth(18),
//                       fontWeight: FontWeight.w600,
//                       color: kPrimaryColor,
//                     ),
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(50),
//                     onTap: () {},
//                     child: Container(
//                       padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//                       height: getProportionateScreenWidth(28),
//                       width: getProportionateScreenWidth(28),
//                       decoration: BoxDecoration(
//                         color: kPrimaryColor.withOpacity(0.15),
//                         shape: BoxShape.circle,
//                       ),
//                       child: SvgPicture.asset("assets/icons/Heart Icon_2.svg",
//                           color: Color(0xFFFF4848)),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
