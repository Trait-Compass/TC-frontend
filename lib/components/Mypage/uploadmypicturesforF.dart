// lib/pages/uploadmypictures.dart

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import '../Mypage/mypagemodelforF.dart';
import 'selectdate.dart';

class TravelDetailPage extends StatefulWidget {
  final TravelDiaryEmotion diaryEmotion; // 모델 인스턴스 전달

  TravelDetailPage({required this.diaryEmotion});

  @override
  _TravelDetailPageState createState() => _TravelDetailPageState();
}

class _TravelDetailPageState extends State<TravelDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _courseNameController = TextEditingController();

  List<File?> _selectedImages = List.generate(10, (_) => null);
  List<Uint8List?> _webImages = List.generate(10, (_) => null);
  List<bool> _isLoading = List.generate(10, (_) => false);
  int _nextBoxToShow = 1;
  int loadingTime = 3;

  List<DateTime>? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _courseNameController.text = widget.diaryEmotion.courseName;
    _selectedDateRange = [
      widget.diaryEmotion.travelDate,
      widget.diaryEmotion.travelDate
    ];
    if (widget.diaryEmotion.travelPhotos != null) {
      for (int i = 0;
          i < widget.diaryEmotion.travelPhotos!.length && i < 10;
          i++) {
        _selectedImages[i] = File(widget.diaryEmotion.travelPhotos![i]);
        _nextBoxToShow = i + 1;
      }
    }
  }

  String _getKoreanNumber(int index) {
    const koreanNumbers = [
      '첫',
      '두',
      '세',
      '네',
      '다섯',
      '여섯',
      '일곱',
      '여덟',
      '아홉',
      '열'
    ];
    return koreanNumbers[index];
  }

  // 권한 요청 함수
  Future<void> _requestPermissions(int index) async {
    PermissionStatus status = await Permission.photos.request(); // 사진 접근 권한 요청

    if (status.isGranted) {
      _pickImage(index); // 권한이 허용되면 이미지 선택 함수 호출
    } else {
      print("사진 접근 권한이 필요합니다.");
    }
  }

  Future<void> _pickImage(int index) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _isLoading[index] = true;
        });

        await Future.delayed(Duration(seconds: loadingTime));

        if (kIsWeb) {
          Uint8List webImageBytes = await pickedFile.readAsBytes();
          setState(() {
            _webImages[index] = webImageBytes;
            _isLoading[index] = false;
            if (index + 1 < 10) _nextBoxToShow = index + 2;
          });
        } else {
          setState(() {
            _selectedImages[index] = File(pickedFile.path);
            _isLoading[index] = false;
            if (index + 1 < 10) _nextBoxToShow = index + 2;
          });
        }

        _saveToModel();
      }
    } catch (e) {
      print("이미지를 선택하는 중 오류가 발생했습니다: $e");
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages[index] = null;
      _webImages[index] = null;
      _isLoading[index] = false;
      _nextBoxToShow--;
    });

    _saveToModel();
  }

  void _showDateSelectionDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(10),
            child: CustomDateRangeSelector(
              onDateRangeSelected: (selectedDates) {
                setState(() {
                  _selectedDateRange = selectedDates;
                  if (selectedDates != null && selectedDates.length == 2) {
                    widget.diaryEmotion.travelDate = selectedDates[0];
                  }
                });
                _saveToModel();
              },
            ),
          ),
        );
      },
    );
  }

  String formatDateRange(List<DateTime> dateRange) {
    String format(DateTime date) =>
        '${date.year.toString().padLeft(4, '0')}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    return '${format(dateRange[0])} ~ ${format(dateRange[1])}';
  }

  void _saveToModel() {
    widget.diaryEmotion.courseName = _courseNameController.text;
    if (_selectedDateRange != null && _selectedDateRange!.length == 2) {
      widget.diaryEmotion.travelDate = _selectedDateRange![0]; // 시작 날짜로 설정
    }
    widget.diaryEmotion.travelPhotos = _selectedImages
        .where((file) => file != null)
        .map((file) => file!.path)
        .toList();
    // 추가 필드도 동일하게 저장
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '코스 이름:',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _courseNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 14),
                          onChanged: (value) {
                            _saveToModel();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: _showDateSelectionDialog,
                  child: Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_selectedDateRange == null)
                          Text(
                            '여행 날짜:',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                          ),
                        if (_selectedDateRange != null &&
                            _selectedDateRange!.length == 2)
                          Text(
                            '${formatDateRange(_selectedDateRange!)}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text('여행 사진 업로드 (최대 10장)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            height: 150,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      _nextBoxToShow, (index) => _buildImageBox(index)),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
        ],
      ),
    );
  }

  Widget _buildImageBox(int index) {
    bool hasImage = _selectedImages[index] != null || _webImages[index] != null;
    bool isLoading = _isLoading[index];

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${_getKoreanNumber(index)} 번째 사진 기록',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(height: 5),
          Stack(
            children: [
              isLoading
                  ? Container(
                      width: 145,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'GPT-4 Vision으로 사진 분석 중...',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : hasImage
                      ? Container(
                          width: 145,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Center(
                            child: (_selectedImages[index] != null && !kIsWeb)
                                ? Image.file(
                                    _selectedImages[index]!,
                                    width: 120,
                                    height: 80,
                                    fit: BoxFit.contain,
                                  )
                                : Image.memory(
                                    _webImages[index]!,
                                    width: 120,
                                    height: 80,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        )
                      : DottedBorder(
                          color: Colors.black,
                          strokeWidth: 1,
                          dashPattern: [4, 2],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          child: Container(
                            width: 145,
                            height: 115,
                            color: Colors.white,
                            child: Center(
                              child: _buildAddButton(index),
                            ),
                          ),
                        ),
              if (hasImage)
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => _removeImage(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // "사진 추가하기" 버튼을 빌드하는 함수
  Widget _buildAddButton(int index) {
    return TextButton(
      onPressed: () => _requestPermissions(index), // 권한 요청 후 파일 선택
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color(0xFFE0E0E0)), // 회색 배경색 설정
        minimumSize: MaterialStateProperty.all<Size>(Size(85, 25)), // 버튼 크기 설정
      ),
      child: Text(
        '사진 추가하기',
        style: TextStyle(
          fontSize: 12,
          color: Colors.black, // 텍스트 색상 검정
          fontWeight: FontWeight.bold, // 텍스트 볼드체
        ),
      ),
    );
  }
}
