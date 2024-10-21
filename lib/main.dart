import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/data/providers/api_provider.dart';

void main() {
  Get.put(ApiProvider());
  runApp(
    GetMaterialApp(
      title: "BKK Transit",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
