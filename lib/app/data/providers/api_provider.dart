import 'package:get/get.dart';
import '../models/station.dart';
import '../models/route.dart';
import '../mock_data.dart';

class ApiProvider extends GetConnect {
  bool useMockData = true; // เพิ่มตัวแปรนี้เพื่อควบคุมการใช้ข้อมูลจำลอง

  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.example.com'; // URL ของ API จริง
    super.onInit();
  }

  Future<List<Station>> getStations() async {
    if (useMockData) {
      // ใช้ข้อมูลจำลอง
      await Future.delayed(Duration(seconds: 1)); // จำลองความล่าช้าของเครือข่าย
      return MockData.getStations(); // เปลี่ยนเป็น getStations ให้ตรงกับชื่อเมธอดใน MockData
    } else {
      // ใช้ API จริง
      final response = await get('/api/stations');
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        return (response.body['data'] as List).map((item) => Station.fromJson(item)).toList();
      }
    }
  }

  Future<TransitRoute> searchRoute(String startId, String endId) async {
    if (useMockData) {
      try {
        await Future.delayed(Duration(seconds: 1)); // จำลองความล่าช้าของเครือข่าย
        return MockData.findBestRoute(startId, endId);
      } catch (e) {
        throw Exception('Error in mock searchRoute: ${e.toString()}');
      }
    } else {
      // ใช้ API จริง (ยังไม่ได้ implement)
      throw UnimplementedError('Real API not implemented yet');
    }
  }
}
