import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/plant_model.dart';
// import '../models/diary_entry.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;

    //물 주기 관련 계산
    final now = DateTime.now();
    final nextWaterDay = plant.lastWatered.add(
      Duration(days: plant.waterCycleDays),
    );
    final remainingDays = nextWaterDay.difference(now).inDays;

    final waterStatusText =
        remainingDays <= 0 ? "💧 오늘 물 주기!" : "물 주기까지 D-$remainingDays";

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF8E8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
                  plant.image.isNotEmpty
                      ? Image.asset(
                        plant.image,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 80),
                      )
                      : const Icon(Icons.image_not_supported, size: 80),
            ),

            const SizedBox(height: 16),
            Text(
              "이름 : ${plant.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(plant.type, style: const TextStyle(color: Colors.grey)),
            Text(
              "심은 날짜 ${plant.date}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),

            //모델 기반으로 동적으로 표시
            Text(
              waterStatusText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("권장 주기: ${plant.waterCycleDays}일"),
            Text("마지막으로 물 준 날짜: ${plant.lastWatered.toString().split(' ')[0]}"),

            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: 일기쓰기 연결
                },
                icon: const Icon(Icons.book),
                label: const Text("일기 쓰기"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD8E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(height: 12),
            const Text(
              "📓 일기장",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // diaryList에서 불러오기
            ...plant.diaryList.map(
              (entry) => ListTile(
                leading: const Icon(Icons.calendar_today, size: 18),
                title: Text(entry.date),
                trailing: Text(
                  entry.memo,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
