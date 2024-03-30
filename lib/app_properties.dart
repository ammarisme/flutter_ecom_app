import 'package:flutter/material.dart';

// Color constants used throughout the app
class AppSettings{
static Color? PAGE_BACKGROUND_COLOR;// =Color.fromRGBO(230, 230, 230, 1);
static Color? PAGE_BACKGROUND_COLOR_2;// =Color.fromRGBO(255, 255, 255, 1);
static Color? TEXT_BOX_COLOR;// = Color.fromARGB(255, 255, 255, 255);
static Color? THEME_COLOR_1;// = Color.fromARGB(150, 0, 0, 0);
static Color? THEME_COLOR_2;// = Color.fromARGB(150, 0, 0, 0);
static Color? THEME_COLOR_3;// = Color.fromRGBO(0, 0, 0, 0.694);
static const Color darkGrey = Color(0xff202020);
static Color? CONTENT_TEXT_COLOR_1 ;//= Color.fromRGBO(0, 0, 0, 0.588);
static Color? LINK_TEXT_COLOR_1;// = Color.fromARGB( 131, 0, 0, 131);
static Color? LINK_TEXT_COLOR_2;// = Color.fromARGB(255, 255, 153, 0);

static Color? PRICE_COLOR_SALE;// = Colors.orange;

//Button colors
static Color? BUTTON_COLOR_1;// = Color.fromARGB(238, 22, 10, 0);
static Color? BUTTON_COLOR_1_INACTIVE;// = Color.fromARGB(171, 133, 133, 133);
static Color? BUTTON_TEXT_COLOR1;// = Color.fromARGB(255, 255, 255, 255);
static int? MAIN_BUTTON_FACTOR;// = 4;
static int? MAIN_BUTTON_HEIGHT_FACTOR;// = 10;
static double? BUTTON_FONT_SIZE;// = 10;
static double? SMALL_BUTTON_FONT_SIZE;// = 8;


//Button colors
static Color TEXT_COLOR_1 = Color(0xff202020);
static double BUTTON_ICON_SIZE = 18;


// Gradients for buttons
static LinearGradient MAIN_BUTTON_GRADIENTS = LinearGradient(colors: [
  BUTTON_COLOR_1 as Color,
  BUTTON_COLOR_1 as Color,
  BUTTON_COLOR_1 as Color,
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);


static LinearGradient DISABLED_BUTTON_GRADIENTS = LinearGradient(colors: [
   Color.fromARGB(239, 167, 167, 167),
   Color.fromARGB(239, 167, 167, 167),
   Color.fromARGB(239, 167, 167, 167),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

// Shadow effect for elements
static List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

// Function to calculate responsive size based on screen height
static screenAwareSize(int size, BuildContext context) {
  double baseHeight = 160;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

// Function to calculate responsive width based on screen width
static screenAwareWidth(int width, BuildContext context) {

  double baseWidth = 75;
  return width * MediaQuery.of(context).size.width / baseWidth;
}

static setSettings(app_settings){
  PAGE_BACKGROUND_COLOR = getColor(app_settings["PAGE_BACKGROUND_COLOR"]);
PAGE_BACKGROUND_COLOR_2 = getColor(app_settings["PAGE_BACKGROUND_COLOR_2"]);
TEXT_BOX_COLOR =  getColor(app_settings["TEXT_BOX_COLOR"]);
THEME_COLOR_1 =  getColor(app_settings["THEME_COLOR_1"]);
THEME_COLOR_2 =  getColor(app_settings["THEME_COLOR_2"]);
THEME_COLOR_3 =  getColor(app_settings["THEME_COLOR_3"]);
CONTENT_TEXT_COLOR_1 = getColor(app_settings["CONTENT_TEXT_COLOR_1"]);
LINK_TEXT_COLOR_1 = getColor(app_settings["LINK_TEXT_COLOR_1"]);
LINK_TEXT_COLOR_2 =  getColor(app_settings["LINK_TEXT_COLOR_2"]);
PRICE_COLOR_SALE = getColor(app_settings["PRICE_COLOR_SALE"]);

//Button colors
BUTTON_COLOR_1 =  getColor(app_settings["BUTTON_COLOR_1"]);
BUTTON_COLOR_1_INACTIVE = getColor(app_settings["BUTTON_COLOR_1_INACTIVE"]);
BUTTON_TEXT_COLOR1 =  getColor(app_settings["BUTTON_TEXT_COLOR1"]);
MAIN_BUTTON_FACTOR = app_settings["MAIN_BUTTON_FACTOR"];
MAIN_BUTTON_HEIGHT_FACTOR = app_settings["MAIN_BUTTON_HEIGHT_FACTOR"];
BUTTON_FONT_SIZE = double.tryParse(app_settings["BUTTON_FONT_SIZE"]) as double;
SMALL_BUTTON_FONT_SIZE = double.tryParse(app_settings["SMALL_BUTTON_FONT_SIZE"]) as double;

}

static Color getColor(String argb){
  final argbArray = argb.split(",");
  return Color.fromARGB(
    int.tryParse(argbArray[0]) as int,
    int.tryParse(argbArray[1]) as int,
    int.tryParse(argbArray[2]) as int,
    int.tryParse(argbArray[3]) as int);
}
}



class StaticAppSettings{
static Color? PAGE_BACKGROUND_COLOR =Color.fromRGBO(230, 230, 230, 1);
static Color? PAGE_BACKGROUND_COLOR_2=Color.fromRGBO(255, 255, 255, 1);
static Color? TEXT_BOX_COLOR = Color.fromARGB(255, 255, 255, 255);
static Color? THEME_COLOR_1  = Color.fromARGB(150, 0, 0, 0);
static Color? THEME_COLOR_2  = Color.fromARGB(150, 0, 0, 0);
static Color? THEME_COLOR_3= Color.fromRGBO(0, 0, 0, 0.694);
static const Color darkGrey = Color(0xff202020);
static Color? CONTENT_TEXT_COLOR_1 = Color.fromRGBO(0, 0, 0, 0.588);
static Color? LINK_TEXT_COLOR_1= Color.fromARGB( 131, 0, 0, 131);
static Color? LINK_TEXT_COLOR_2 = Color.fromARGB(255, 255, 153, 0);

static Color? PRICE_COLOR_SALE = Colors.orange;

//Button colors
static Color? BUTTON_COLOR_1 = Color.fromARGB(238, 22, 10, 0);
static Color? BUTTON_COLOR_1_INACTIVE = Color.fromARGB(171, 133, 133, 133);
static Color? BUTTON_TEXT_COLOR1 = Color.fromARGB(255, 255, 255, 255);
static int? MAIN_BUTTON_FACTOR  = 4;
static int? MAIN_BUTTON_HEIGHT_FACTOR  = 10;
static double? BUTTON_FONT_SIZE = 10;
static double? SMALL_BUTTON_FONT_SIZE = 8;


//Button colors
static Color TEXT_COLOR_1 = Color(0xff202020);
static double BUTTON_ICON_SIZE = 18;


// Gradients for buttons
static LinearGradient MAIN_BUTTON_GRADIENTS = LinearGradient(colors: [
  BUTTON_COLOR_1 as Color,
  BUTTON_COLOR_1 as Color,
  BUTTON_COLOR_1 as Color,
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);


static LinearGradient DISABLED_BUTTON_GRADIENTS = LinearGradient(colors: [
   Color.fromARGB(239, 167, 167, 167),
   Color.fromARGB(239, 167, 167, 167),
   Color.fromARGB(239, 167, 167, 167),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

// Shadow effect for elements
static List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

// Function to calculate responsive size based on screen height
static screenAwareSize(int size, BuildContext context) {
  double baseHeight = 160;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

// Function to calculate responsive width based on screen width
static screenAwareWidth(int width, BuildContext context) {

  double baseWidth = 75;
  return width * MediaQuery.of(context).size.width / baseWidth;
}
}

