import 'package:get/get.dart';
import 'package:task_app/controllers/cart_controller.dart';
import 'package:task_app/controllers/food_menu_controller.dart';
import 'package:task_app/services/http_service.dart';

class InitialScreenBindings implements Bindings {
  InitialScreenBindings();

  @override
  void dependencies() {
    Get.lazyPut(() => FoodMenuController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => HttpService());
  }
}
