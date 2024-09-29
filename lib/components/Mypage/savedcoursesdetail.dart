import 'package:flutter/material.dart';

class SavedCourseDetailPage extends StatefulWidget {
  final Map<int, List<Map<String, dynamic>>> tripDetails;
  final int totalDays;
  final String courseId;

  SavedCourseDetailPage({
    required this.tripDetails,
    required this.totalDays,
    required this.courseId,
  });

  @override
  _SavedCourseDetailPageState createState() => _SavedCourseDetailPageState();
}

class _SavedCourseDetailPageState extends State<SavedCourseDetailPage> {
  int selectedDayIndex = 0;
  String? courseId;

  @override
  void initState() {
    super.initState();
    courseId = widget.courseId;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentTripDetails =
        widget.tripDetails[selectedDayIndex] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('내 일정', style: TextStyle(fontSize: 15, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), 
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ), 
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(widget.totalDays, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text('${index + 1}일차'),
                      backgroundColor: selectedDayIndex == index
                          ? Colors.grey[300]
                          : Colors.white,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // 여행지 이름
                                    Text(
                                      currentTripDetails[index]['name'] ??
                                          '알 수 없는 장소',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '키워드: ${currentTripDetails[index]['keywords']?.join(', ') ?? '정보 없음'}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                    ),
                                    SizedBox(height: 8),
                                    currentTripDetails[index]['imageUrl'] !=
                                            null
                                        ? Image.network(
                                            currentTripDetails[index]
                                                ['imageUrl'],
                                            height: 150,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 이동 시간 표시
                    if (index < currentTripDetails.length - 1)
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40.0, top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.directions_car, size: 20),
                            SizedBox(width: 8),
                            Text(
                              currentTripDetails[index]['travelInfoToNext']
                                          ?['carTime'] ??
                                      '차 이동 정보 없음',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.directions_walk, size: 20),
                            SizedBox(width: 8),
                            Text(
                              currentTripDetails[index]['travelInfoToNext']
                                          ?['walkingTime'] ??
                                      '도보 이동 정보 없음',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}