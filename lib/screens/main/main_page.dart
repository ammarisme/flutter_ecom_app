import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/api_services/settings_api.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/custom_background.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/auth/login_page.dart';
import 'package:ecommerce_int2/screens/category/category_list_page.dart';
import 'package:ecommerce_int2/screens/main/category_tabs.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../change_notifiers/mainpage_notifier.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';

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
    vm.tabController = TabController(length: 10, vsync: this);
    vm.bottomTabController = TabController(length: 10, vsync: this);


    if (!vm.isStateUpdated) {
      setState(() {
        vm.isStateUpdated = true;
      });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    MainPageNotifier mainPageNotifier = Provider.of<MainPageNotifier>(context, listen: true);

    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // TODO: IconButton(
          //     onPressed: () => Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) => NotificationsPage())),
          //     icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );

    Widget topHeader = Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    vm.selectedTimeline = vm.timelines[0];
                    vm.products = mainPageNotifier.products;
                  });
                },
                child: Text(
                  vm.timelines[0],
                  style: TextStyle(
                      fontSize: 16,
                      color:Colors.black,
                      ),
                ),
              ),
            ),
            // Flexible(
            //   child: InkWell(
            //     onTap: () {
            //       setState(() {
            //         vm.selectedTimeline = vm.timelines[0];
            //         vm.products = mainPageNotifier.products;
            //         ;
            //       });
            //     },
            //     child: Text(vm.timelines[0],
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: vm.timelines[0] == vm.selectedTimeline ? 20 : 14,
            //             color: AppSettings.darkGrey)),
            //   ),
            // ),
          ],
        ));

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: vm.bottomTabController as TabController),
      body: CustomPaint(
          painter: MainBackground(),
          child: TabBarView(
            controller: vm.bottomTabController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: appBar,
                      ),
                      SliverToBoxAdapter(
                        child: topHeader,
                      ),
                      Consumer<MainPageNotifier>(
                          builder: (context, productNotifier, _) {
                        return SliverToBoxAdapter(
                          child: ProductList(
                            products: mainPageNotifier.products,
                          ),
                        );
                      }),
                      SliverToBoxAdapter(
                        child: CategoryTabs(),
                      )
                    ];
                  },
                  body: Container()
                ),
              ),
              CategoryListPage(),
              CheckOutPage(),
              Consumer<UserNotifier>(
                builder: (context, userNotifier, _) { 
                  return Container(
                      child: LoginOrProfile() );
                },
              )
            ],
          )),
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