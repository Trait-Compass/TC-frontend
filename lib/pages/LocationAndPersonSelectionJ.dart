import 'package:flutter/material.dart';
import 'package:untitled/pages/coursemake.dart';
import '../components/basic_frame_page.dart';
import '../hooks/top3course.dart';

class LocationAndPersonSelectionJ extends StatefulWidget {
  @override
  _LocationAndPersonSelectionJState createState() =>
      _LocationAndPersonSelectionJState();
}

class _LocationAndPersonSelectionJState
    extends State<LocationAndPersonSelectionJ> {
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
    ];
  }

  final List<String> groups = ['혼자', '커플', '친구', '친구들', '아이와 함께', '부모님과 함께'];

  List<Widget> _buildGroupChips() {
    return groups.map((group) {
      return ChoiceChip(
        label: Text(group),
        selected: selectedGroup == group,
        onSelected: (selected) {
          setState(() {
            selectedGroup = group;
          });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicFramePage(
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
                      '자기만의 여행 코스를 만들어보세요!:)',
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
                      value: selectedLocation,
                      hint: Text('여행 장소를 선택하세요'),
                      items: _buildLocationItems(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
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
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: _buildGroupChips(),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          selectedLocation != null && selectedGroup != null
                              ? () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Coursemake(),
                                    ),
                                  )
                              : null,
                      child: Text('완료'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedLocation != null && selectedGroup != null
                                ? Colors.grey[800]
                                : Colors.grey[400],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
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
