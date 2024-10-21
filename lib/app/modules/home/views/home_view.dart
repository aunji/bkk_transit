import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'route_map_view.dart';
import '../../../data/models/station.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BKK Transit'),
        centerTitle: true,
      ),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<Station>(
                    hint: Text('เลือกสถานีต้นทาง'),
                    value: controller.selectedStartStation.value,
                    onChanged: (Station? newValue) {
                      controller.selectedStartStation.value = newValue;
                    },
                    items: controller.stations.map((Station station) {
                      return DropdownMenuItem<Station>(
                        value: station,
                        child: Text(station.name),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  DropdownButton<Station>(
                    hint: Text('เลือกสถานีปลายทาง'),
                    value: controller.selectedEndStation.value,
                    onChanged: (Station? newValue) {
                      controller.selectedEndStation.value = newValue;
                    },
                    items: controller.stations.map((Station station) {
                      return DropdownMenuItem<Station>(
                        value: station,
                        child: Text(station.name),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.searchRoute,
                    child: Text('ค้นหาเส้นทาง'),
                  ),
                  SizedBox(height: 16),
                  if (controller.selectedRoute.value != null)
                    Container(
                      height: 400, // ปรับความสูงตามต้องการ
                      child: RouteMapView(route: controller.selectedRoute.value!),
                    ),
                  if (controller.selectedRoute.value != null) ...[
                    SizedBox(height: 16),
                    Text('เส้นทาง:'),
                    ...controller.selectedRoute.value!.stations.map((station) => Text('- ${station.name} (${station.line})')),
                    SizedBox(height: 8),
                    Text('จำนวนสถานีทั้งหมด: ${controller.selectedRoute.value!.totalStations}'),
                    Text('เวลาโดยประมาณ: ${controller.selectedRoute.value!.estimatedTime} นาที'),
                  ],
                ],
              ),
            ),
          )),
    );
  }
}
