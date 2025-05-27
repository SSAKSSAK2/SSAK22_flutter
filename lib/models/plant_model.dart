import 'diary_entry.dart';

class Plant {
  final String name;
  final String type;
  final String water;
  final String date; // 심은 날짜 (String)
  final String image;
  final bool urgent;

  List<DiaryEntry> diaryList; // 수정 가능한 리스트, final 제거

  final DateTime lastWatered;       // 마지막 물 준 날짜
  final int waterCycleDays;         // 며칠마다 물 줘야 하는지

  Plant({
    required this.name,
    required this.type,
    required this.water,
    required this.date,
    required this.image,
    required this.urgent,
    required this.diaryList, // 기본값 없음. 명시적으로 넘겨줘야 함
    required this.lastWatered,
    required this.waterCycleDays,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      name: json['name'],
      type: json['type'],
      water: json['water'],
      date: json['date'],
      image: json['image'],
      urgent: json['urgent'],
      lastWatered: DateTime.parse(json['lastWatered']),
      waterCycleDays: json['waterCycleDays'] ?? 7,
      diaryList: (json['diaryList'] as List<dynamic>?)
          ?.map((e) => DiaryEntry.fromJson(e))
          .toList() ??
          [], // 없으면 빈 리스트로 대체
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'water': water,
      'date': date,
      'image': image,
      'urgent': urgent,
      'lastWatered': lastWatered.toIso8601String(),
      'waterCycleDays': waterCycleDays,
      'diaryList': diaryList.map((e) => e.toJson()).toList(),
    };
  }
}
