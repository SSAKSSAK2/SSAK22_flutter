import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // 로그인 화면 파일 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 앱 로딩, 초기화 (토큰 확인, 로컬 저장소 확인 등)
  // 로그인 정보가 있으면 → 홈으로 이동 으로 추후 개발 예정!
  // 일단은 로그인 화면을 초기 화면으로 설정하고 진행해보자.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '로그인 앱',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginScreen(), // 첫 화면으로 로그인 화면 지정
      debugShowCheckedModeBanner: false,
    );
  }
}
