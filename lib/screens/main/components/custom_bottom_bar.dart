import 'package:ecommerce_int2/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
              height:screenAwareSize(12, context),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/home-icon-silhouette.svg',
              fit: BoxFit.fitWidth,
            ),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          // IconButton(
          //   icon: Image.asset('assets/icons/category_icon.png'),
          //   onPressed: () {
          //     controller.animateTo(1);
          //   },
          // ),
          IconButton(
            icon: SvgPicture.asset('assets/icons/shopping-cart-outline.svg'),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/user_not_logged_in.png'),
            onPressed: () {
              controller.animateTo(3);
            },
          )
        ],
      ),
    );
  }
}
