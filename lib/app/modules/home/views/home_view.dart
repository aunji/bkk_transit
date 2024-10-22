import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'route_map_view.dart';
import '../../../data/models/station.dart';
import 'package:bkk_transit/app/themes/app_theme.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('BKK Transit', style: Theme.of(context).textTheme.titleLarge),
            actions: [
              Row(
                children: [
                  Icon(
                    controller.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                    color: controller.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                  Switch(
                    activeColor: Colors.blue,
                    inactiveThumbColor: Colors.black87,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    value: controller.isDarkMode.value,
                    onChanged: (value) => controller.toggleTheme(),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildStationDropdown(
                hint: 'เลือกสถานีต้นทาง',
                value: controller.selectedStartStation.value,
                onChanged: (Station? newValue) {
                  controller.selectedStartStation.value = newValue;
                },
                items: controller.stations,
                context: context,
              ),
              const SizedBox(height: 16),
              _buildStationDropdown(
                hint: 'เลือกสถานีปลายทาง',
                value: controller.selectedEndStation.value,
                onChanged: (Station? newValue) {
                  controller.selectedEndStation.value = newValue;
                },
                items: controller.stations,
                context: context,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.searchRoute,
                child: const Text('ค้นหาเส้นทาง'),
              ),
              const SizedBox(height: 16),
              if (controller.selectedRoute.value != null) ...[
                Container(
                  height: Get.height * 0.4,
                  child: RouteMapView(route: controller.selectedRoute.value!),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _showRouteDetails(context),
                  child: const Text('ดูรายละเอียดเส้นทาง'),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'จำนวนสถานีทั้งหมด:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${controller.selectedRoute.value!.totalStations}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'เวลาโดยประมาณ:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${controller.selectedRoute.value!.estimatedTime} นาที',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ));
  }

  void _showRouteDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('รายละเอียดเส้นทาง', style: Get.textTheme.titleLarge),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...controller.selectedRoute.value!.stations.map((station) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: station.color,
                            radius: 12,
                          ),
                          title: Text(station.name, style: Get.textTheme.bodyMedium),
                          subtitle: Text(station.line, style: Get.textTheme.bodyMedium),
                          trailing: Text('${station.distance} กม.', style: Get.textTheme.bodyMedium),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // ปิด BottomSheet
                  child: const Text('ปิด'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStationDropdown({
    required String hint,
    required Station? value,
    required void Function(Station?) onChanged,
    required List<Station> items,
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Station>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Get.theme.primaryColor),
          hint: Obx(() => Text(
                hint,
                style: Get.textTheme.bodyLarge?.copyWith(
                  color: controller.textColor,
                ),
              )),
          dropdownColor: Theme.of(context).scaffoldBackgroundColor, // Set dropdown background color
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((Station item) {
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(item.name, style: Get.textTheme.bodyMedium),
                ),
              );
            }).toList();
          },
          items: items.map((Station station) {
            return DropdownMenuItem<Station>(
              value: station,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: station.color,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    station.name,
                    style: Get.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
