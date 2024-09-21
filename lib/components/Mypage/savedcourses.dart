// SavedTravelCourses.dart
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:untitled/components/map/api.dart';

class SavedTravelCourses extends StatefulWidget {
  @override
  _SavedTravelCoursesState createState() => _SavedTravelCoursesState();
}

class _SavedTravelCoursesState extends State<SavedTravelCourses> {
  late Future<List<Map<String, dynamic>>> _savedCoursesFuture;

  @override
  void initState() {
    super.initState();
    _savedCoursesFuture = ApiService.fetchSavedCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '내가 저장한 여행 코스',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _savedCoursesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('오류 발생: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return DottedBorder(
                  color: Colors.black, 
                  strokeWidth: 1, 
                  borderType: BorderType.RRect, 
                  radius: Radius.circular(10), 
                  dashPattern: [4, 2], 
                  child: Container(
                    height: 160, 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center, 
                    child: Text(
                      '지정한 코스가 없습니다.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                // 저장된 여행 코스가 있는 경우
                List<Map<String, dynamic>> courses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> course = courses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: DottedBorder(
                        color: Colors.black, 
                        strokeWidth: 1, 
                        borderType: BorderType.RRect, 
                        radius: Radius.circular(10), 
                        dashPattern: [4, 2], 
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity, 
                                    height: 160 / 2 - 5, 
                                    decoration: BoxDecoration(
                                      color: Colors.white, 
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8, 
                                    right: 8, 
                                    child: Text(
                                      course['courseName'] ?? '코스 이름 없음',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 10, 
                              ),
                              // 추가 정보 표시 (예: 지역, 기간 등)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '지역: ${course['region'] ?? '정보 없음'}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '기간: ${course['duration'] ?? '정보 없음'}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEDEDED),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '코스 제작하기',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10), 
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // '인기코스 보러가기' 버튼 클릭 시의 동작 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEDEDED),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '인기코스 보러가기',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
