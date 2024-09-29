// SavedTravelCourses.dart

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:untitled/components/map/api.dart';
import 'package:untitled/components/start/basicframe2.dart';
import 'package:untitled/pages/travelplan.dart';
import 'package:untitled/components/Mypage/savedcoursesdetail.dart'; 

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
                      '저장한 코스가 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                List<Map<String, dynamic>> courses = snapshot.data!;
                return Container(
                  height: 160,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: courses.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> course = courses[index];

                      return Container(
                        height: 70,
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 0,
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            print('Image tapped');
                            String? courseId = course['_id'] ?? course['id']; 
                            if (courseId == null) {
                              print('Course ID is null');
                              return;
                            }
                            try {

                              Map<String, dynamic> courseDetails =
                                  await ApiService.fetchSavedCourseDetails(
                                      courseId);

                              Map<int, List<Map<String, dynamic>>> tripDetails =
                                  {};
                              int totalDays = 0;

                              courseDetails.forEach((key, value) {
                                if (key.startsWith('day') &&
                                    value is List &&
                                    value.isNotEmpty) {
                                  int dayIndex =
                                      int.parse(key.substring(3)) - 1;
                                  List<dynamic> dayData = value;
                                  tripDetails[dayIndex] =
                                      dayData.cast<Map<String, dynamic>>();
                                  if (dayIndex + 1 > totalDays) {
                                    totalDays = dayIndex + 1;
                                  }
                                }
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SavedCourseDetailPage(
                                    tripDetails: tripDetails,
                                    totalDays: totalDays,
                                    courseId: courseId,
                                  ),
                                ),
                              );
                            } catch (e) {
                              print('Error fetching course details: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('코스 상세 정보를 가져오는 데 실패했습니다.')),
                              );
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:
                                            _buildImage(course, imageIndex: 0),
                                      ),
                                      Expanded(
                                        child:
                                            _buildImage(course, imageIndex: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                right: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course['region'] ?? '지역 정보 없음',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
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
                                      course['duration'] ?? '기간 정보 없음',
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BasicFramePage5(body: MyNewPage()),
                      ),
                    );
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
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BasicFramePage5(body: MyNewPage()),
                      ),
                    );
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
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Map<String, dynamic> course, {required int imageIndex}) {
    String? imageUrl = _getImageUrl(course, imageIndex: imageIndex);
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
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
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            'assets/city2.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
      );
    } else {
      return Image.asset(
        'assets/city2.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }

  String? _getImageUrl(Map<String, dynamic> course, {required int imageIndex}) {
    try {
      String dayKey = 'day${imageIndex + 1}';
      if (course[dayKey] != null &&
          course[dayKey] is List &&
          course[dayKey].isNotEmpty) {
        var dayFirstItem = course[dayKey][0];
        if (dayFirstItem['imageUrl'] != null &&
            dayFirstItem['imageUrl'].isNotEmpty) {
          return dayFirstItem['imageUrl'];
        }
      }
    } catch (e) {
      print('Error fetching image URL: $e');
    }
    return null;
  }
}