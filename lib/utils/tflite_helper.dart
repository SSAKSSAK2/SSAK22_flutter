import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TFLiteHelper {
  static const int IMG_SIZE = 128;
  static const int NUM_CLASSES = 10;
  static late Interpreter _interpreter;

  /* 모델 로드 ------------------------------------------------------------ */
  static Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model.tflite');
  }

  /* 예측 실행 ------------------------------------------------------------ */
  static Future<int> predict(Uint8List bytes) async {
    // 1) 이미지 디코딩 & 리사이즈
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw Exception('이미지 디코딩 실패');
    }
    final resized = img.copyResize(decoded, width: IMG_SIZE, height: IMG_SIZE);

    // 2) 입력 텐서 준비  [1,128,128,3]
    final input = List.generate(
      1,
      (_) => List.generate(
        IMG_SIZE,
        (_) => List.generate(IMG_SIZE, (_) => List.filled(3, 0.0)),
      ),
    );

    // 3) 픽셀 → Float32 로 변환 (Pixel API 사용)
    for (int y = 0; y < IMG_SIZE; y++) {
      for (int x = 0; x < IMG_SIZE; x++) {
        final px = resized.getPixel(x, y); // Pixel 객체
        final r = px.r; // 0‧‧255
        final g = px.g;
        final b = px.b;

        input[0][y][x][0] = r / 255.0;
        input[0][y][x][1] = g / 255.0;
        input[0][y][x][2] = b / 255.0;
      }
    }

    // 4) 출력 버퍼  [1,NUM_CLASSES]
    final output = List.generate(1, (_) => List.filled(NUM_CLASSES, 0.0));

    // 5) 모델 실행
    _interpreter.run(input, output);

    // 6) 최고 확률 인덱스 반환
    final probs = output[0];
    int best = 0;
    for (int i = 1; i < probs.length; i++) {
      if (probs[i] > probs[best]) best = i;
    }
    return best;
  }
}
