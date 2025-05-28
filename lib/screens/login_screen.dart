import 'package:flutter/material.dart';
import 'package:my_project/screens/FindId_Screen.dart';
import 'package:my_project/screens/FindPassword_screen.dart';
import 'package:my_project/screens/main_screen.dart';
import 'package:my_project/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }
  // 추후에 이메일 양식이 맞는지 or db에 저장된 데이터와 맞는지 확인하고 알려주는 거 필요

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 120), // ← 위쪽 공간 확보
              const SizedBox(height: 40),
              // 캐릭터 이미지
              Image.asset('assets/images/character_hi.png', height: 100),

              const SizedBox(height: 20),

              // 로그인 박스
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 이메일
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: const UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 비밀번호
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'PassWord',
                          prefixIcon: const Icon(Icons.lock),
                          border: const UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 로그인 버튼
                      ElevatedButton(
                        onPressed: () {
                          // TODO: 아이디/ 비번 확인 시스템 만들기
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEFE9C9),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('LOGIN'),
                      ),

                      const SizedBox(height: 12),

                      // 하단 텍스트 링크
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 아이디 찾기
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FindIdScreen(),
                                ),
                              );
                            },
                            child: const Text("아이디 찾기"),
                          ),
                          const Text("|"),
                          // 비밀번호 찾기
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const FindPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text("비밀번호 찾기"),
                          ),
                          const Text("|"),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text("회원가입"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //카카오 로그인 버튼 이미지
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: GestureDetector(
                  onTap: () {
                    // TODO: 카카오 로그인 연동 처리
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("카카오 연동 로그인")));
                  },
                  child: Image.asset(
                    'assets/images/kakao_login_large_wide.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
