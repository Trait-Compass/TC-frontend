// keyword_selection_page.dart
import 'package:flutter/material.dart';
import 'package:untitled/components/map/MapPage.dart';
import 'package:untitled/pages/coursemakej.dart';
import '../components/start/basicframe2.dart';
import '../hooks/top3course.dart';

class KeywordSelectionPage extends StatefulWidget {
  final List<DateTime> selectedDates;
  final String selectedLocation;
  final String selectedGroup;

  KeywordSelectionPage({
    required this.selectedDates,
    required this.selectedLocation,
    required this.selectedGroup,
  });

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

    return BasicFramePage5(
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
                        bool allKeywordsSelected = true;
                        selectedKeywordsByGroup.forEach((group, keyword) {
                          if (keyword == null) {
                            allKeywordsSelected = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$group 키워드를 선택해주세요.'),
                                backgroundColor: Colors.black.withOpacity(0.8),
                              ),
                            );
                          }
                        });

                        if (allKeywordsSelected) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Coursemakej(
                                selectedDates: widget.selectedDates,
                                selectedLocation: widget.selectedLocation,
                                selectedGroup: widget.selectedGroup,
                                selectedKeywords: selectedKeywords,
                              ),
                            ),
                          );
                        }
                      },
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
                            builder: (context) => MapPage(
                                // selectedDates: widget.selectedDates,
                                // selectedLocation: widget.selectedLocation,
                                // selectedGroup: widget.selectedGroup,
                                ),
                          ),
                        );
                      }, 
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
            Top3Courses(),
          ],
        ),
      ),
    );
  }
}
