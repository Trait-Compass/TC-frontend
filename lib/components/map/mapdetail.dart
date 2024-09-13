import 'package:flutter/material.dart';

class MapdetailPage extends StatefulWidget {
  final List<Map<String, String>> tripDetails;

  MapdetailPage({required this.tripDetails});

  @override
  _MapdetailPageState createState() => _MapdetailPageState();
}

class _MapdetailPageState extends State<MapdetailPage> {
  int selectedDayIndex = 0;
  late List<Map<String, String>> tripDetails;

  @override
  void initState() {
    super.initState();
    // 전달받은 리스트를 상태로 초기화
    tripDetails = widget.tripDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title:
            Text('내 일정', style: TextStyle(fontSize: 15, color: Colors.black)),
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
          // 여행지 리스트
          Expanded(
            child: ListView.builder(
              itemCount: tripDetails.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // 여행지 카드
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      children: [   
                        SizedBox(
                          width: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              Icon(Icons.place, color: Colors.black),
                              if (index < tripDetails.length - 1)
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
                                borderRadius:
                                    BorderRadius.circular(15), 
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0), 
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            tripDetails[index]['title']!,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () {
                                            // 추가 기능
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      tripDetails[index]['address']!,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (index < tripDetails.length - 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.directions_bus, size: 20),
                            SizedBox(width: 8),
                            Text(
                              '약 32분 소요',
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
