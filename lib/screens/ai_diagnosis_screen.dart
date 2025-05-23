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
  bool _modelReady = false;
  Uint8List? _image;

  final List<Map<String, String>> diseaseInfo = [
    {
      "name": "세균 반점병",
      "symptom": "잎, 줄기, 열매에 작은 검은 점. 점점 퍼지며 황색 테두리 형성.",
      "treatment": "구리 계통 농약 살포, 병든 잎 제거, 씨앗 소독.",
    },
    {
      "name": "잎곰팡이병 (초기)",
      "symptom": "잎에 갈색 원형 무늬, 중심이 고리 모양.",
      "treatment": "살균제(클로로탈로닐, 만코제브), 작물 윤작.",
    },
    {
      "name": "잎마름병 (후기)",
      "symptom": "잎에 회갈색 물결 모양 병반, 습한 날에 급속히 퍼짐.",
      "treatment": "살균제(메탈락실, 만코제브), 감자와 격리 재배.",
    },
    {
      "name": "잎곰팡이병",
      "symptom": "잎 뒷면에 노란 점, 점차 갈색 곰팡이로 발전.",
      "treatment": "환기 개선, 곰팡이 제거용 살균제(예: 클로로탈로닐).",
    },
    {
      "name": "점무늬병",
      "symptom": "작은 원형 회색 반점, 중심에 검은 점(포자).",
      "treatment": "병든 잎 제거, 살균제(예: 만코제브) 사용.",
    },
    {
      "name": "거미 진드기 피해",
      "symptom": "잎에 노란 점, 점점 마르고 거미줄 생성.",
      "treatment": "아바멕틴, 식물성 오일 계열 살충제 사용.",
    },
    {
      "name": "표적무늬병",
      "symptom": "중심에 고리 형태 반점이 생겨 표적 모양.",
      "treatment": "살균제(예: 클로로탈로닐, 보르도액), 물 관리 철저.",
    },
    {
      "name": "노란잎말림바이러스",
      "symptom": "잎이 노랗고 안쪽으로 말림. 생장 저해.",
      "treatment": "치료제 없음. 감염 식물 제거, 매개충 방제.",
    },
    {
      "name": "토마토 모자이크 바이러스",
      "symptom": "잎에 얼룩덜룩한 색 변화, 기형 발생.",
      "treatment": "치료제 없음. 병든 식물 제거, 손 세척, 도구 소독.",
    },
    {
      "name": "건강한 토마토",
      "symptom": "병에 걸리지 않은 건강한 상태입니다.",
      "treatment": "특별한 조치 없이 건강 유지.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  Future<void> _initModel() async {
    try {
      await TFLiteHelper.loadModel();
      setState(() {
        _modelReady = true;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("오류"),
              content: Text("모델 로딩 실패: $e"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("확인"),
                ),
              ],
            ),
      );
    }
  }

  Future<void> _pickImage() async {
    if (!_modelReady) return;

    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final bytes = await file.readAsBytes();
    final pred = await TFLiteHelper.predict(bytes);
    final predIndex = int.tryParse(pred.toString()) ?? 0;
    final info = diseaseInfo[predIndex];

    setState(() {
      _image = bytes;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFFF9F4FF),
          title: Row(
            children: [
              const Text("🌿 "),
              Text(
                "진단 결과 (${info['name']})",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_image != null) Image.memory(_image!, height: 160),
              const SizedBox(height: 12),
              Text(
                "🧪 증상: ${info['symptom']}",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "💊 치료: ${info['treatment']}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      appBar: AppBar(
        title: const Text('AI 진단'),
        backgroundColor: const Color(0xFFFCF8E8),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/mascot_ai.png', height: 120),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _modelReady ? _pickImage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB0E57C),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                _modelReady ? '사진 업로드' : '모델 로딩 중...',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                "사진 한 장만 업로드하세요!\n⭐ 싹싹이가 필요한 조언을 드릴게요 ⭐",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
