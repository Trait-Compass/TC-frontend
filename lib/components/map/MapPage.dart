import 'package:flutter/material.dart';

class MapPage extends StatefulWidget { 
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int selectedDayIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 일정'),
        actions: [
          TextButton(
            onPressed: () {
             
            },
            child: Text(
              '완료',
              style: TextStyle(color: Colors.black),
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
                          : Colors.grey[200],
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
                  Navigator.pop(context); 
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 40, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        '여행지 추가하기',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                   
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
