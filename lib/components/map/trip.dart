import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // http 패키지 추가
import 'dart:convert';

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  final TextEditingController _titleController = TextEditingController();
  FocusNode _titleFocusNode = FocusNode();
  String _searchText = '';
  String _selectedRegion = '경상남도'; 
  List<String> _filteredRegions = [];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        _searchText = _titleController.text;
        if (_searchText.isNotEmpty) {
          _fetchRecommendations(_searchText); 
        } else {
          _filteredRegions.clear(); }
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
    // API를 호출하지 않고 예시로 대체
   List<String> allRegions = [
  '경상남도 창원시',
  '경상남도 김해시',
  '경상남도 진주시',
  '경상남도 양산시',
  '경상남도 사천시',
  '경상남도 밀양시',
  '경상남도 통영시',
  '경상남도 거제시',
  '경상남도 함안군',
  '경상남도 창녕군',
  '경상남도 고성군',
  '경상남도 남해군',
  '경상남도 하동군',
  '경상남도 산청군',
  '경상남도 함양군',
  '경상남도 거창군',
  '경상남도 합천군'
];

    setState(() {
      if (query.isNotEmpty) {
        _filteredRegions = allRegions
            .where((region) => region.contains(query)) 
            .toList();
      } else {
        _filteredRegions.clear();
      }
    });
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
        padding: EdgeInsets.only(bottom: 20), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            SizedBox(height: 20),
            _buildSection('추천 여행지'),
            _buildHorizontalImageList(), // 추천 여행지 섹션
            _buildSection('인기 여행지'),
            _buildHorizontalImageList(), // 인기 여행지 섹션
            _buildSection('ENTP 여행지'),
            _buildHorizontalImageList(), // ENTP 여행지 섹션
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
          top: 80,
          left: 20,
          right: 20,
          child: _searchText.isNotEmpty && _filteredRegions.isNotEmpty // 검색 결과가 있을 때만 보여줌
              ? _buildSearchResults()
              : Container(), // 검색 결과가 없을 때 빈 컨테이너로 대체
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Text(
            _selectedRegion, // 선택된 지역을 보여줌
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
        onSubmitted: (_) { 
          setState(() {
            _filteredRegions.clear();
          });
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      height: 100, 
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
      child: ListView.builder(
        shrinkWrap: true,  
        itemCount: _filteredRegions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_filteredRegions[index]),
            onTap: () {
              setState(() {
                _titleController.text = _filteredRegions[index]; 
                _selectedRegion = _filteredRegions[index].split(' ')[1]; 
                _filteredRegions.clear(); 
              });
            },
          );
        },
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
      padding: EdgeInsets.only(left: 18.0, right: 18.0), 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // 일단 10으로 설정 하고 api 연동해서 추후에 변경 예정
        itemBuilder: (context, index) {
          return _buildImageItem(index);
        },
      ),
    );
  }

  Widget _buildImageItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('../assets/city${index % 3 + 1}.png'), // 추후에 api 연동해서 이미지 변경
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
}
