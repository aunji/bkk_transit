import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/route.dart';
import '../../../data/models/station.dart';

class RouteMapView extends StatelessWidget {
  final TransitRoute route;

  RouteMapView({required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400, // ปรับความสูงตามต้องการ
      child: CustomPaint(
        painter: RouteMapPainter(route: route),
        child: Container(),
      ),
    );
  }
}

class RouteMapPainter extends CustomPainter {
  final TransitRoute route;

  RouteMapPainter({required this.route});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 2;

    final stationPaint = Paint()..style = PaintingStyle.fill;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final stationPositions = _calculateStationPositions(size);

    // วาดเส้นทาง
    String currentLine = route.stations.first.line;
    for (int i = 0; i < stationPositions.length - 1; i++) {
      paint.color = route.stations[i].color;
      canvas.drawLine(stationPositions[i], stationPositions[i + 1], paint);
      if (route.stations[i + 1].line != currentLine) {
        currentLine = route.stations[i + 1].line;
        // วาดเส้นเชื่อมระหว่างสถานีเปลี่ยนสาย
        canvas.drawLine(stationPositions[i], stationPositions[i + 1], paint..color = Colors.grey);
      }
    }

    // วาดสถานีและชื่อสถานี
    for (int i = 0; i < stationPositions.length; i++) {
      final station = route.stations[i];
      final position = stationPositions[i];

      stationPaint.color = station.color;

      if (station.isTransfer) {
        // วาดสถานีเปลี่ยนสาย
        canvas.drawCircle(position, 8, stationPaint);
        canvas.drawCircle(position, 6, Paint()..color = Colors.white);
        canvas.drawCircle(position, 4, stationPaint);
        // แยกชื่อสถานีเปลี่ยนสายเป็นสองบรรทัด
        textPainter.text = TextSpan(
          text: '${station.name}\n(${station.line})',
          style: TextStyle(color: Colors.black, fontSize: 10),
        );
        textPainter.layout();
        final textPosition = Offset(position.dx + 10, position.dy - textPainter.height / 2);
        textPainter.paint(canvas, textPosition);
      } else {
        // วาดสถานีปกติ
        canvas.drawCircle(position, 5, stationPaint);
        // วาดชื่อสถานีปกติ
        textPainter.text = TextSpan(
          text: station.name,
          style: TextStyle(color: Colors.black, fontSize: 10),
        );
        textPainter.layout();
        // ปรับตำแหน่งข้อความตามทิศทางของเส้นทาง
        final textPosition = station.line == route.stations.first.line ? Offset(position.dx, position.dy + 10) : Offset(position.dx + 10, position.dy);
        textPainter.paint(canvas, textPosition);
      }
    }
  }

  List<Offset> _calculateStationPositions(Size size) {
    final double width = size.width;
    final double height = size.height;
    final double horizontalSpace = width * 0.8; // ใช้ 80% ของความกว้าง
    final double verticalSpace = height * 0.6; // ใช้ 60% ของความสูง

    List<Offset> positions = [];
    String currentLine = route.stations.first.line;
    double horizontalPosition = width * 0.1; // เริ่มที่ 10% ของความกว้าง
    double verticalPosition = height * 0.2; // เริ่มที่ 20% ของความสูง

    for (var station in route.stations) {
      if (station.line != currentLine) {
        // เปลี่ยนทิศทางเมื่อเปลี่ยนสาย
        currentLine = station.line;
        horizontalPosition = positions.last.dx;
        verticalPosition = positions.last.dy;
      }

      if (station.line == route.stations.first.line) {
        // สถานีในแนวนอน
        positions.add(Offset(horizontalPosition, verticalPosition));
        horizontalPosition += horizontalSpace / (route.stations.where((s) => s.line == currentLine).length - 1);
      } else {
        // สถานีในแนวตั้ง
        positions.add(Offset(horizontalPosition, verticalPosition));
        verticalPosition += verticalSpace / (route.stations.where((s) => s.line == currentLine).length - 1);
      }
    }

    return positions;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
