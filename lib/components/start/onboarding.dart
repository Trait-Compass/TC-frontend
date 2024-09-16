import 'package:flutter/material.dart';
import 'package:untitled/components/mbti_selection_page.dart';
import 'package:untitled/components/basic_frame_page.dart';
import 'package:untitled/hooks/login/loginscreen.dart';
import 'package:untitled/services/auth_services.dart'; // AuthService import 추가
import 'package:http/http.dart' as http; // HTTP 패키지 추가
import 'dart:convert';
import 'package:untitled/services/storagemobile.dart'; // 스토리지 서비스 임포트
import 'package:untitled/components/map/api.dart'; // ApiService 임포트

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Widget> _pages = [
    OnboardingContent(
      title: '여행 계획,\n어떻게 짜시나요?',
    ),
    OnboardingContent(
      title: '경남 지역의 모든 것을\n느껴보세요',
    ),
    OnboardingContent(
      title: 'MBTI로 여행을\n해보세요',
    ),
    OnboardingContent(
      title: '좋아하는 것만\n고르세요',
    ),
    OnboardingContent(
      title: '여행의 감정을\n기록해보세요',
    ),
  ];

  Future<void> _signInWithKakao() async {
    final token = await _authService.signInWithKakao();

    if (token != null) {
      // 서버로 전송하여 로그인/회원가입 요청
      final url = Uri.parse('https://www.traitcompass.store/oauth/kakao');
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'accessToken': token, 'vendor': 'kakao'}),
        );

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 201) {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);

          if (responseBody.containsKey('result')) {
            String? _accessToken = responseBody['result'];

            await _storageService.write(
                key: 'accessToken', value: _accessToken!); // Secure Storage에 저장
            print('Access Token: $_accessToken');

            // ApiService에 accessToken 설정
            ApiService.setAccessToken(_accessToken);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('카카오 로그인 성공!')),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BasicFramePage(body: MBTISelectionPage())),
            );
          } else {
            print('Access Token not found in the response.');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 실패. 상태 코드: ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 중 오류가 발생했습니다: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('카카오 로그인 실패')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (indicatorIndex) {
                        return Container(
                          margin: EdgeInsets.all(4.0),
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == indicatorIndex
                                ? Colors.black
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    _pages[index],
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('회원가입하기', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _signInWithKakao, // 카카오 로그인 API 호출
                  icon: Icon(Icons.chat_bubble, color: Colors.black),
                  label: Text('카카오로 시작하기', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title;

  OnboardingContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
