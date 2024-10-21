import 'package:bkk_transit/app/data/models/station.dart';
import 'package:bkk_transit/app/data/models/route.dart';
import 'package:flutter/material.dart';

class MockData {
  static List<Station> getStations() {
    return [
      Station(id: 'BTS001', name: 'สยาม', line: 'BTS สุขุมวิท', color: Colors.lightGreen, distance: 0, isTransfer: true),
      Station(id: 'BTS002', name: 'ชิดลม', line: 'BTS สุขุมวิท', color: Colors.lightGreen, distance: 1.2),
      Station(id: 'BTS003', name: 'เพลินจิต', line: 'BTS สุขุมวิท', color: Colors.lightGreen, distance: 2.1),
      Station(id: 'BTS004', name: 'นานา', line: 'BTS สุขุมวิท', color: Colors.lightGreen, distance: 3.4),
      Station(id: 'BTS005', name: 'อโศก', line: 'BTS สุขุมวิท', color: Colors.lightGreen, distance: 4.5, isTransfer: true),
      Station(id: 'MRT001', name: 'สุขุมวิท', line: 'MRT', color: Colors.blue, distance: 4.5, isTransfer: true),
      Station(id: 'MRT002', name: 'เพชรบุรี', line: 'MRT', color: Colors.blue, distance: 6.2),
      Station(id: 'MRT003', name: 'พระราม 9', line: 'MRT', color: Colors.blue, distance: 7.5),
      Station(id: 'MRT004', name: 'ศูนย์วัฒนธรรมแห่งประเทศไทย', line: 'MRT', color: Colors.blue, distance: 8.8),
    ];
  }

  static Map<String, Map<String, int>> getConnections() {
    return <String, Map<String, int>>{
      'BTS001': {'BTS002': 2},
      'BTS002': {'BTS001': 2, 'BTS003': 2},
      'BTS003': {'BTS002': 2, 'BTS004': 2},
      'BTS004': {'BTS003': 2, 'BTS005': 2},
      'BTS005': {'BTS004': 2, 'BTS006': 2, 'MRT001': 3},
      'BTS006': {'BTS005': 2},
      'BTS007': {'BTS001': 3, 'BTS008': 2},
      'BTS008': {'BTS007': 2, 'BTS009': 2},
      'BTS009': {'BTS008': 2},
      'MRT001': {'BTS005': 3, 'MRT002': 3},
      'MRT002': {'MRT001': 3, 'MRT003': 3},
      'MRT003': {'MRT002': 3, 'MRT004': 3},
      'MRT004': {'MRT003': 3},
    };
  }

  static TransitRoute findBestRoute(String startId, String endId) {
    print('Finding route from $startId to $endId');
    var stations = getStations();
    var connections = getConnections();
    var distances = Map<String, int>.fromIterable(stations.map((s) => s.id), value: (_) => 1000000);
    var previous = Map<String, String?>();
    distances[startId] = 0;

    var queue = stations.map((s) => s.id).toList();

    while (queue.isNotEmpty) {
      queue.sort((a, b) => (distances[a] ?? 1000000).compareTo(distances[b] ?? 1000000));
      var current = queue.removeAt(0);

      if (current == endId) break;

      for (var neighbor in connections[current]?.keys ?? []) {
        if (neighbor is String) {
          // เพิ่มการตรวจสอบประเภทข้อมูล
          var alt = (distances[current] ?? 0) + (connections[current]?[neighbor] ?? 0);
          if (alt < (distances[neighbor] ?? 1000000)) {
            distances[neighbor] = alt;
            previous[neighbor] = current;
          }
        }
      }
    }

    var path = <String>[];
    String? current = endId;
    while (current != null) {
      path.add(current);
      current = previous[current];
    }
    path = path.reversed.toList();

    var routeStations = path.map((id) => stations.firstWhere((s) => s.id == id)).toList();
    var lines = routeStations.map((s) => s.line).toSet().toList();
    var estimatedTime = distances[endId] ?? 0;

    print('Route found: ${routeStations.map((s) => s.name).join(' -> ')}');
    return TransitRoute(
      start: routeStations.first,
      end: routeStations.last,
      stations: routeStations,
      totalStations: routeStations.length,
      lines: lines,
      estimatedTime: estimatedTime,
      hasTransfer: routeStations.any((s) => s.isTransfer),
    );
  }
}
