// location_and_person_selection_j.dart
import 'package:flutter/material.dart';
import 'package:untitled/pages/KeywordSelectionPage.dart'; // 경로와 파일 이름을 실제 프로젝트에 맞게 수정하세요.
import '../components/start/basicframe2.dart';
import '../hooks/top3course.dart';

class LocationAndPersonSelectionJ extends StatefulWidget {
  final List<DateTime> selectedDates;

  LocationAndPersonSelectionJ({required this.selectedDates});

  @override
  _LocationAndPersonSelectionJState createState() => _LocationAndPersonSelectionJState();
}

class _LocationAndPersonSelectionJState extends State<LocationAndPersonSelectionJ> {
  String? selectedLocation;
  String? selectedGroup;

  List<DropdownMenuItem<String>> _buildLocationItems() {
    return [
      DropdownMenuItem(value: '창원시', child: Text('창원시')),
      DropdownMenuItem(value: '김해시', child: Text('김해시')),
      DropdownMenuItem(value: '진주시', child: Text('진주시')),
      DropdownMenuItem(value: '양산시', child: Text('양산시')),
      DropdownMenuItem(value: '거제시', child: Text('거제시')),
      DropdownMenuItem(value: '사천시', child: Text('사천시')),
      DropdownMenuItem(value: '통영시', child: Text('통영시')),
      DropdownMenuItem(value: '밀양시', child: Text('밀양시')),
      DropdownMenuItem(value: '함안군', child: Text('함안군')),
      DropdownMenuItem(value: '창녕군', child: Text('창녕군')),
      DropdownMenuItem(value: '고성군', child: Text('고성군')),
      DropdownMenuItem(value: '하동군', child: Text('하동군')),
      DropdownMenuItem(value: '남해군', child: Text('남해군')),
      DropdownMenuItem(value: '산청군', child: Text('산청군')),
      DropdownMenuItem(value: '함양군', child: Text('함양군')),
      DropdownMenuItem(value: '거창군', child: Text('거창군')),
      DropdownMenuItem(value: '합천군', child: Text('합천군')),
    ];
  }

  List<DropdownMenuItem<String>> _buildGroupItems() {
    return [
      DropdownMenuItem(value: '혼자', child: Text('혼자')),
      DropdownMenuItem(value: '커플', child: Text('커플')),
      DropdownMenuItem(value: '친구', child: Text('친구')),
      DropdownMenuItem(value: '친구들', child: Text('친구들')),
      DropdownMenuItem(value: '아이와 함께', child: Text('아이와 함께')),
      DropdownMenuItem(value: '부모님과 함께', child: Text('부모님과 함께')),
    ];
  }

  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '항목을 모두 선택해주세요',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicFramePage5(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Color(0xFFE4E4E4),
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Image.asset('assets/animation.png', height: 50),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '자기만의 여행 코스를 만들어보세요! :)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'J형 코스 만들기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(screenHeight * 0.03),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'STEP 02 | 여행 장소 선택',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      value: selectedLocation,
                      hint: Text('여행 장소를 선택하세요'),
                      items: _buildLocationItems(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
                          print('Selected location: $selectedLocation');
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'STEP 03 | 인원 선택',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      value: selectedGroup,
                      hint: Text('인원을 선택하세요'),
                      items: _buildGroupItems(),
                      onChanged: (value) {
                        setState(() {
                          selectedGroup = value;
                          print('Selected group: $selectedGroup');
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedLocation == null || selectedGroup == null) {
                          _showSnackbar(context);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KeywordSelectionPage(
                                selectedDates: widget.selectedDates,
                                selectedLocation: selectedLocation!,
                                selectedGroup: selectedGroup!,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: Text('완료'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Top3Courses(),
          ],
        ),
      ),
    );
  }
}
