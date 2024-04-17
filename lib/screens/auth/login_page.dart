import 'dart:convert';

import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/screens/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  TextEditingController username = TextEditingController(text: '');
  TextEditingController password =
      TextEditingController(text: ''); //Eha&uDuy*4hoTTCXYwMCfDF(

  @override
  Widget build(BuildContext context) {
LoginPageVM vm = LoginPageVM();
    Widget loginButton = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {
          vm.onTapTrackbtn(context, this.username.text);
                },
        child: Container(
          width: MediaQuery.of(context).size.width / (StaticAppSettings.MAIN_BUTTON_FACTOR as int),
          height: MediaQuery.of(context).size.width / (StaticAppSettings.MAIN_BUTTON_HEIGHT_FACTOR as int),
          child: Center(
              child: new Text("Track",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              color: StaticAppSettings.BUTTON_COLOR_1,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only( bottom: 4.0),
                  child: Row(children: [
                    Expanded(
                        child:
                        Container(
        padding: EdgeInsets.only(right: 16, left: 16.0, top: 4.0, bottom: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: StaticAppSettings.TEXT_BOX_COLOR,
        ),
        child:
                         TextField(
                            controller: username,
                            style: TextStyle(fontSize: 16.0),
                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: StaticAppSettings.TEXT_BOX_COLOR, 
                              hintText: 'Your email address',
                              prefixIcon:
                                  Icon(Icons.email), // Icon before the input
                            )))
                    )
                  ]),
                ),
              
                loginButton
              ],
            ),
          );      

    return Scaffold(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right:30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 2),
                                Spacer(flex: 1),
                loginForm,
                Spacer(flex: 1),
                                Spacer(flex: 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class LoginPageVM {
//Navigate to the tracking page. Pass the mobile number.
  void onTapTrackbtn(context, email) {
    UserAPIs.getCustomerByEmail(email).then((customer) => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProfilePage(
                              logged_in_user: customer as User,
                            )))
        });
  }
}
