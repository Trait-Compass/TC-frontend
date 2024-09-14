import 'package:flutter/material.dart';
import 'package:untitled/pages/coursemakej.dart';
// import 'package:untitled/pages/coursemake.dart';
import '../hooks/top3course.dart'; // Top3Courses를 가져오는 부분 추가
import '../components/basic_frame_page.dart'; // BasicFramePage 임포트
import '../components/map/MapPage.dart';

class KeywordSelectionPage extends StatefulWidget {
  @override
  _KeywordSelectionPageState createState() => _KeywordSelectionPageState();
}

class _KeywordSelectionPageState extends State<KeywordSelectionPage> {
  List<String> selectedKeywords = [];

  final Map<String, List<String>> keywordGroups = {
    '느긋하게': ['자연', '산', '강', '공원', '경치'],
    '신나게': ['축제', '놀이공원', '레포츠', '야경', '전시'],
    '색다르게': ['체험', '역사', '드라이브', '시장', '항구', '마을'],
  };

  Map<String, String?> selectedKeywordsByGroup = {
    '느긋하게': null,
    '신나게': null,
    '색다르게': null,
  };

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Color(0xFFE4E4E4),
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Image.asset('assets/animation.png', height: 50),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '자기만의 여행 코스를 만들어보세요! :)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'J형 코스 만들기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(screenHeight * 0.03),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'STEP 03 | 키워드 선택',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // 키워드 그룹별로 드롭다운 생성
                    ...keywordGroups.entries.map((entry) {
                      String groupTitle = entry.key;
                      List<String> groupKeywords = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            groupTitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            dropdownColor: Colors.white,
                            value: selectedKeywordsByGroup[groupTitle],
                            hint: Text('키워드를 선택하세요'),
                            items: groupKeywords.map((keyword) {
                              return DropdownMenuItem<String>(
                                value: keyword,
                                child: Text(keyword),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedKeywordsByGroup[groupTitle] = value;
                                if (value != null &&
                                    !selectedKeywords.contains(value)) {
                                  selectedKeywords.add(value);
                                }
                              });
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Coursemakej(),
                          ),
                        );
                      }, // 항상 버튼 활성화
                      child: Text('AI에게 추천코스 받기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapPage(),
                          ),
                        );
                        // 선택된 키워드를 이용해 코스를 만들어야 함
                      }, // 항상 버튼 활성화
                      child: Text('직접 코스 만들기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Top3Courses(), // Top3Courses 위젯 사용
          ],
        ),
      ),
    );
  }
}
