import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../map/api.dart';

class TravelDiary extends StatefulWidget {
  @override
  _TravelDiaryState createState() => _TravelDiaryState();
}

class _TravelDiaryState extends State<TravelDiary> {
  late Future<List<Map<String, dynamic>>> _travelDiaryFuture;

  @override
  void initState() {
    super.initState();
    _travelDiaryFuture = fetchTravelDiaries();
  }

  Future<List<Map<String, dynamic>>> fetchTravelDiaries() async {
    try {
      final response = await ApiService.get('/diary/list');
      if (response.statusCode == 200) {
        print(response);
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['result'] is List) {
          final List<dynamic> data = responseData['result'];
          return List<Map<String, dynamic>>.from(data.map((item) => Map<String, dynamic>.from(item)));
        } else {
          throw Exception('Unexpected data format: result is not a list');
        }
      } else {
        throw Exception('Failed to load travel diaries: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch travel diaries: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '여행 일기장',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _travelDiaryFuture,
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
                      '작성된 여행일기장이 없습니다.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                List<Map<String, dynamic>> diaries = snapshot.data!;
                return Container(
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: diaries.length > 2 ? 2 : diaries.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> diary = diaries[index];

                      return Container(
                        height: 70,
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 0,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  diary['imageUrl'] ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey[700]),
                                    );
                                  },
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
                                    diary['courseName'] ?? '코스 이름 없음',
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
                                    '지역: ${diary['region'] ?? '정보 없음'}',
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
                                  Text(
                                    ' ${diary['nature'] == 'T' ? 'T' : 'F'}',
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
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}


