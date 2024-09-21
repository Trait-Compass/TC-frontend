import 'package:flutter/material.dart';
import 'package:untitled/components/basicframe.dart';
import 'package:untitled/components/mbtitest/resultcard.dart';
import '../mbtitest/0question.dart'; // StartTestSection이 정의된 파일을 임포트

class ResultPage extends StatelessWidget {
  final String selectedOption;

  ResultPage({
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BasicFrame1Page(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(
                color: Color(0xFFE4E4E4),
                thickness: 1,
                height: 1,
              ),
              SizedBox(height: 20),
              Text(
                '나의 여행 MBTI는?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: screenWidth - 40,
                height: 350,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '당신은?',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        selectedOption,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        getDescription(selectedOption),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartTestSection(
                                    onStartPressed: () {
                                      // 여기에 시작 버튼을 눌렀을 때의 동작을 추가
                                    },
                                    isStarted: true, // 시작 상태 설정
                                    onOptionSelected: (option) {
                                      // 선택한 옵션을 처리하는 로직
                                    },
                                    selectedOption: '', // 초기 선택 값
                                  ),
                                ),
                                (Route<dynamic> route) =>
                                    false, // 이전 모든 화면을 스택에서 제거
                              );
                            },
                            child: Text(
                              '다시하기',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (ResultCard(
                                          selectedOption: selectedOption,
                                        ))),
                              );
                            },
                            child: Text(
                              '자세히 보기',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth - 40,
                height: 400,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/mascoat.png', height: 100),
                    SizedBox(height: 20),
                    Text(
                      '안녕하세요 창녕군 마스코트 따오기예요!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'MBTI를 먼저 입력해주세요',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '입력 후, 다른 MBTI의 성향도 볼 수 있어요!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  String getDescription(String option) {
    switch (option) {
      case 'ISTJ':
        return '꼼꼼한 계획형 여행자';
      case 'ISFJ':
        return '배려 넘치는 동행자';
      case 'INFJ':
        return '내면을 탐구하는 여행자';
      case 'INTJ':
        return '전략적인 미지 탐험가';
      case 'ISTP':
        return '즉흥적인 탐험가';
      case 'ISFP':
        return '감성적인 자연 애호가';
      case 'INFP':
        return '꿈을 찾아 떠나는 방랑자';
      case 'INTP':
        return '깊이 있는 지식 탐구자';
      case 'ESTP':
        return '스릴을 즐기는 모험가';
      case 'ESFP':
        return '파티를 즐기는 여행자';
      case 'ENFP':
        return '텐션 높은 인싸 여행자';
      case 'ENTP':
        return '독창적인 아이디어 탐험가';
      case 'ESTJ':
        return '효율적인 여행 리더';
      case 'ESFJ':
        return '모두를 챙기는 세심한 동반자';
      case 'ENFJ':
        return '인연을 찾는 열정 여행자';
      case 'ENTJ':
        return '목표 지향적인 정복자';
      default:
        return '다시 한번 진행해주세요!';
    }
  }
}
