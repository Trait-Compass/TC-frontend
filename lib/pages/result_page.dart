import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; 
import 'BestCourseTop3.dart';
import 'GyeongNamRecommend.dart';
import '../components/basic_frame_page.dart';

class ResultPage extends StatelessWidget {
  final String mbti;
  final DateTime startDate;
  final DateTime endDate;

  ResultPage({
    required this.mbti,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      '제가 몇 가지 코스를 가지고 왔어요!\n더 다양한 코스를 받고 싶다면 \n‘추천 코스’를 눌러주세요:)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '$mbti 맞춤형 간단 추천 코스',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  RecommendedCourses(
                    mbti: mbti,
                    startDate: startDate,
                    endDate: endDate,
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(
                              mbti: mbti,
                              startDate: startDate,
                              endDate: endDate,
                            ),
                          ),
                        );
                      },
                      child: Text('코스 재생성'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            BestCourseTop3(), // BestCourseTop3 위젯 추가
            SizedBox(height: 20),
            GyeongNamRecommend(), // GyeongNamRecommend 위젯 추가
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class RecommendedCourses extends StatelessWidget {
  final String mbti;
  final DateTime startDate;
  final DateTime endDate;

  RecommendedCourses({
    required this.mbti,
    required this.startDate,
    required this.endDate,
  });

  Future<List<Course>> fetchCourses() async {
    final String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    final String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);

  
    final Uri uri = Uri.parse('https://www.traitcompass.store/course/simple').replace(queryParameters: {
      'mbti': mbti,
      'startDate': formattedStartDate,
      'endDate': formattedEndDate,
    });

    print('Requesting URL: $uri'); // 디버그 메시지 추가

    final response = await http.get(uri);

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['result'];
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('코스를 불러오는 중입니다! 잠시만 기다려주세요!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: fetchCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load courses'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No courses available'));
        } else {
          List<Course> courses = snapshot.data!;
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10, 
              childAspectRatio: 1, 
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return CourseCard(course: courses[index]);
            },
          );
        }
      },
    );
  }
}

class Course {
  final String region;
  final String courseName;
  final String duration;
  final String image;

  Course({
    required this.region,
    required this.courseName,
    required this.duration,
    required this.image,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      region: json['region'],
      courseName: json['courseName'],
      duration: json['duration'],
      image: json['day1'][0]['imageUrl'], 
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },

      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5, 
        shadowColor: Colors.grey.withOpacity(0.5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // 이미지
              Positioned.fill(
                child: Image.network(
                  course.image,
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
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey[700]),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.courseName,
                      style: TextStyle(
                        fontSize: 16, 
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      course.region,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      course.duration,
                      style: TextStyle(
                        fontSize: 12, 
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}