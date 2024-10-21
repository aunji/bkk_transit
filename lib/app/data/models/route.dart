import 'station.dart';

class TransitRoute {
  final Station start;
  final Station end;
  final List<Station> stations;
  final int totalStations;
  final List<String> lines;
  final int estimatedTime; // เวลาในนาที
  final bool hasTransfer;

  TransitRoute({
    required this.start,
    required this.end,
    required this.stations,
    required this.totalStations,
    required this.lines,
    required this.estimatedTime,
    required this.hasTransfer,
  });

  factory TransitRoute.fromJson(Map<String, dynamic> json) {
    return TransitRoute(
      start: Station.fromJson(json['start']),
      end: Station.fromJson(json['end']),
      stations: (json['stations'] as List).map((station) => Station.fromJson(station)).toList(),
      totalStations: json['totalStations'],
      lines: List<String>.from(json['lines']),
      estimatedTime: json['estimatedTime'],
      hasTransfer: json['hasTransfer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start.toJson(),
      'end': end.toJson(),
      'stations': stations.map((station) => station.toJson()).toList(),
      'totalStations': totalStations,
      'lines': lines,
      'estimatedTime': estimatedTime,
      'hasTransfer': hasTransfer,
    };
  }
}
