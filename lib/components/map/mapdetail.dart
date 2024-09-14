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
                        Navigator.of(context).pop(); 
                      },
                      child: Text(
                        '네, 저장할게요!',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // 저장 기능 추가
                        Navigator.of(context).pop(); // Dialog 닫기
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
    return Scaffold(
      backgroundColor: Colors.white, // 배경 흰색 유지
      appBar: AppBar(
        title: Text('내 일정', style: TextStyle(fontSize: 15, color: Colors.black)),
        actions: [
          TextButton(
            onPressed: _showConfirmationDialog, // 완료 버튼 기능 추가
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
                      crossAxisAlignment: CrossAxisAlignment.center, // 아이콘과 카드 수직 중앙 정렬
                      children: [
                        // 아이콘 및 세로선
                        SizedBox(
                          width: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // 아이콘 수직 중앙 정렬
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
                              color: Colors.white, // 배경을 흰색으로 설정
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15), // 모서리 반경 증가
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0), // 내부 패딩 추가
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 여행지 이름과 메뉴 버튼
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
                                        PopupMenuButton<String>(
                                          icon: Icon(Icons.more_vert),
                                          color: Colors.white,  // 팝업 메뉴의 배경색 설정
                                          shape: RoundedRectangleBorder( // 모서리 둥글게 설정
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          offset: Offset(0, 10),  // 팝업 메뉴의 위치를 약간 아래로 이동
                                          onSelected: (value) {
                                            if (value == 'delete') {
                                              setState(() {
                                                tripDetails.removeAt(index);
                                              });
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
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
                                                      BorderRadius.circular(8.0),
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
                    // 이동 시간 표시
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
