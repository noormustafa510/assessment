import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;


  //screen height
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.26;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  //screen width
  static double width10 = screenWidth / 84.4;
  static double width15 = screenWidth / 56.26;
  static double width20 = screenWidth / 42.2;
  static double width30 = screenWidth / 28.13;


  //font size
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

}