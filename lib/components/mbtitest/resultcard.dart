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
                buildMainResultBox(mbtiData),
                SizedBox(height: 10),
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
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
}

Widget buildMainResultBox(MBTIData data) {
  return Container(
    margin: EdgeInsets.all(20), // 회색 박스에 마진 적용
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey[200], // 회색 박스
      borderRadius: BorderRadius.circular(20), // 둥근 모서리
    ),
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // 흰색 박스
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.asset(
            data.mascotImage, // 이미지 추가
            height: 100,
          ),
          SizedBox(height: 20),
          Text(
            data.type,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 10),
          Text(
            data.description,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          ...data.traits.map(
            (trait) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                trait,
                style: TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
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
    margin: EdgeInsets.all(20), // 회색 박스에 마진 적용
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey[200], // 회색 박스
      borderRadius: BorderRadius.circular(20), // 둥근 모서리
    ),
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // 흰색 박스
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
    ),
  );
}
