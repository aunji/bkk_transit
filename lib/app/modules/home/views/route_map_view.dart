import 'package:bkk_transit/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bkk_transit/app/data/models/route.dart';
import 'package:bkk_transit/app/data/models/station.dart';

class RouteMapView extends GetView<HomeController> {
  final TransitRoute route;

  const RouteMapView({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomPaint(
          painter: RouteMapPainter(
            route: route,
            isDarkMode: controller.isDarkMode.value,
            textColor: controller.textColor,
          ),
          size: Size.infinite,
        ));
  }
}

class RouteMapPainter extends CustomPainter {
  final TransitRoute route;
  final bool isDarkMode;
  final Color textColor;

  RouteMapPainter({
    required this.route,
    required this.isDarkMode,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 2;

    final stationPaint = Paint()..style = PaintingStyle.fill;

    final stationPositions = _calculateStationPositions(size);

    // วาดเส้นทาง
    String currentLine = route.stations.first.line;
    for (int i = 0; i < stationPositions.length - 1; i++) {
      paint.color = route.stations[i].color;
      canvas.drawLine(stationPositions[i], stationPositions[i + 1], paint);
      if (route.stations[i + 1].line != currentLine) {
        currentLine = route.stations[i + 1].line;
        // วาดเส้นเชื่อมระหว่างสถานีเปลี่ยนสาย
        canvas.drawLine(stationPositions[i], stationPositions[i + 1], paint..color = Colors.pinkAccent);
      }
    }

    // วาดสถานีและชื่อสถานี
    bool isHorizontal = true; // เริ่มต้นด้วยแนวนอน
    for (int i = 0; i < stationPositions.length; i++) {
      final station = route.stations[i];
      final position = stationPositions[i];

      if (i > 0 && station.line != route.stations[i - 1].line) {
        isHorizontal = !isHorizontal; // สลับทิศทางเมื่อเปลี่ยนสาย
      }

      stationPaint.color = station.color;

      if (station.isTransfer) {
        // วาดสถานีเปลี่ยนสาย
        canvas.drawCircle(position, 8, stationPaint);
        canvas.drawCircle(position, 6, Paint()..color = Colors.white);
        canvas.drawCircle(position, 4, stationPaint);
        // แยกชื่อสถานีเปลี่ยนสายเป็นสองบรรทัด
        _drawWrappedText(canvas, '${station.name}\n(${station.line})', position, station, isHorizontal, maxWidth: 80);
      } else {
        // วาดสถานีปกติ
        canvas.drawCircle(position, 5, stationPaint);
        // วาดชื่อสถานีปกติ
        _drawWrappedText(canvas, station.name, position, station, isHorizontal, maxWidth: 60);
      }
    }
  }

  List<Offset> _calculateStationPositions(Size size) {
    final double width = size.width;
    final double height = size.height;
    final double horizontalSpace = width * 0.7;
    final double verticalSpace = height * 0.6;

    List<Offset> positions = [];
    String currentLine = route.stations.first.line;
    double horizontalPosition = width * 0.1;
    double verticalPosition = height * 0.2;

    for (var station in route.stations) {
      if (station.line != currentLine) {
        // เปลี่ยนทิศทางเมื่อเปลี่ยนสาย
        currentLine = station.line;
        horizontalPosition = positions.last.dx;
        verticalPosition = positions.last.dy;
      }

      double yOffset = station.isTransfer ? width * 0.1 : 0;
      double xOffset = station.isTransfer ? height * 0.05 : 0;

      if (station.line == route.stations.first.line) {
        // สถานีในแนวนอน
        positions.add(Offset(horizontalPosition, verticalPosition));
        horizontalPosition += horizontalSpace / (route.stations.where((s) => s.line == currentLine).length - 1);
      } else {
        // สถานีในแนวตั้ง
        positions.add(Offset(horizontalPosition + xOffset, verticalPosition + yOffset));
        verticalPosition += verticalSpace / (route.stations.where((s) => s.line == currentLine).length - 1);
      }
    }

    return positions;
  }

  @override
  bool shouldRepaint(RouteMapPainter oldDelegate) {
    return oldDelegate.isDarkMode != isDarkMode || oldDelegate.route != route || oldDelegate.textColor != textColor;
  }

  void _drawWrappedText(Canvas canvas, String text, Offset position, Station station, bool isHorizontal, {double maxWidth = 60}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 3,
    );

    textPainter.layout(maxWidth: maxWidth);

    final textPosition = isHorizontal ? Offset(position.dx - textPainter.width / 2, position.dy - textPainter.height - 10) : Offset(position.dx + 10, position.dy - textPainter.height / 2);

    textPainter.paint(canvas, textPosition);
  }
}
