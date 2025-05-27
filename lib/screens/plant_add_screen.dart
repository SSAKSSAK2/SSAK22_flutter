import 'package:flutter/material.dart';
import '../models/plant_model.dart';

class PlantAddScreen extends StatefulWidget {
  const PlantAddScreen({super.key});

  @override
  State<PlantAddScreen> createState() => _PlantAddScreenState();
}

class _PlantAddScreenState extends State<PlantAddScreen> {
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final imageController = TextEditingController();
  final waterCycleController = TextEditingController();

  bool urgent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("식물 추가")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "식물 이름"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: "식물 종류"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "이미지 URL (비워도 됨)"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: waterCycleController,
              decoration: const InputDecoration(labelText: "물 주기 주기 (일 단위)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text("물 주기 급함"),
                Switch(
                  value: urgent,
                  onChanged: (value) {
                    setState(() {
                      urgent = value;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty || typeController.text.isEmpty) return;

                final newPlant = Plant(
                  name: nameController.text,
                  type: typeController.text,
                  water: urgent ? "오늘 물주기!!" : "D-${waterCycleController.text}",
                  date: DateTime.now().toString().split(' ')[0],
                  image: imageController.text,
                  urgent: urgent,
                  lastWatered: DateTime.now(),
                  waterCycleDays: int.tryParse(waterCycleController.text) ?? 3,
                  diaryList: [], //새 식물이니까 일기는 빈 리스트로 시작
                );

                Navigator.pop(context, newPlant);
              },
              child: const Text("추가하기"),
            ),
          ],
        ),
      ),
    );
  }
}
