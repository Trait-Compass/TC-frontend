// MapdetailPage.dart
import 'package:flutter/material.dart';
import '../map/mapresult.dart';
import 'dart:async';
import 'dart:convert';
import '../map/api.dart';

class MapdetailPage extends StatefulWidget {
  final Map<int, List<Map<String, String>>> tripDetails;

  MapdetailPage({required this.tripDetails});

  @override
  _MapdetailPageState createState() => _MapdetailPageState();
}

class _MapdetailPageState extends State<MapdetailPage> {
  int selectedDayIndex = 0;
  List<Map<String, String>> travelDurations = [];

  @override
  void initState() {
    super.initState();
    _calculateTravelDurations();
  }

  Future<void> _calculateTravelDurations() async {
    List<Map<String, String>> currentTripDetails = widget.tripDetails[selectedDayIndex] ?? [];

    print('Calculating travel durations for day ${selectedDayIndex + 1}');
    print('Current Trip Details: $currentTripDetails');

    travelDurations.clear();

    for (int i = 0; i < currentTripDetails.length - 1; i++) {
      final startX = currentTripDetails[i]['x'];
      final startY = currentTripDetails[i]['y'];
      final endX = currentTripDetails[i + 1]['x'];
      final endY = currentTripDetails[i + 1]['y'];

      print('Trip Segment ${i + 1}: From ($startX, $startY) to ($endX, $endY)');

      if (startX == null || startY == null || endX == null || endY == null) {
        print('One or more coordinates are null. Skipping this segment.');
        travelDurations.add({'carTime': '정보 없음', 'walkTime': '정보 없음'});
        continue;
      }

      try {
        final response = await ApiService.get('/spot/distance', params: {
          'startMapX': startX,
          'startMapY': startY,
          'endtMapX': endX,
          'endMapY': endY,
        });

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final result = jsonResponse['result'];
          final carTime = result['carTime'] ?? '정보 없음';
          final walkTime = result['walkTime'] ?? '정보 없음';
          travelDurations.add({'carTime': carTime, 'walkTime': walkTime});
          print('Travel Time: $carTime, Walk Time: $walkTime');
        } else {
          print('Failed to fetch travel duration. Status Code: ${response.statusCode}');
          travelDurations.add({'carTime': '정보 없음', 'walkTime': '정보 없음'});
        }
      } catch (e) {
        print('Failed to fetch travel duration: $e');
        travelDurations.add({'carTime': '정보 없음', 'walkTime': '정보 없음'});
      }
    }

    setState(() {});
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '저장하시겠습니까?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool success = await _postTripDetails();

                        if (success) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('코스가 성공적으로 저장되었습니다!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('다시 시도해주세요.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                      ),
                      child: Text(
                        '네! 코스 저장할게요',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                      ),
                      child: Text(
                        '아니요! 코스 저장안할게요 ',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _postTripDetails() async {
    try {
      Map<String, dynamic> requestBody = {
        'code': 3,
      };

      for (int dayIndex = 0; dayIndex <= 2; dayIndex++) {
        String dayKeyString = 'day${dayIndex + 1}';

        if (widget.tripDetails.containsKey(dayIndex)) {
          List<Map<String, String>> dayTripDetails = widget.tripDetails[dayIndex]!;

          requestBody[dayKeyString] = dayTripDetails.map((detail) {
            print(detail);
            return {
              'contentId': detail['contentId']!,
            };
          }).toList();

          print('Day ${dayIndex + 1} Trip Details:');
          for (int i = 0; i < dayTripDetails.length; i++) {
            print('  Location ${i + 1}: ${dayTripDetails[i]}');
          }
        } else {
          print('No trip details for Day ${dayIndex + 1}.');
        }
      }

      print('Request Body: ${json.encode(requestBody)}');

      final response = await ApiService.post('/course/j', requestBody);

      if (response.statusCode == 201) {
        print('Trip details posted successfully.');
        return true;
      } else {
        print('Failed to post trip details. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while saving trip details: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentTripDetails = widget.tripDetails[selectedDayIndex] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('내 일정', style: TextStyle(fontSize: 15, color: Colors.black)),
        actions: [
          TextButton(
            onPressed: _showConfirmationDialog,
            child: Text(
              '완료',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // 날짜 선택 부분
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(3, (index) {
                bool isSelected = selectedDayIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                    });
                    _calculateTravelDurations();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text('${index + 1}일차'),
                      backgroundColor: isSelected ? Colors.grey[300] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isSelected ? Colors.grey : Colors.grey[400]!,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentTripDetails.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.place, color: Colors.black),
                              if (index < currentTripDetails.length - 1)
                                Container(
                                  height: 100,
                                  width: 2,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Card(
                              color: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            currentTripDetails[index]['title']!,
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          icon: Icon(Icons.more_vert),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          offset: Offset(0, 10),
                                          onSelected: (value) {
                                            if (value == 'delete') {
                                              setState(() {
                                                currentTripDetails.removeAt(index);
                                                widget.tripDetails[selectedDayIndex] = currentTripDetails;
                                                _calculateTravelDurations();
                                              });
                                            }
                                          },
                                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: Text(
                                                  '삭제하기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    // 주소
                                    Text(
                                      currentTripDetails[index]['address']!,
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (index < currentTripDetails.length - 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.directions_car, size: 20, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  travelDurations.length > index ? travelDurations[index]['carTime']! : '정보 없음',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.directions_walk, size: 20, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  travelDurations.length > index ? travelDurations[index]['walkTime']! : '정보 없음',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                      },
                    ),
                    Text('공유하기', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}