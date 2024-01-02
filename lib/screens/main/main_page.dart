
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/change_notifiers/product_notifier.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/custom_background.dart';
import 'package:ecommerce_int2/models/category.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/auth/login_page.dart';
import 'package:ecommerce_int2/screens/category/category_list_page.dart';
import 'package:ecommerce_int2/screens/notifications_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../change_notifiers/mainpage_notifier.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';
import 'components/tab_view.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        home: MainContent(),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent>
    with TickerProviderStateMixin<MainContent> {
  late TabController tabController;
  late TabController bottomTabController;
  bool isStateUpdated = false;

  List<Product> products = [];

  List<String> timelines = ['Featured products', 'Trending'];
  String selectedTimeline = 'Featured products';

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 10, vsync: this);
    print('initState');
    if (!isStateUpdated) {
      MainPageNotifier productNotifier =
          Provider.of<MainPageNotifier>(context, listen: false);
      productNotifier.updateProducts();
      setState(() {
        isStateUpdated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('building');
    MainPageNotifier productNotifier = Provider.of<MainPageNotifier>(context);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

   

    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => NotificationsPage())),
              icon: Icon(Icons.notifications)),
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
                    selectedTimeline = timelines[0];
                    products = productNotifier.products;
                  });
                },
                child: Text(
                  timelines[0],
                  style: TextStyle(
                      fontSize: timelines[0] == selectedTimeline ? 20 : 14,
                      color:Colors.black,
                      ),
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[1];
                    products = productNotifier.products;
                    ;
                  });
                },
                child: Text(timelines[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: timelines[1] == selectedTimeline ? 20 : 14,
                        color: darkGrey)),
              ),
            ),
          ],
        ));

   

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
          painter: MainBackground(),
          child: TabBarView(
            controller: bottomTabController,
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
                            products: productNotifier.products,
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
                      child: userNotifier.logged_in
                          ? ProfilePage(
                              logged_in_user: userNotifier.logged_in_user,
                            )
                          : LoginPage());
                },
              )
            ],
          )),
    );
  }

  getTabController(length){
    return TabController(length: length, vsync: this);
  }
}

class CategoryTabs extends StatefulWidget {

  CategoryTabs();

  @override
  _CategoryTabsState createState() => _CategoryTabsState();
}


class _CategoryTabsState extends State<CategoryTabs>  with TickerProviderStateMixin<CategoryTabs>{
 List<Tab> category_tabs = [];
 List<Category> root_categories = [];
late TabController tabController;

@override
void initState() {
  super.initState();

  // Make API call here
   ProductAPIs.getCategories().then((categories) {
          root_categories = categories.where((category) => category.parent ==0).toList();
          category_tabs = root_categories.map((category) => Tab(text: category.name)).toList();
          this.tabController = TabController(length: category_tabs.length, vsync: this);
   }
    );
}

@override
Widget build(BuildContext context) {

    Widget tabBar = TabBar(
      tabs: category_tabs,
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: this.tabController,
    );

    Widget tabView = TabView(
                    categories: root_categories,
                    selectedCategory: root_categories[0],
                    products_of_category: [],
                    tabController: this.tabController,
                  );

  return Container(
    child:Column(
      children: [tabBar,
      tabView]));
}
}



// class W extends StatefulWidget {
//   Attrib attrib;

//   W({required this.attrib});

//   @override
//   _WState createState() => _WState();
// }


// class _WState extends State<W> {

// @override
// void initState() {
//   super.initState();
//   // Make API call here
// }
// }

