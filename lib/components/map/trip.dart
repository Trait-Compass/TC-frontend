// Trip.dart
import 'package:flutter/material.dart';
import 'tripmodal.dart'; 
import 'mapdetail.dart'; 
import 'package:untitled/components/map/api.dart'; 

class Trip extends StatefulWidget {
  final int selectedDayIndex;
  final Map<int, List<Map<String, String>>> tripDetails;

  Trip({required this.selectedDayIndex, required this.tripDetails});

  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  final TextEditingController _titleController = TextEditingController();
  FocusNode _titleFocusNode = FocusNode();
  String _searchText = '';
  String _selectedRegion = '창원시';
  List<String> _filteredRegions = [];
  List<Map<String, dynamic>> recommendedTrips = [];
  List<Map<String, dynamic>> popularTrips = [];
  List<Map<String, dynamic>> mbtiTrips = [];
  String mbtiType = '';  // MBTI 값을 저장할 변수 추가

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _titleController.addListener(() {
      setState(() {
        _searchText = _titleController.text;
        if (_searchText.isNotEmpty) {
          _fetchRecommendations(_searchText);
        } else {
          _filteredRegions.clear();
        }
      });
    });
  }

  Future<void> _fetchInitialData() async {
    try {
      recommendedTrips = await ApiService.fetchRecommendedSpots(_selectedRegion);
      popularTrips = await ApiService.fetchPopularSpots(_selectedRegion);
      
      // MBTI 여행지 데이터와 MBTI 값을 가져옴
      final mbtiData = await ApiService.fetchMbtiSpots();
      mbtiTrips = mbtiData['tourList'];
      mbtiType = mbtiData['mbti'];  // MBTI 값 저장

      setState(() {}); // 데이터 업데이트 후 화면 갱신
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchRecommendations(String query) async {
    List<String> allRegions = [
      '경상남도 창원시',
      '경상남도 김해시',
      '경상남도 마산시',
      '경상남도 밀양시',
      '경상남도 사천시',
      '경상남도 양산시',
      '경상남도 진주시',
      '경상남도 진해시',
      '경상남도 거제시',
      '경상남도 통영시',
      '경상남도 거창군',
      '경상남도 고성군',
      '경상남도 남해군',
      '경상남도 산청군',
      '경상남도 의령군',
      '경상남도 창녕군',
      '경상남도 하동군',
      '경상남도 함안군',
      '경상남도 함양군',
      '경상남도 합천군',
    ];

    setState(() {
      if (query.isNotEmpty) {
        _filteredRegions = allRegions
            .where((region) => region.contains(query))
            .map((region) => region.split(' ')[1]) // '경상남도 창원시'에서 '창원시' 추출
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
        title: Text('여행지 추가', style: TextStyle(fontSize: 15, color: Colors.black)),
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
            Navigator.pop(context, widget.tripDetails);
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
            _buildHorizontalImageList(recommendedTrips),
            _buildSection('인기 여행지'),
            _buildHorizontalImageList(popularTrips),
             _buildSection('$mbtiType 여행지'),
            _buildHorizontalImageList(mbtiTrips),
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
            'assets/city2.png',
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
          child: _searchText.isNotEmpty && _filteredRegions.isNotEmpty
              ? _buildSearchResults()
              : Container(),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Text(
            _selectedRegion,
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
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
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
                _selectedRegion = _filteredRegions[index]; // 하위 지역만 전송
                _filteredRegions.clear();
                _fetchInitialData(); 
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

Widget _buildHorizontalImageList(List<Map<String, dynamic>> trips) {
  return Container(
    height: 150,
    padding: EdgeInsets.only(left: 18.0, right: 18.0),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.5),
              builder: (context) => TripDetailModal(
                imageUrl: trips[index]['imageUrl'] ?? 'assets/city2.png',
                title: trips[index]['title'] ?? '경상남도',
                address: trips[index]['address'] ?? '주소 정보 없음',
                code: trips[index]['code'],
                contentId: trips[index]['contentId'],
                x: trips[index]['location']['coordinates'][0].toDouble(), 
                y: trips[index]['location']['coordinates'][1].toDouble(), 
              ),
            ).then((result) {
              if (result != null) {
                setState(() {
                  int dayIndex = widget.selectedDayIndex;
                  if (!widget.tripDetails.containsKey(dayIndex)) {
                    widget.tripDetails[dayIndex] = [];
                  }
                  widget.tripDetails[dayIndex]!.add(result);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapdetailPage(
                      tripDetails: widget.tripDetails,
                    ),
                  ),
                );
              }
            });
          },
          child: _buildImageItem(trips[index]['imageUrl'] ?? 'assets/city2.png', trips[index]['title'] ?? '경상남도'),
        );
      },
    ),
  );
}

  Widget _buildImageItem(String imagePath, String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: imagePath.startsWith('http')  
              ? NetworkImage(imagePath)
              : AssetImage(imagePath) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}