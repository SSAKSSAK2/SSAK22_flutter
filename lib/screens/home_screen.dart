import 'package:flutter/material.dart';
import 'shop_screen.dart';

// 캘린더, 상점 페이지 import 또는 동일 파일 하단 클래스 참고
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 아이콘
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 캘린더 아이콘
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarPage(),
                        ),
                      );
                    },
                  ),
                  // 상점 + 포인트
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.local_grocery_store),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Row(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "130p",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 배경 이미지 + 캐릭터 말풍선
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/final_fully_filled_field.png',
                      height: screenHeight,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        "'도레미파' 물 줄 시간이야!!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 추가 페이지들
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캘린더')),
      body: const Center(child: Text('캘린더 페이지입니다')),
    );
  }
}

class StorePage extends StatelessWidget {
  const StorePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상점')),
      body: const Center(child: Text('상점 페이지입니다')),
    );
  }
}
