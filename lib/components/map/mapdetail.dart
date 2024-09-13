import 'package:flutter/material.dart';

class MapdetailPage extends StatefulWidget {
  final String title; 
  final String address; 

  MapdetailPage({required this.title, required this.address}); 

  @override
  _MapdetailPageState createState() => _MapdetailPageState();
}

class _MapdetailPageState extends State<MapdetailPage> {
  int selectedDayIndex = 0;
  List<Map<String, String>> tripDetails = []; 
  @override
  void initState() {
    super.initState();
    // 초기 데이터를 리스트에 추가
    tripDetails.add({'title': widget.title, 'address': widget.address});
  }

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
            child: ListView.builder(
              itemCount: tripDetails.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.place, color: Colors.black),
                          title: Text(tripDetails[index]['title']!),
                          subtitle: Text(tripDetails[index]['address']!),
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              // 추가 기능
                            },
                          ),
                        ),
                        if (index < tripDetails.length - 1)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 32.0),
                                child: Icon(Icons.directions_bus, size: 20),
                              ),
                              Text('약 32분'), // 이동 시간 예시
                            ],
                          ),
                      ],
                    ),
                  ),
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

 
  void addTripDetail(Map<String, String> detail) {
    setState(() {
      tripDetails.add(detail); 
    });
  }
}
