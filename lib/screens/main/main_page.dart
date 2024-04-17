import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/api_services/settings_api.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/custom_background.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/auth/login_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: MainContent(),
      );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent>
    with TickerProviderStateMixin<MainContent> {
      MainContentVM vm = MainContentVM();
 
  @override
  void initState() {
    super.initState();

    if (!vm.isStateUpdated) {
      setState(() {
        vm.isStateUpdated = true;
      });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
          painter: MainBackground(),
          child: LoginOrProfile()
          ),
    );
  }
}


class LoginOrProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    return Container(
      child: FutureBuilder<bool>(
        future: userNotifier.checkIfLogged(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return ProfilePage(
                              logged_in_user: userNotifier.logged_in_user,
                            );
          } else {
            // After reading from storage, use the data to build your widget
            return LoginPage();
          }
        },
      ),
    );
  }
}

class MainContentVM{
  MainContentVM(){
    this.timelines = [ApiService.main_carousal_title];
    this.selectedTimeline = ApiService.main_carousal_title;
  }

 TabController? tabController;
  TabController? bottomTabController;
  bool isStateUpdated = false;

  List<Product> products = [];

  List<String> timelines = [] ;
  String selectedTimeline = "";
}