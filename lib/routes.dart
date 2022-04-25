import 'package:ecommerce_app/screens/Admin/admin_view.dart';
import 'package:ecommerce_app/screens/Admin/productForm.dart';
import 'package:ecommerce_app/screens/Client/client_view.dart';
import 'package:ecommerce_app/screens/Client/detail.dart';
import 'package:ecommerce_app/screens/signup/signup.dart';
import 'package:flutter/widgets.dart';
import 'screens/khalti/khaltiPage.dart';
import 'screens/Admin/updateForm.dart';
import 'screens/signin/signin.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  KhaltiPaymentPage.routeName: (context) => KhaltiPaymentPage(),
  detailScreen.routeName: ((context) => detailScreen()),
  UpdateProductScreen.routeName: (context) => UpdateProductScreen(),
  AdminScreen.routeName: (context) => const AdminScreen(),
  ClientScreen.routeName: (context) => const ClientScreen(),
  AddProductScreen.routeName: (context) => AddProductScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
};
