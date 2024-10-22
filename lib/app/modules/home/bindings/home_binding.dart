import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:bkk_transit/app/data/providers/api_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider());
    Get.put(HomeController());
  }
}
