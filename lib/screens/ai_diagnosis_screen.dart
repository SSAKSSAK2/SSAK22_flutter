import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/tflite_helper.dart';

class AiDiagnosisScreen extends StatefulWidget {
  const AiDiagnosisScreen({super.key});

  @override
  State<AiDiagnosisScreen> createState() => _AiDiagnosisScreenState();
}

class _AiDiagnosisScreenState extends State<AiDiagnosisScreen> {
  bool _modelReady = false; // 모델 로딩 완료 여부
  Uint8List? _image;
  String result = '모델을 불러오는 중...';

  /* ── 모델 로드 ─────────────────────────────────────────────── */
  @override
  void initState() {
    super.initState();
    _initModel();
  }

  Future<void> _initModel() async {
    try {
      await TFLiteHelper.loadModel(); // 모델 로딩
      setState(() {
        _modelReady = true;
        result = '이미지를 업로드하세요.';
      });
    } catch (e) {
      setState(() => result = '모델 로드 실패: $e');
    }
  }

  /* ── 이미지 선택 & 예측 ─────────────────────────────────────── */
  Future<void> _pickImage() async {
    if (!_modelReady) return; // 안전장치

    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;

    final bytes = await file.readAsBytes();
    final pred = await TFLiteHelper.predict(bytes);

    setState(() {
      _image = bytes;
      result = '예측된 클래스: $pred';
    });
  }

  /* ── UI ───────────────────────────────────────────────────── */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI 진단')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _modelReady ? _pickImage : null,
              child: Text(_modelReady ? '사진 업로드' : '모델 로딩 중...'),
            ),
            const SizedBox(height: 20),
            if (_image != null) Image.memory(_image!, height: 200),
            const SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}
