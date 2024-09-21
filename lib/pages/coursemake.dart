// Coursemake.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../components/start/basicframe2.dart';
import '../hooks/top3course.dart';
import '../components/map/api.dart';
import '../pages/coursemodell.dart';
import '../pages/Tripdetail.dart'; 

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
      print('Fetching user profile...');
      final userProfile = await ApiService.fetchUserProfile();
      final userMbti = userProfile['mbti'];
      if (userMbti == null || userMbti.isEmpty) {
        throw Exception('MBTI not found in user profile');
      }

      print('User MBTI: $userMbti');

      print('Fetching course data from API...');
      final result = await ApiService.fetchCourseForP(
        mbti: userMbti, // 사용자 MBTI 값 사용
        startDate: widget.selectedDates[0].toIso8601String(),
        endDate: widget.selectedDates[widget.selectedDates.length - 1].toIso8601String(),
        location: widget.selectedLocation,
        companion: widget.selectedGroup,
      );

      print('API Response: $result'); 

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
        }).where((course) => course != null).cast<Course>().toList(); 

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
            List<Map<String, dynamic>> day4Maps = course.day4.map((day) => day.toMap()).toList(); 
            List<Map<String, dynamic>> day5Maps = course.day5.map((day) => day.toMap()).toList(); 

            print('Adding course: $courseName with imageUrl: $imageUrl'); 

            fetchedData.add({
              'imageUrl': imageUrl,
              'region': region,
              'courseName': courseName,
              'duration': duration,
              'day1': day1Maps,
              'day2': day2Maps,
              'day3': day3Maps,
              'day4': day4Maps, 
              'day5': day5Maps, 
            });
          }
        }
      } else {
        print('Result is null or not a list');
      }

      return fetchedData;
    } catch (e) {
      print('Error fetching course images: $e');
      return [];
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
                          int totalDays = 1; 

                       
                          DateTime startDate = widget.selectedDates.first;
                          DateTime endDate = widget.selectedDates.last;
                          int daysDifference = endDate.difference(startDate).inDays + 1;
                          totalDays = daysDifference;

                        
                          totalDays = totalDays > 5 ? 5 : totalDays;

                       
                          for (int i = 0; i < totalDays; i++) {
                            var dayData = course['day${i + 1}'];
                            if (dayData != null && dayData.isNotEmpty) {
                              tripDetails[i] = dayData;
                            } else {

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
                                    totalDays: totalDays > 5 ? 5 : totalDays,
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
                                        return Container(
                                          color: Colors.grey[300],
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.broken_image, size: 50, color: Colors.grey[700]),
                                              SizedBox(height: 10),
                                              Text(
                                                '이미지를 불러올 수 없습니다.',
                                                style: TextStyle(color: Colors.grey[700]),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // 텍스트 오버레이
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    right: 10,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                    } else {
                      // 모든 조건을 벗어날 경우 기본적으로 반환
                      return SizedBox.shrink();
                    }
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

// coursemodell.dart
class Course {
  final String id;
  final String region;
  final String courseName;
  final String duration;
  final List<Day> day1;
  final List<Day> day2;
  final List<Day> day3;
  final List<Day> day4; 
  final List<Day> day5; 

  Course({
    required this.id,
    required this.region,
    required this.courseName,
    required this.duration,
    required this.day1,
    required this.day2,
    required this.day3,
    required this.day4, 
    required this.day5, 
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'] as String,
      region: json['region'] as String,
      courseName: json['courseName'] as String,
      duration: json['duration'] as String,
      day1: json['day1'] != null && json['day1'] is List
          ? (json['day1'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
      day2: json['day2'] != null && json['day2'] is List
          ? (json['day2'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
      day3: json['day3'] != null && json['day3'] is List
          ? (json['day3'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
      day4: json['day4'] != null && json['day4'] is List
          ? (json['day4'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
      day5: json['day5'] != null && json['day5'] is List
          ? (json['day5'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
    );
  }
}

class Day {
  final List<String> keywords;
  final String name;
  final int id;
  final String imageUrl;
  final TravelInfo? travelInfoToNext;

  Day({
    required this.keywords,
    required this.name,
    required this.id,
    required this.imageUrl,
    this.travelInfoToNext,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      keywords: json['keywords'] != null && json['keywords'] is List
          ? List<String>.from(json['keywords'])
          : [],
      name: json['name'] as String,
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      travelInfoToNext: json['travelInfoToNext'] != null
          ? TravelInfo.fromJson(json['travelInfoToNext'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keywords': keywords,
      'name': name,
      'id': id,
      'imageUrl': imageUrl,
      'travelInfoToNext': travelInfoToNext?.toMap(),
    };
  }
}

class TravelInfo {
  final String distance;
  final String carTime;
  final String walkingTime;

  TravelInfo({
    required this.distance,
    required this.carTime,
    required this.walkingTime,
  });

  factory TravelInfo.fromJson(Map<String, dynamic> json) {
    return TravelInfo(
      distance: json['distance'] as String,
      carTime: json['carTime'] as String,
      walkingTime: json['walkingTime'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'distance': distance,
      'carTime': carTime,
      'walkingTime': walkingTime,
    };
  }
}