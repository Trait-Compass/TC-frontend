import 'package:flutter/material.dart';
import 'mbtidata.dart';
import 'result.dart';
import '../basicframe.dart';

class ResultPage extends StatelessWidget {
  final String selectedOption;

  ResultPage({
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final mbtiData =
        mbtiDataList.firstWhere((data) => data.type == selectedOption);

    return Scaffold(
      appBar: AppBar(
        title: Text('MBTrip 결과'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BasicFrame1Page(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                buildMainResultBox(mbtiData),
                SizedBox(height: 20),
                buildMBTICard(
                  title: '찰떡궁합 MBTI',
                  mbtiType: mbtiData.bestMatchType,
                  description: mbtiData.bestMatchDescription,
                  mascotImage: mbtiData.bestMatchImage,
                  color: Colors.orange[100]!,
                ),
                SizedBox(height: 20),
                buildMBTICard(
                  title: '환장궁합 MBTI',
                  mbtiType: mbtiData.worstMatchType,
                  description: mbtiData.worstMatchDescription,
                  mascotImage: mbtiData.worstMatchImage,
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
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      children: [
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
  );
}

Widget buildMBTICard({
  required String title,
  required String mbtiType,
  required String description,
  required String mascotImage,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
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
      ],
    ),
  );
}
