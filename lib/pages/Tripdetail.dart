import 'package:flutter/material.dart';
import '../components/map/api.dart';
class PdetailPage extends StatefulWidget {
  final Map<int, List<Map<String, dynamic>>> tripDetails;
  final int totalDays;
  final String courseId;

  PdetailPage({required this.tripDetails, required this.totalDays, required this.courseId});

  @override
  _PdetailPageState createState() => _PdetailPageState();
}

class _PdetailPageState extends State<PdetailPage> {
  int selectedDayIndex = 0;

  // Add a variable to store courseId
  String? courseId;

  @override
  void initState() {
    super.initState();
    // Assign the courseId from widget to local variable
    courseId = widget.courseId;
  }

  // Show confirmation dialog and save course using courseId
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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        if (courseId != null) {
                          await ApiService.saveCourseToServer(courseId!);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('코스가 성공적으로 저장되었습니다!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('코스 ID가 없습니다. 저장할 수 없습니다.')),
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
                        '코스 저장할게요',
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
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      ),
                      child: Text(
                        '코스 저장 안할게요 ',
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

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentTripDetails = widget.tripDetails[selectedDayIndex] ?? [];

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
      ),
      body: Column(
        children: [
          // 날짜 선택 부분
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
                      backgroundColor: selectedDayIndex == index ? Colors.grey[300] : Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ),
          // 여행지 리스트
          Expanded(
            child: ListView.builder(
              itemCount: currentTripDetails.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // 여행지 카드
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 아이콘 및 세로선
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
                        // 여행지 정보 카드
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
                                    // 여행지 이름과 메뉴 버튼
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            currentTripDetails[index]['name'] ?? '알 수 없는 장소',
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
                                    Text(
                                      '키워드: ${currentTripDetails[index]['keywords']?.join(', ') ?? '정보 없음'}',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                    SizedBox(height: 8),
                                    currentTripDetails[index]['imageUrl'] != null
                                        ? Image.network(
                                      currentTripDetails[index]['imageUrl'],
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
                        padding: const EdgeInsets.only(left: 40.0, top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.directions_car, size: 20),
                            SizedBox(width: 8),
                            Text(
                              currentTripDetails[index]['travelInfoToNext']?['carTime'] ?? '차 이동 정보 없음',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.directions_walk, size: 20),
                            SizedBox(width: 8),
                            Text(
                              currentTripDetails[index]['travelInfoToNext']?['walkingTime'] ?? '도보 이동 정보 없음',
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
                        // 공유하기 기능 추가
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
