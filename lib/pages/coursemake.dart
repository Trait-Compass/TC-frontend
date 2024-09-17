import 'package:flutter/material.dart';
import '../components/start/basicframe2.dart';
import '../hooks/top3course.dart';
import '../components/map/api.dart';
import '../pages/coursemodell.dart';
import '../pages/Tripdetail.dart'; // PdetailPage를 가져오기 위한 import 추가

class Coursemake extends StatefulWidget {
  final List<DateTime> selectedDates; // 날짜 받기
  final String selectedLocation; // 위치 받기
  final String selectedGroup; // 그룹 받기

  Coursemake({
    required this.selectedDates,
    required this.selectedLocation,
    required this.selectedGroup,
  });

  @override
  _CoursemakeState createState() => _CoursemakeState();
}

class _CoursemakeState extends State<Coursemake> {
  Future<List<Map<String, dynamic>>> _fetchCourseImages() async {
    try {
      print('Fetching course data from API...');
      final result = await ApiService.fetchCourseForP(
        mbti: 'INFP', // MBTI placeholder
        startDate: widget.selectedDates[0].toIso8601String(),
        endDate: widget.selectedDates[1].toIso8601String(),
        location: widget.selectedLocation,
        companion: widget.selectedGroup,
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
      throw e; 
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
                'P형 코스 만들기',
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
                  future: _fetchCourseImages(), // Fetch data
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
                          childAspectRatio: 1.25,
                        ),
                        itemCount: courseData.length,
                        itemBuilder: (context, index) {
                          final course = courseData[index];
                          
                          // 여행 기간에 따른 필요한 데이터만 추출
                          Map<int, List<Map<String, dynamic>>> tripDetails = {};
                          int totalDays = 1; // 기본값은 당일치기

                          if (widget.selectedDates.length == 2) {
                            tripDetails[0] = course['day1'];
                            tripDetails[1] = course['day2'];
                            totalDays = 2; // 1박 2일
                          } else if (widget.selectedDates.length > 2) {
                            tripDetails[0] = course['day1'];
                            tripDetails[1] = course['day2'];
                            tripDetails[2] = course['day3'];
                            totalDays = 3; // 2박 3일
                          } else {
                            tripDetails[0] = course['day1'];
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
                                      errorBuilder: (BuildContext context, Object exception,
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