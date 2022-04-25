import 'package:ecommerce_app/screens/Client/client_view.dart';
import 'package:ecommerce_app/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/routes.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_eca417780b9247d5ac4e791af7947fe0",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            // theme: theme(),
            // home: SplashScreen(),
            // We use routeName so that we dont need to remember the name

            initialRoute: SignInScreen.routeName,

            routes: routes,
          );
        });
  }
}
