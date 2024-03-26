import 'dart:async';

import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/change_notifiers/mainpage_notifier.dart';
import 'package:ecommerce_int2/change_notifiers/product_notifier.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//Entrypoint for the application
void main() {
    // Run the app with error handling
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    Utils.log('Caught error: $error');
  });
}

class MyApp extends StatelessWidget {
  // Root widget of the application
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
            // Providers for application state management
      providers: [
        ChangeNotifierProvider<MainPageNotifier>(
          create: (_) => MainPageNotifier(),
        ),
        ChangeNotifierProvider<UserNotifier>(
          create: (_) => UserNotifier(),
        ),
        ChangeNotifierProvider<ProductNotifier>(
            create: (_) => ProductNotifier(),
        ),
        ChangeNotifierProvider<CartNotifier>(
          create: (_) => CartNotifier(),
        )
      ],
      child: MaterialApp(
      title: 'catlitter.lk',
      debugShowCheckedModeBanner: false,
                // App theme customization
      theme: ThemeData(
        ////brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen()) // Start with the Splash screen
     );
     
  }
}
