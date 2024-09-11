import 'package:flutter/material.dart';

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  final TextEditingController _titleController = TextEditingController();
  FocusNode _titleFocusNode = FocusNode();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        _searchText = _titleController.text;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
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
          hintText: '장소를 검색하세요',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.grey),
        ),
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
