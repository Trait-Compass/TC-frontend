// MapPage.dart
import 'package:flutter/material.dart';
import '../map/trip.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // 선택된 일자 인덱스를 nullable로 변경 (초기에는 선택된 일자가 없음)
  int? selectedDayIndex;

  // 날짜별 여행지 리스트를 관리하기 위한 변수
  Map<int, List<Map<String, String>>> tripDetails = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('내 일정', style: TextStyle(fontSize: 15)),
        actions: [
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
                      // 이미 선택된 일자를 다시 누르면 선택 해제
                      if (isSelected) {
                        selectedDayIndex = null;
                      } else {
                        selectedDayIndex = index;
                      }
                    });
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
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (selectedDayIndex == null) {
                    // 선택된 일자가 없으면 Snackbar 표시
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('일자를 선택한 후 여행지를 추가해주세요'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // 선택된 일자가 있으면 Trip 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Trip(
                          selectedDayIndex: selectedDayIndex!,
                          tripDetails: tripDetails,
                        ),
                      ),
                    ).then((result) {
                      if (result != null && result is Map<int, List<Map<String, String>>>) {
                        setState(() {
                          tripDetails = result;
                        });
                      }
                    });
                  }
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 40, color: Colors.grey[600]),
                      SizedBox(height: 10),
                      Text(
                        '여행지 추가하기',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 하단 수정하기 및 공유하기 버튼 (필요에 따라 추가)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}