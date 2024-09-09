import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BestCourseTop3.dart';
import 'GyeongNamRecommend.dart';
import '../components/basic_frame_page.dart';

class ResultPage extends StatelessWidget {
  final String mbti;

  ResultPage({required this.mbti});

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
                  RecommendedCourses(mbti: mbti),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // 코스 재생성 버튼 눌렀을 때 동작 추가
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(mbti: mbti),
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

  RecommendedCourses({required this.mbti});

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(
        'https://www.traitcompass.store/course/simple?mbti=$mbti&startDate=24-07-12&endDate=24-07-15'));

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
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(5),
            children: courses.map((course) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(course.image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}

class Course {
  final String city;
  final String title;
  final String image;

  Course({required this.city, required this.title, required this.image});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      city: json['city'],
      title: json['title'],
      image: json['image'],
    );
  }
}
