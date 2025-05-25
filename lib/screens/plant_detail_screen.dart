import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../models/plant_model.dart';
import '../models/diary_entry.dart';
import 'diary_editor_screen.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;
  const PlantDetailScreen({super.key, required this.plant});

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Set<String> markedDates = {};

  List<DiaryEntry> getEntriesForMonth(DateTime focusedDay) {
    final currentMonth = focusedDay.month;
    final currentYear = focusedDay.year;

    return widget.plant.diaryList.where((entry) {
      final parts = entry.date.split('.');
      if (parts.length != 3) return false;
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      return year == currentYear && month == currentMonth;
    }).toList();
  }

  DiaryEntry? getEntryForDay(DateTime day) {
    final key = DateFormat('yyyy.MM.dd').format(day);
    try {
      return widget.plant.diaryList.firstWhere((e) => e.date == key);
    } catch (_) {
      return null;
    }
  }

  Widget _buildActivityChips(List<String> actions) {
    return Wrap(
      spacing: 6.0,
      children: actions.map((action) {
        return Chip(
          label: Text(action),
          backgroundColor: const Color(0xFFD8E4BC),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;

    final now = DateTime.now();
    final nextWaterDay = plant.lastWatered.add(Duration(days: plant.waterCycleDays));
    final remainingDays = nextWaterDay.difference(now).inDays;
    final waterStatusText = remainingDays <= 0 ? "\uD83D\uDCA7 오늘 물 주기!" : "물 주기까지 D-$remainingDays";

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
              child: plant.image.isNotEmpty
                  ? Image.asset(plant.image, height: 180, fit: BoxFit.cover)
                  : const Icon(Icons.image, size: 80),
            ),
            const SizedBox(height: 16),
            Text("이름 : ${plant.name}", style: Theme.of(context).textTheme.titleLarge),
            Text(plant.type, style: Theme.of(context).textTheme.bodyMedium),
            Text("심은 날짜 ${plant.date}", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final existingEntry = getEntryForDay(_focusedDay);
                  final newEntry = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DiaryEditorScreen(
                        existingEntry: existingEntry,
                        date: _focusedDay,
                        plant: plant,
                      ),
                    ),
                  );

                  if (newEntry is DiaryEntry) {
                    final dateKey = newEntry.date;
                    setState(() {
                      plant.diaryList.removeWhere((e) => e.date == dateKey);
                      plant.diaryList.add(newEntry);
                      markedDates.add(dateKey);
                    });
                  }
                },
                icon: const Icon(Icons.book),
                label: const Text("일기 쓰기"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD8E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(waterStatusText, style: Theme.of(context).textTheme.titleMedium),
            Text("권장 주기: ${plant.waterCycleDays}일", style: Theme.of(context).textTheme.bodyMedium),
            Text("마지막으로 물 준 날짜: ${plant.lastWatered.toString().split(' ')[0]}",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              eventLoader: (day) {
                final key = DateFormat('yyyy.MM.dd').format(day);
                return markedDates.contains(key) ? [1] : [];
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                markerDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                markerSize: 6,
              ),
            ),
            const SizedBox(height: 24),
            Text("\uD83D\uDCD3 ${_focusedDay.month}월의 일기장", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getEntriesForMonth(_focusedDay).length,
              itemBuilder: (context, index) {
                final entry = getEntriesForMonth(_focusedDay)[index];
                return Card(
                  color: Colors.green[50],
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.date,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          entry.memo,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: null,
                        ),
                        const SizedBox(height: 10),
                        _buildActivityChips(entry.actions),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
