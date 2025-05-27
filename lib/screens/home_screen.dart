import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 아이콘들
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 캘린더 아이콘
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () {
                      // TODO: 캘린더 페이지로 이동

                    },
                  ),
                  // 상점 아이콘 + 포인트
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.local_grocery_store),
                        onPressed: () {
                          // TODO: 상점 페이지로 이동

                        },
                      ),
                      const SizedBox(width: 4),
                      const Row(
                        children: [
                          Icon(Icons.local_fire_department, color: Colors.orange),
                          SizedBox(width: 4),
                          Text("130p", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 캐릭터 이미지
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/character_hi.png', // ← 실제 이미지 파일 경로로 교체 필요
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 말풍선 텍스트
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                  ],
                ),
                child: const Text(
                  "오늘 물은 주셨나요?\n""도레미파 물 줄 시간입니당ㅏ!!""",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
