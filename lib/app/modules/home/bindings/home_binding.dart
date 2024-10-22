import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../data/providers/api_provider.dart'; // นำเข้า ApiProvider

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider()); // ลงทะเบียน ApiProvider
    Get.put(HomeController()); // ลงทะเบียน HomeController
  }
}
