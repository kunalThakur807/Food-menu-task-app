import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_app/utils/api_endpoints.dart';
import 'package:task_app/models/food_menu_data_model.dart';
import 'package:task_app/services/http_service.dart';

class FoodMenuController extends GetxController {
  RxBool loading = false.obs;
  RxInt cartCount = 3.obs;
  RxInt selectedCategoryIndex = 0.obs;

  RxList menuGroups = [].obs;

  @override
  void onInit() {
    super.onInit();
    getFoodMenuData();
  }

  Future<void> getFoodMenuData() async {
    loading.value = true;
    HttpService httpService = Get.find();

    var responseData = await httpService.get(path: ApisEndPoints.getMenu);
    List<List<MenuItem>> data =
        (jsonDecode(responseData) as List)
            .map<List<MenuItem>>(
              (group) =>
                  (group as List)
                      .map<MenuItem>((item) => MenuItem.fromJson(item))
                      .toList(),
            )
            .toList();

    menuGroups.value = data;
    loading.value = false;
  }
}
