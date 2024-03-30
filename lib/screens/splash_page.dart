import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/mainpage_notifier.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_int2/api_services/settings_api.dart';

import 'package:connectivity/connectivity.dart';

// Splash screen widget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

DateTime expirationDate = DateTime(2024, 1, 30);

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? opacity; // Animation for fading out the splash screen
  late AnimationController controller; // Animation controller

  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  // Check internet connectivity
  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });

    return !(_connectivityResult == ConnectivityResult.none);
  }

  bool connection_retry = false;

  @override
  void initState() {
    super.initState();

    // if (DateTime.now().isAfter(expirationDate)) {
    //   return;
    // }

    checkConnectivity().then((value) {
      if (value == false) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No Internet Connection'),
              content: Text('Please check your internet connection.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Retry'),
                  onPressed: () {
                    checkConnectivity().then((value) {
                      if (value == true) {
                        connection_retry = true;
                        controller = AnimationController(
                            duration: Duration(milliseconds: 2500),
                            vsync: this);
                        opacity = Tween<double>(begin: 1.0, end: 0.0)
                            .animate(controller)
                          ..addListener(() {
                            setState(() {});
                          });

                        controller.forward().then((_) {
                          navigationPage();
                        });
                        // Navigator.of(context).pop();
                      } else {
                        //try again.
                        connection_retry = true;

                        print("No internet connection yet.");
                      }
                    });
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          this.connection_retry = true;
          controller = AnimationController(
              duration: Duration(milliseconds: 2500), vsync: this);
          opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
            ..addListener(() {});

          controller.forward().then((_) {
            navigationPage();
          });
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (DateTime.now().isAfter(expirationDate)) {
    //   return;
    // }

    if (_connectivityResult == ConnectivityResult.none) {
      MainPageNotifier productNotifier =
          Provider.of<MainPageNotifier>(context, listen: true);
      SettingsAPI.getSettings()
          .then((value)  {
            AppSettings.setSettings(value["app_data"]["theme"]);
            productNotifier.updateProducts();
            });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
  }

  Widget build(BuildContext context) {
    Widget splashScreen = (_connectivityResult == ConnectivityResult.none)
        ? Container()
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(color: AppSettings.THEME_COLOR_3),
              child: SafeArea(
                child: new Scaffold(
                  body: Column(
                    children: <Widget>[
                      Expanded(
                        child: Opacity(
                            opacity: opacity != null ? opacity!.value : 0,
                            child: new Image.asset('assets/logo.png')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: 'Powered by '),
                                TextSpan(
                                    text: 'TheSellerStack.com',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
    return splashScreen;
  }
}
