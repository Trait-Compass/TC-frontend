import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // http 패키지 추가
import 'dart:convert';

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  final TextEditingController _titleController = TextEditingController();
  FocusNode _titleFocusNode = FocusNode();
  String _searchText = '';
  List<String> _filteredRegions = [];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        _searchText = _titleController.text;
        if (_searchText.isNotEmpty) {
          _fetchRecommendations(_searchText);  // API 호출
        } else {
          _filteredRegions.clear();
        }
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchRecommendations(String query) async {
    final url = Uri.parse('https://www.traitcompass.store/spot/recommand');  // API 엔드포인트
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer YOUR_ACCESS_TOKEN',  // 여기에 실제 엑세스 토큰을 추가하세요
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _filteredRegions = data.map((item) => item['location'].toString()).toList();  // 응답 데이터에서 필요한 정보를 가져옵니다.
        });
      } else {
        print('Failed to load recommendations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recommendations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('여행지 추가', style: TextStyle(fontSize: 18, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            SizedBox(height: 20),
            _buildSection('추천 여행지'),
            _buildHorizontalImageList(),
            _buildSliderIndicator(),  
            _buildSection('인기 여행지'),
            _buildHorizontalImageList(),
            _buildSliderIndicator(), 
            _buildSection('ENTP 여행지'),
            _buildHorizontalImageList(),
            _buildSliderIndicator(),  
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.asset(
            '../assets/city2.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: _buildSearchBar(),
        ),
        Positioned(
          top: 80,  // 검색창 바로 아래에 위치하도록 설정
          left: 20,
          right: 20,
          child: _searchText.isNotEmpty ? _buildSearchResults() : Container(),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Text(
            '창원',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: _titleController,
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          hintText: '경상남도 지역을 검색하세요',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          suffixIcon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: _filteredRegions.map((region) {
          return ListTile(
            title: Text(region),
            onTap: () {
              setState(() {
                _searchText = region;
                _titleController.text = region; // 선택된 지역으로 텍스트 업데이트
                _filteredRegions.clear(); // 검색 결과 닫기
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHorizontalImageList() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return _buildImageItem();
        },
      ),
    );
  }

  Widget _buildImageItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('../assets/city3.png'), 
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(8),
      child: Text(
        '고부길 벽화마을',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSliderIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Divider(
                color: Colors.black,
                thickness: 1.5,
              ),
            ),
            Expanded(
              flex: 3,
              child: Divider(
                color: Colors.black.withOpacity(0.2),
                thickness: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
