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
                  margin: EdgeInsets.only(top: 10),
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
                                        color: Colors.black54,
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
                        traits: mbtiData.traits,
                        color: Colors.orange[100]!,
                      ),
                      SizedBox(height: 20),
                      buildMBTICard(
                        title: '환장궁합 MBTI',
                        mbtiType: mbtiData.worstMatchType,
                        description: mbtiData.worstMatchDescription,
                        mascotImage: mbtiData.worstMatchImage,
                        traits: mbtiData.traits,
                        color: Colors.red[100]!,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // 저장 기능
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
  required List<String> traits,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          children: [
            Image.asset(
              mascotImage,
              height: 50,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mbtiType,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        ...traits.map(
          (trait) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              trait,
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    ),
  );
}
