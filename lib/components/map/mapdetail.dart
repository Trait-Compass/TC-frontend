import 'package:flutter/material.dart';
import '../map/mapresult.dart'; // 필요에 따라 import

class MapdetailPage extends StatefulWidget {
  final Map<int, List<Map<String, String>>> tripDetails;

  MapdetailPage({required this.tripDetails});

  @override
  _MapdetailPageState createState() => _MapdetailPageState();
}

class _MapdetailPageState extends State<MapdetailPage> {
  int selectedDayIndex = 0;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
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
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 저장 로직 추가
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '네, 저장할게요!',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // 다음에 수정하기 로직 추가
                        Navigator.of(context).pop(); // Dialog 닫기
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mapresult(),
                          ),
                        );
                      },
                      child: Text(
                        '아니요, 다음에 수정할게요!',
                        style: TextStyle(color: Colors.grey[600]),
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
    // 선택한 날짜의 여행지 리스트 가져오기
    List<Map<String, String>> currentTripDetails =
        widget.tripDetails[selectedDayIndex] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            Text('내 일정', style: TextStyle(fontSize: 15, color: Colors.black)),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // 여행지 이름과 메뉴 버튼
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            currentTripDetails[index]
                                                ['title']!,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          icon: Icon(Icons.more_vert),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          offset: Offset(0, 10),
                                          onSelected: (value) {
                                            if (value == 'delete') {
                                              setState(() {
                                                currentTripDetails
                                                    .removeAt(index);
                                                // 삭제 후 데이터 업데이트
                                                widget.tripDetails[
                                                        selectedDayIndex] =
                                                    currentTripDetails;
                                              });
                                            }
                                          },
                                          itemBuilder:
                                              (BuildContext context) =>
                                                  <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                    ),
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
          // 하단 공유하기 버튼
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
