import 'login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFAF6DF),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 314,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: const Color(0xFFFEFDF7),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 상단 제목 + 캐릭터
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Image.asset(
                      'assets/images/character_hi.png',
                      width: 84,
                      height: 85,
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // 이메일
                _buildLabeledTextField("아이디 (e-mail)", "이메일 주소"),
                const SizedBox(height: 15),

                // 비밀번호
                _buildLabeledTextField("비밀번호", "비밀번호", obscure: true),
                const SizedBox(height: 15),

                // 이름
                _buildLabeledTextField("이름", "성명을 입력하세요"),
                const SizedBox(height: 15),

                // 휴대폰 번호
                _buildLabeledTextField("휴대폰 번호", "‘-’ 구분없이 입력"),

                const SizedBox(height: 30),

                // 회원가입 버튼
                SizedBox(
                  width: 256,
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: 회원가입 처리
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEFE9C9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      shadowColor: Colors.black26,
                      elevation: 4,
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField(
    String label,
    String hint, {
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(239, 233, 201, 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 40,
          child: TextField(
            obscureText: obscure,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xFF7E7F7F),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
