class DiaryEntry {
  final String date; // 예: "2025.05.24"
  final String memo;
  final List<String> actions; // 예: ["물 주기", "분갈이"]
  final String? imagePath; // asset 경로 또는 file 경로

  DiaryEntry({
    required this.date,
    required this.memo,
    required this.actions,
    this.imagePath,
  });

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      date: json['date'],
      memo: json['memo'],
      actions: List<String>.from(json['actions']),
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'memo': memo,
      'actions': actions,
      'imagePath': imagePath,
    };
  }
}
