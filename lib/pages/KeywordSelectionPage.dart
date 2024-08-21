import 'package:flutter/material.dart';
import 'package:untitled/pages/coursemake.dart';
import '../hooks/top3course.dart'; // Top3Courses를 가져오는 부분 추가
import '../components/basic_frame_page.dart'; // BasicFramePage 임포트

class KeywordSelectionPage extends StatefulWidget {
  @override
  _KeywordSelectionPageState createState() => _KeywordSelectionPageState();
}

class _KeywordSelectionPageState extends State<KeywordSelectionPage> {
  String? selectedTheme;
  final List<String> themes = ['음식', '관광지', '액티비티', '힐링', '파티'];

  List<DropdownMenuItem<String>> _buildThemeItems() {
    return themes
        .map((theme) => DropdownMenuItem(value: theme, child: Text(theme)))
        .toList();
  }

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
                      '자기만의 여행 코스를 만들어보세요!:)',
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
                      'STEP 04 | 키워드 선택',
                      style: TextStyle(
                        fontSize: 14,
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
                      value: selectedTheme,
                      hint: Text('테마를 선택하세요'),
                      items: _buildThemeItems(),
                      onChanged: (value) {
                        setState(() {
                          selectedTheme = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    // SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: selectedTheme != null
                          ? () {
                              // 키워드를 선택하고 완료를 눌렀을 때의 동작을 정의하세요.
                            }
                          : null,
                      child: Text('AI에게 추천코스 받기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTheme != null
                            ? Colors.grey[800]
                            : Colors.grey[400],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: selectedTheme != null
                          ? () {
                              // 키워드를 선택하고 완료를 눌렀을 때의 동작을 정의하세요.
                            }
                          : null,
                      child: Text('직접 코스 만들기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTheme != null
                            ? Colors.grey[800]
                            : Colors.grey[400],
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
