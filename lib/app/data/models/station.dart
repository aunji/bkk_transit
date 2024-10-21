import 'package:flutter/material.dart';

class Station {
  final String id;
  final String name;
  final String line;
  final Color color;
  final double distance; // เพิ่มระยะทางจากสถานีแรก
  final bool isTransfer; // เพิ่มสถานะว่าเป็นสถานีเปลี่ยนสายหรือไม่

  Station({
    required this.id,
    required this.name,
    required this.line,
    required this.color,
    required this.distance,
    this.isTransfer = false,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'],
      name: json['name'],
      line: json['line'],
      color: Color(int.parse(json['color'], radix: 16)),
      distance: json['distance'],
      isTransfer: json['isTransfer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'line': line,
      'color': color.value.toRadixString(16),
      'distance': distance,
      'isTransfer': isTransfer,
    };
  }
}
