import 'package:get/get.dart';
import 'package:task1/controller/firebase_controller.dart';
import 'package:task1/controller/main_controller.dart';

Future<void> init() async {

  Get.lazyPut(()=>FirebaseController());
  Get.lazyPut(()=>MainController(firebaseController: Get.find()));

 await Get.find<MainController>().checkTimeStartedValue();
 await Get.find<FirebaseController>().dbInitialization();

}