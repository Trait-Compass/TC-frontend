import 'package:flutter/material.dart';
import '../map/trip.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int selectedDayIndex = 0;

  // 날짜별 여행지 리스트를 관리하기 위한 변수
  Map<int, List<Map<String, String>>> tripDetails = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('내 일정', style: TextStyle(fontSize: 15)),
        actions: [
          TextButton(
            onPressed: () {
              // 완료 버튼 기능 추가
            },
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
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Trip 페이지로 이동할 때 선택한 날짜 인덱스와 현재의 tripDetails를 전달
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Trip(
                        selectedDayIndex: selectedDayIndex,
                        tripDetails: tripDetails,
                      ),
                    ),
                  ).then((result) {
                    if (result != null) {
                      setState(() {
                        tripDetails = result;
                      });
                    }
                  });
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 수정하기 및 공유하기 버튼 추가 가능
              ],
            ),
          ),
        ],
      ),
    );
  }
}
