import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled/pages/Tripdetail.dart'; // PdetailPage import 경로 수정 필요
import '../components/start/basicframe2.dart';
import '../hooks/top3course.dart';
import '../pages/coursemodell.dart';
import '../components/map/api.dart';

class Coursemakej extends StatefulWidget {
  final List<DateTime> selectedDates; // 선택된 날짜
  final String selectedLocation; // 선택된 장소
  final String selectedGroup; // 선택된 인원 그룹
  final List<String> selectedKeywords; // 선택된 키워드

  Coursemakej({
    required this.selectedDates,
    required this.selectedLocation,
    required this.selectedGroup,
    required this.selectedKeywords,
  });

  @override
  _CoursemakejState createState() => _CoursemakejState();
}

class _CoursemakejState extends State<Coursemakej> {
  List<String> courseImages = [
    'assets/course1.png',
    'assets/course2.png',
    'assets/course3.png',
    'assets/course4.png',
  ];

  void shuffleCourses() {
    setState(() {
      courseImages.shuffle(Random());
    });
  }

  Future<List<Map<String, dynamic>>> _fetchCourseImages() async {
    try {
      print('Fetching course data from API...');
      final result = await ApiService.fetchCourseForJ(
        mbti: 'INFP', // MBTI placeholder, 실제로는 사용자 데이터를 활용
        startDate: widget.selectedDates[0].toIso8601String(),
        endDate: widget.selectedDates[widget.selectedDates.length - 1].toIso8601String(),
        location: widget.selectedLocation,
        companion: widget.selectedGroup,
        keyword: widget.selectedKeywords,
      );

      print('API Response: $result'); // 응답 데이터 로그 출력

      List<Map<String, dynamic>> fetchedData = [];

      if (result['result'] != null && result['result'] is List) {
        List<dynamic> coursesJson = result['result'];
        List<Course> courses = coursesJson.map((json) {
          try {
            return Course.fromJson(json);
          } catch (e) {
            print('Error parsing course JSON: $e');
            return null;
          }
        }).where((course) => course != null).cast<Course>().toList(); // null이 아닌 항목만 포함

        for (var course in courses) {
          if (course.day1.isNotEmpty) {
            String imageUrl = course.day1[0].imageUrl;
            String region = course.region;
            String courseName = course.courseName;
            String duration = course.duration;

            // Day 객체 리스트를 Map으로 변환
            List<Map<String, dynamic>> day1Maps = course.day1.map((day) => day.toMap()).toList();
            List<Map<String, dynamic>> day2Maps = course.day2.map((day) => day.toMap()).toList();
            List<Map<String, dynamic>> day3Maps = course.day3.map((day) => day.toMap()).toList();

            fetchedData.add({
              'imageUrl': imageUrl,
              'region': region,
              'courseName': courseName,
              'duration': duration,
              'day1': day1Maps,
              'day2': day2Maps,
              'day3': day3Maps,
            });
          }
        }
      } else {
        print('Result is null or not a list');
      }

      return fetchedData;
    } catch (e) {
      print('Error fetching course images: $e');
      throw e; // 에러 전파
    }
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
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _fetchCourseImages(), // 데이터 가져오기
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('코스 이미지를 불러오는 데 문제가 발생했습니다.'));
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(child: Text('코스 이미지가 없습니다.'));
                    } else if (snapshot.hasData) {
                      List<Map<String, dynamic>> courseData = snapshot.data!;
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: courseData.length,
                        itemBuilder: (context, index) {
                          final course = courseData[index];

                          Map<int, List<Map<String, dynamic>>> tripDetails = {};
                          int totalDays = 1; // 기본값은 1일차

                          // 여행 일수 계산
                          DateTime startDate = widget.selectedDates.first;
                          DateTime endDate = widget.selectedDates.last;
                          int daysDifference = endDate.difference(startDate).inDays + 1;
                          totalDays = daysDifference;

                          // tripDetails 설정
                          for (int i = 0; i < totalDays; i++) {
                            var dayData = course['day${i + 1}'];
                            if (dayData != null && dayData.isNotEmpty) {
                              tripDetails[i] = dayData;
                            } else {
                              // 데이터가 없을 경우 처리 (빈 리스트로 초기화)
                              tripDetails[i] = [];
                            }
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdetailPage(
                                    tripDetails: tripDetails,
                                    totalDays: totalDays,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  // 이미지
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      course['imageUrl']!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Icon(Icons.broken_image, size: 50);
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          course['courseName']!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(1.0, 1.0),
                                                blurRadius: 3.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          course['region']!,
                                          style: TextStyle(
                                            color: Colors.white, // 흰색 텍스트
                                            shadows: [
                                              Shadow(
                                                offset: Offset(1.0, 1.0),
                                                blurRadius: 3.0,
                                                color: Colors.black, // 그림자
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          course['duration']!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(1.0, 1.0),
                                                blurRadius: 3.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
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
