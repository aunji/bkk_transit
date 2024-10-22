import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/station.dart';
import '../../../data/models/route.dart';
import '../../../data/providers/api_provider.dart';
import 'package:bkk_transit/app/themes/app_theme.dart';

class HomeController extends GetxController {
  final ApiProvider apiProvider = Get.find<ApiProvider>();
  final stations = <Station>[].obs;
  final selectedStartStation = Rxn<Station>();
  final selectedEndStation = Rxn<Station>();
  final selectedRoute = Rxn<TransitRoute>();
  final isLoading = false.obs;
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
    fetchStations();
  }

  Future<void> fetchStations() async {
    try {
      isLoading(true);
      stations.value = await apiProvider.getStations();
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถดึงข้อมูลสถานีได้', colorText: Colors.white, backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void setStartStation(Station? station) {
    selectedStartStation.value = station;
  }

  void setEndStation(Station? station) {
    selectedEndStation.value = station;
  }

  Future<void> searchRoute() async {
    if (selectedStartStation.value != null && selectedEndStation.value != null) {
      try {
        isLoading(true);
        selectedRoute.value = await apiProvider.searchRoute(
          selectedStartStation.value!.id,
          selectedEndStation.value!.id,
        );
        // ถ้าสำเร็จ อาจจะแสดงข้อความแจ้งเตือน
        Get.snackbar('สำเร็จ', 'ค้นหาเส้นทางเรียบร้อยแล้ว', colorText: Colors.white, backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        // แสดงรายละเอียดข้อผิดพลาด
        if (kDebugMode) {
          print('Error in searchRoute: $e');
        }
        Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถค้นหาเส้นทางได้: ${e.toString()}', colorText: Colors.white, backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar('ข้อมูลไม่ครบ', 'กรุณาเลือกสถานีต้นทางและปลายทาง', colorText: Colors.white, backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    update(); // เรียก update เพื่อทริกเกอร์การรีบิวด์ UI
  }

  Color get textColor => isDarkMode.value ? Colors.white : Colors.black;
}
