import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendedCoursesPage extends StatefulWidget {
  final List<dynamic> courses;

  RecommendedCoursesPage({required this.courses});

  @override
  _RecommendedCoursesPageState createState() => _RecommendedCoursesPageState();
}

class _RecommendedCoursesPageState extends State<RecommendedCoursesPage> {
  Future<List<dynamic>> fetchBestCourses() async {
    final response = await http.get(
      Uri.parse('https://www.traitcompass.store/course/best'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load best courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인기 코스'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchBestCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var course = snapshot.data![index];
                return ListTile(
                  title: Text(course['title']),
                  subtitle: Text(course['location']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
