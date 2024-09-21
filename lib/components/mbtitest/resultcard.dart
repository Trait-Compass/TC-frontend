import 'package:flutter/material.dart';
import 'package:untitled/components/mbti_selection_page.dart';
import 'package:untitled/components/basic_frame_page.dart';
import 'package:untitled/hooks/login/creataccount.dart';
import 'mbtidata.dart';
import '../basicframe.dart';
import '../map/api.dart';
import '../map/apierror.dart';

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
                                    Image.asset(
                                      mbtiData.mascotImage,
                                      height: 60,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      mbtiData.mascotName,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      mbtiData.mascotRegion,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
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
                      buildMBTICard(
                        title: '찰떡궁합 MBTI',
                        mbtiType: mbtiData.bestMatchType,
                        description: mbtiData.bestMatchDescription,
                        mascotImage: mbtiData.bestMatchImage,
                        mascotName: mbtiData.bestMatchName,
                        mascotRegion: mbtiData.bestMatchRegion,
                        traits: mbtiData.besttraits,
                        color: Colors.orange[100]!,
                      ),
                      SizedBox(height: 20),
                      buildMBTICard(
                        title: '환장궁합 MBTI',
                        mbtiType: mbtiData.worstMatchType,
                        description: mbtiData.worstMatchDescription,
                        mascotImage: mbtiData.worstMatchImage,
                        mascotName: mbtiData.worstMatchName,
                        mascotRegion: mbtiData.worstMatchRegion,
                        traits: mbtiData.worsttraits,
                        color: Colors.red[100]!,
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await ApiService.saveUserMBTI(selectedOption);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'MBTI 저장에 성공했어요! 내 정보에서 확인해주세요!')));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BasicFramePage(
                                        body: MBTISelectionPage())),
                              );
                            } catch (e) {
                              if (e is ApiException && e.statusCode == 401) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'MBTI테스트 결과에 나온 MBTI를 드롭다운에서 선택해주세요')),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('MBTI 저장에 실패했습니다. 다시 시도해주세요')),
                                );
                                print('Error: $e');
                              }
                            }
                          },
                          child: Text(
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

// 하나의 buildMBTICard 함수만 남김
Widget buildMBTICard({
  required String title,
  required String mbtiType,
  required String description,
  required String mascotImage,
  required String mascotName,
  required String mascotRegion,
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
                SizedBox(height: 5),
                Text(
                  mascotName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  mascotRegion,
                  style: TextStyle(
                    fontSize: 12,
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
