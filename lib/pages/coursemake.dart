import 'dart:math';
import 'package:flutter/material.dart';
import '../components/start/basicframe2.dart';
import '../components/map/MapPage.dart';
import '../hooks/top3course.dart';
import '../components/map/api.dart'; 
import '../pages/coursemodell.dart'; 

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
  List<Map<String, String>> courseData = []; 
  String mbti = "INFP"; // 예시 MBTI 타입
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchCourseImages();
  }

  Future<void> _fetchCourseImages() async {
  try {
    print('Fetching course data from API...');
    final result = await ApiService.fetchCourseForP(
      mbti: mbti,
      startDate: widget.selectedDates[0].toIso8601String(),
      endDate: widget.selectedDates[1].toIso8601String(),
      location: widget.selectedLocation,
      companion: widget.selectedGroup,
    );

    print('API Response: $result'); // 응답 데이터 로그 출력

    List<Map<String, String>> fetchedData = [];

    if (result['result'] != null && result['result'] is List) {
      List<dynamic> coursesJson = result['result'];
      List<Course> courses = coursesJson.map((json) {
        try {
          return Course.fromJson(json);  
        } catch (e) {
          print('Error parsing course JSON: $e');  
          return null;
        }
      }).where((course) => course != null).cast<Course>().toList();  // null이 아닌 항목만 포함

      for (var course in courses) {
        if (course.day1.isNotEmpty) { 
          String imageUrl = course.day1[0].imageUrl; 
          String region = course.region;
          String courseName = course.courseName;
          String duration = course.duration;

          fetchedData.add({
            'imageUrl': imageUrl,
            'region': region,
            'courseName': courseName,
            'duration': duration,
          });
        }
      }
    } else {
      print('Result is null or not a list');
    }

    setState(() {
      courseData = fetchedData;
      isLoading = false;
      hasError = false;
      print('Course data fetched successfully: $courseData');
    });
  } catch (e) {
    print('Error fetching course images: $e');
    setState(() {
      courseData = [];
      isLoading = false;
      hasError = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('코스 이미지를 불러오는 데 문제가 발생했습니다.'),
      ),
    );
  }
}

  void shuffleCourses() {
    setState(() {
      courseData.shuffle(Random());
    });
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'STEP 03 | 코스 선택',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    if (isLoading)
                      Center(child: CircularProgressIndicator())
                    else if (hasError)
                      Center(child: Text('코스 이미지를 불러오는 데 문제가 발생했습니다.'))
                    else if (courseData.isEmpty)
                      Center(child: Text('코스 이미지가 없습니다.'))
                    else
                      GridView.builder(
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapPage(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                      child: Image.network(
                                        course['imageUrl']!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context, Widget child,
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(course['courseName']!, style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(course['region']!, style: TextStyle(color: Colors.grey)),
                                        Text(course['duration']!, style: TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        shuffleCourses();
                      },
                      child: Text('코스 재생성'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                      ),
                    ),
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
