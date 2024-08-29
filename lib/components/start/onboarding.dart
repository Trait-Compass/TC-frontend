import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
                    Navigator.pushReplacementNamed(context, '/main'); // 나중에 수정
                  },
                  child: Text('회원가입하기', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // 카카오 로그인 처리
                  },
                  icon: Icon(Icons.chat_bubble, color: Colors.black),
                  label:
                      Text('카카오로 시작하기', style: TextStyle(color: Colors.black)),
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
