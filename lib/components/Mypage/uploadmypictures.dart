import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'dart:typed_data';
import 'selectdate.dart';
import 'api_Mypage.dart'; // API 호출 파일 임포트

class TravelDetailPage extends StatefulWidget {
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

  Future<void> _pickImage(int index) async {
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
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages[index] = null;
      _webImages[index] = null;
      _isLoading[index] = false;
      _nextBoxToShow--;
    });
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
                });
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

  // ** API 호출 함수 **
  Future<void> _submitDataToServer() async {
    String courseName = _courseNameController.text;
    String travelDate = _selectedDateRange != null
        ? _selectedDateRange![0].toIso8601String()
        : DateTime.now().toIso8601String();

    // 이미지를 서버로 보낼 준비
    List<File?> selectedFiles =
        _selectedImages.where((image) => image != null).toList();
    List<Uint8List?> webImages =
        _webImages.where((image) => image != null).toList();

    // ** 서버로 데이터 전송 (courseName, travelDate, 이미지 등) **
    await ApiService.sendTravelDiary(
      courseName: courseName,
      nature: 'T', // 예시 값, 필요에 맞게 수정 가능
      travelDate: travelDate,
      foodSatisfaction: 9, // 고정값 예시
      satisfiedEmotions: '성취감,감동적임',
      keepFeedback: '숙소 서비스가 조금 부족했어요.',
      disappointedEmotions: '아쉬움,후회',
      sadEmotions: '우울함,절망감',
      finalThoughts: '이번 여행은 정말 잊을 수 없을 것 같아요.',
      satisfactionFeedback: '여행이 정말 즐거웠어요.',
      surprisedEmotions: '감탄,새로운 발견',
      priceSatisfaction: 6,
      transportationSatisfaction: 8,
      sightseeingSatisfaction: 9,
      happyEmotions: '기쁨,즐거움',
      angryEmotions: '짜증,분노',
      travelPhotos: selectedFiles.isNotEmpty
          ? selectedFiles[0]!.path
          : '', // 첫 번째 이미지만 예시로 보냄
      improvementFeedback: '숙소 서비스가 조금 부족했어요.',
      positiveFeedback: '여행이 정말 즐거웠어요.',
      accommodationSatisfaction: 7,
      comfortableEmotions: '안락함,평화로움',
      environmentSatisfaction: 8,
    );
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
                            fontSize: 14,
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
                        if (_selectedDateRange != null)
                          Text(
                            '${formatDateRange(_selectedDateRange!)}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                      _nextBoxToShow,
                      (index) => _buildImageBox(
                          index)), // 사용자가 이미지를 추가한 개수만큼 박스를 동적으로 생성
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
          ElevatedButton(
            onPressed: _submitDataToServer,
            child: Text('일기 제출하기'),
          ),
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
      onPressed: () => _pickImage(index), // 버튼 클릭 시 파일 선택기 열기
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(Color(0xFFE0E0E0)), // 회색 배경색 설정
        minimumSize: WidgetStateProperty.all<Size>(Size(85, 25)), // 버튼 크기 설정
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
