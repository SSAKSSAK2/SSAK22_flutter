import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../models/plant_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DiaryEditorScreen extends StatefulWidget {
  final DateTime date;
  final Plant plant;
  final DiaryEntry? existingEntry; // 기존 일기 받기

  const DiaryEditorScreen({
    super.key,
    required this.date,
    required this.plant,
    this.existingEntry,
  });

  @override
  State<DiaryEditorScreen> createState() => _DiaryEditorScreenState();
}

class _DiaryEditorScreenState extends State<DiaryEditorScreen> {
  late TextEditingController _memoController;
  Map<String, bool> _activities = {
    '물 주기': false,
    '분갈이': false,
    '영양제': false,
  };
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _memoController = TextEditingController(text: widget.existingEntry?.memo ?? '');

    if (widget.existingEntry != null) {
      for (final action in widget.existingEntry!.actions) {
        if (_activities.containsKey(action)) {
          _activities[action] = true;
        }
      }
      if (widget.existingEntry!.imagePath != null) {
        _selectedImage = File(widget.existingEntry!.imagePath!);
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _saveDiary() {
    final dateStr = DateFormat('yyyy.MM.dd').format(widget.date);
    final selectedActions = _activities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    final newEntry = DiaryEntry(
      date: dateStr,
      memo: _memoController.text,
      actions: selectedActions,
      imagePath: _selectedImage?.path,
    );

    Navigator.pop(context, newEntry);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yy.MM.dd').format(widget.date);

    return Scaffold(
      appBar: AppBar(title: Text("${widget.plant.name} 일기장")),
      backgroundColor: const Color(0xFFFCF8E8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: _selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(_selectedImage!, height: 180),
                )
                    : Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.add_a_photo, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("메모", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            TextField(
              controller: _memoController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "$formattedDate\n오늘 어떤 일이 있었나요?",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            const Text("활동", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._activities.keys.map((activity) => CheckboxListTile(
              value: _activities[activity],
              onChanged: (bool? value) {
                setState(() {
                  _activities[activity] = value ?? false;
                });
              },
              title: Text(activity),
              controlAffinity: ListTileControlAffinity.leading,
            )),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveDiary,
                icon: const Icon(Icons.check),
                label: const Text("저장하기"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD8E4BC),
                  foregroundColor: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
