import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BestCourseTop3 extends StatelessWidget {
  Future<List<Course>> fetchBestCourses() async {
    final response = await http
        .get(Uri.parse('https://www.traitcompass.store/api/course/best'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final PageController controller = PageController(viewportFraction: 0.9);

    return FutureBuilder<List<Course>>(
      future: fetchBestCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load courses'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No courses available'));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Text(
                  '인기 추천코스\nBEST 3',
                  style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.25,
                child: PageView(
                  controller: controller,
                  children: snapshot.data!.map((course) {
                    return RecommendedCourseCard(
                      imagePath: course.imagePath,
                      title: course.title,
                      location: course.location,
                      mbti: course.mbti,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class RecommendedCourseCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String mbti;

  const RecommendedCourseCard({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.mbti,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: screenHeight * 0.01,
            left: screenWidth * 0.025,
            child: Text(
              '$mbti\n$title\n$location',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Course {
  final String imagePath;
  final String title;
  final String location;
  final String mbti;

  Course({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.mbti,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      imagePath: json['imagePath'],
      title: json['title'],
      location: json['location'],
      mbti: json['mbti'],
    );
  }
}
