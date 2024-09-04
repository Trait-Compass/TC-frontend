// coursefeedback.dart
import 'package:flutter/material.dart';

class TravelDetailAnalysisSection extends StatefulWidget {
  @override
  _TravelDetailAnalysisSectionState createState() =>
      _TravelDetailAnalysisSectionState();
}

class _TravelDetailAnalysisSectionState
    extends State<TravelDetailAnalysisSection> {
  bool isEditingSatisfied = false; // '만족한 점' 텍스트를 편집 모드로 전환
  bool isEditingMaintain = false; // '유지할 점' 텍스트를 편집 모드로 전환

  TextEditingController satisfiedController = TextEditingController();
  TextEditingController maintainController = TextEditingController();

  // 저장된 텍스트를 관리하기 위한 변수
  String? satisfiedText; // 사용자 입력 텍스트 저장
  String? maintainText; // 사용자 입력 텍스트 저장

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '여행 상세분석',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            height: 180, // 전체 높이를 약간 늘림
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black), // 위쪽 변만 테두리
                bottom: BorderSide(color: Colors.black), // 아래쪽 변만 테두리
                left: BorderSide.none, // 왼쪽 변은 없음
                right: BorderSide.none, // 오른쪽 변은 없음
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '만족한 점',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity, // 너비 설정
                            height: 90, // 높이 설정
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // 회색 박스 색상 설정
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SingleChildScrollView(
                              // 스크롤 가능하도록 변경
                              child: isEditingSatisfied // 편집 모드 확인
                                  ? TextField(
                                      controller: satisfiedController,
                                      style: TextStyle(
                                          fontSize: 12), // 입력 텍스트의 폰트 크기 설정
                                      maxLines: null, // 줄 수 제한 없음
                                      decoration: InputDecoration(
                                        isCollapsed: true, // 텍스트 필드의 내부 패딩 제거
                                        border: InputBorder.none, // 테두리 제거
                                      ),
                                    )
                                  : Text(
                                      satisfiedText ??
                                          'ex) 액티비티 활동을 많이 즐김', // 저장된 텍스트를 표시 또는 기본 텍스트
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: satisfiedText != null
                                              ? Color(0xFF41424C)
                                              : Colors.grey),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 5, // 하단에서 5만큼 위에 위치
                        left: 0, // 좌측 정렬
                        right: 0, // 우측 정렬
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isEditingSatisfied) {
                                  // 완료 버튼 클릭 시
                                  if (satisfiedController.text.isNotEmpty) {
                                    satisfiedText =
                                        satisfiedController.text; // 입력된 텍스트를 저장
                                    isEditingSatisfied = false; // 편집 모드 종료
                                  }
                                } else {
                                  // 작성하기 버튼 클릭 시
                                  satisfiedController.text =
                                      satisfiedText ?? ''; // 기존 텍스트를 텍스트필드에 설정
                                  isEditingSatisfied = true; // 편집 모드 시작
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 3,
                              minimumSize: Size(60, 30), // 버튼의 최소 크기 설정
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16), // 버튼 패딩 설정
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              satisfiedText == null
                                  ? '작성하기'
                                  : (isEditingSatisfied ? '완료' : '수정하기'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '유지할 점',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity, // 너비 설정
                            height: 90, // 높이 설정
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // 회색 박스 색상 설정
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SingleChildScrollView(
                              // 스크롤 가능하도록 변경
                              child: isEditingMaintain // 편집 모드 확인
                                  ? TextField(
                                      controller: maintainController,
                                      style: TextStyle(
                                          fontSize: 12), // 입력 텍스트의 폰트 크기 설정
                                      maxLines: null, // 줄 수 제한 없음
                                      decoration: InputDecoration(
                                        isCollapsed: true, // 텍스트 필드의 내부 패딩 제거
                                        border: InputBorder.none, // 테두리 제거
                                      ),
                                    )
                                  : Text(
                                      maintainText ??
                                          'ex) 활동적 • 여행지 많이 다니기', // 저장된 텍스트를 표시 또는 기본 텍스트
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: maintainText != null
                                              ? Color(0xFF41424C)
                                              : Colors.grey),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 5, // 하단에서 5만큼 위에 위치
                        left: 0, // 좌측 정렬
                        right: 0, // 우측 정렬
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isEditingMaintain) {
                                  // 완료 버튼 클릭 시
                                  if (maintainController.text.isNotEmpty) {
                                    maintainText =
                                        maintainController.text; // 입력된 텍스트를 저장
                                    isEditingMaintain = false; // 편집 모드 종료
                                  }
                                } else {
                                  // 작성하기 버튼 클릭 시
                                  maintainController.text =
                                      maintainText ?? ''; // 기존 텍스트를 텍스트필드에 설정
                                  isEditingMaintain = true; // 편집 모드 시작
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 3,
                              minimumSize: Size(60, 30), // 버튼의 최소 크기 설정
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16), // 버튼 패딩 설정
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              maintainText == null
                                  ? '작성하기'
                                  : (isEditingMaintain ? '완료' : '수정하기'),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
