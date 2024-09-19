import 'package:flutter/material.dart';
import 'mbtidata.dart';
import '../basicframe.dart';

class ResultCard extends StatelessWidget {
  final String selectedOption;

  ResultCard({required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    final mbtiData =
        mbtiDataList.firstWhere((data) => data.type == selectedOption);

    return BasicFrame1Page(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
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
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          mbtiData.mascotImage,
                                          height: 60,
                                        ),
                                        Container(height: 5),
                                        Text(
                                          mbtiData.mascotName,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          mbtiData.mascotRegion,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      mbtiData.type,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      mbtiData.description,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ...mbtiData.traits.map(
                              (trait) => Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  trait,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // 찰떡궁합 MBTI 섹션
                      buildMBTICard(
                        title: '찰떡궁합 MBTI',
                        mbtiType: mbtiData.bestMatchType,
                        description: mbtiData.bestMatchDescription,
                        mascotImage: mbtiData.bestMatchImage,
                        mascotName: mbtiData.bestMatchName,
                        mascotRegion: mbtiData.bestMatchRegion,
                        traits: mbtiData.traits,
                        color: Colors.orange[100]!,
                      ),
                      SizedBox(height: 20),
                      // 환장궁합 MBTI 섹션
                      buildMBTICard(
                        title: '환장궁합 MBTI',
                        mbtiType: mbtiData.worstMatchType,
                        description: mbtiData.worstMatchDescription,
                        mascotImage: mbtiData.worstMatchImage,
                        mascotName: mbtiData.worstMatchName,
                        mascotRegion: mbtiData.worstMatchRegion,
                        traits: mbtiData.traits,
                        color: Colors.red[100]!,
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            // 저장 기능
                          },
                          child: Text(
                            // api 달기
                            'MBTI 저장하기',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildMBTICard({
  required String title,
  required String mbtiType,
  required String description,
  required String mascotImage,
  required String mascotName, // 추가된 파라미터
  required String mascotRegion, // 추가된 파라미터
  required List<String> traits,
  required Color color,
}) {
  final Color textColor = title == '찰떡궁합 MBTI' ? Colors.orange : Colors.red;
  final Color containerColor =
      title == '찰떡궁합 MBTI' ? Colors.orange[100]! : Colors.red[100]!;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  mascotImage,
                  height: 80,
                ),
                SizedBox(height: 5), // 이미지와 텍스트 사이의 간격
                Text(
                  mascotName, // 마스코트 이름 추가
                  style: TextStyle(
                    fontSize: 14, // 텍스트 크기를 10으로 설정
                    color: Colors.black,
                  ),
                ),
                Text(
                  mascotRegion, // 마스코트 지역 추가
                  style: TextStyle(
                    fontSize: 12, // 텍스트 크기를 10으로 설정
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: textColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          mbtiType,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        description,
                        style: TextStyle(fontSize: 15, color: textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ...traits.map(
                    (trait) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        trait,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
