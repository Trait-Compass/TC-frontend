import 'package:flutter/material.dart';
import 'tripmodal.dart'; // TripDetailModal import
import 'mapdetail.dart'; // MapdetailPage import
import 'api.dart'; // ApiService import

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
  String _selectedRegion = '경상남도';
  List<String> _filteredRegions = [];

  List<Map<String, String>> recommendedSpots = [];
  List<Map<String, String>> popularSpots = [];
  List<Map<String, String>> mbtiSpots = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
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
    _fetchAllSpots(); // 여행지 데이터 불러오기
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchAllSpots() async {
  try {
    List<Map<String, dynamic>> recommendedData =
        await apiService.fetchRecommendedSpots(_selectedRegion);
    List<Map<String, dynamic>> popularData =
        await apiService.fetchPopularSpots(_selectedRegion);
    List<Map<String, dynamic>> mbtiData = await apiService.fetchMbtiSpots();

    setState(() {
      // dynamic을 String으로 캐스팅
      recommendedSpots = recommendedData.map((e) {
        return {
          'image': e['image'].toString(),
          'title': e['title'].toString(),
        };
      }).toList();

      popularSpots = popularData.map((e) {
        return {
          'image': e['image'].toString(),
          'title': e['title'].toString(),
        };
      }).toList();

      mbtiSpots = mbtiData.map((e) {
        return {
          'image': e['image'].toString(),
          'title': e['title'].toString(),
        };
      }).toList();
    });
  } catch (e) {
    print('Error fetching spots: $e');
  }
}

  Future<void> _fetchRecommendations(String query) async {
    List<String> allRegions = [
      '경상남도 창원시',
      '경상남도 김해시',
      // 기타 지역 추가
    ];

    setState(() {
      if (query.isNotEmpty) {
        _filteredRegions = allRegions.where((region) => region.contains(query)).toList();
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
            _buildHorizontalImageList(recommendedSpots),
            _buildSection('인기 여행지'),
            _buildHorizontalImageList(popularSpots),
            _buildSection('MBTI 여행지'),
            _buildHorizontalImageList(mbtiSpots),
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
          hintText: '경상남도를 입력 후 경상남도 지역을 검색하세요',
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

  Widget _buildHorizontalImageList(List<Map<String, String>> spots) {
    return Container(
      height: 150,
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: spots.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) => TripDetailModal(
                  imagePath: spots[index]['image']!,
                  title: spots[index]['title']!,
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
            child: _buildImageItem(spots[index]['image']!, spots[index]['title']!),
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
          image: AssetImage(imagePath),
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
