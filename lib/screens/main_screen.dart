import 'package:flutter/material.dart';
import 'package:my_project/screens/ai_diagnosis_screen.dart';
import 'package:my_project/screens/home_screen.dart';
import 'plant_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 1대 1로 매칭 될 예정!
  final List<Widget> _screens = [
    HomeScreen(),
    PlantListScreen(),
    AiDiagnosisScreen(),
    // MyPagescreen()
  ];

  // 화면 전환 메소드
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 아이콘 변화 필요
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory, // 클릭 시 물결 애니메이션 제거
          highlightColor: Colors.transparent, // 하이라이트 제거
          splashColor: Colors.transparent, // 스플래시 컬러 제거
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFFCF8E8),
          currentIndex: _selectedIndex,
          onTap: _onTap,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: '식물'),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome),
              label: 'AI',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
          ],
        ),
      ),
    );
  }
}
