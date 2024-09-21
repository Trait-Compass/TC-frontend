// lib/pages/emotionalfeedback.dart

import 'package:flutter/material.dart';
import '../Mypage/mypagemodelforF.dart';

class TravelFeelingAnalysisSection extends StatefulWidget {
  final TravelDiaryEmotion diaryEmotion; // 모델 인스턴스 전달

  TravelFeelingAnalysisSection({required this.diaryEmotion});

  @override
  _TravelFeelingAnalysisSectionState createState() =>
      _TravelFeelingAnalysisSectionState();
}

class _TravelFeelingAnalysisSectionState
    extends State<TravelFeelingAnalysisSection> {
  bool isEditingSatisfied = false;
  bool isEditingMaintain = false;
  bool isEditingComment = true; // '나에게 하고 싶은 한 마디'의 초기 편집 상태

  TextEditingController satisfiedController = TextEditingController();
  TextEditingController maintainController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  String? satisfiedText;
  String? maintainText;
  String? commentText;

  // 모델에 데이터 저장
  void _saveToModel() {
    widget.diaryEmotion.positiveFeedback = satisfiedText;
    widget.diaryEmotion.negativeFeedback = maintainText;
    widget.diaryEmotion.finalThoughts = commentText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이번 여행 주요 감정',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            height: 180,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black),
                left: BorderSide.none,
                right: BorderSide.none,
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
                            '긍정 감정 기록',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 90,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SingleChildScrollView(
                              child: isEditingSatisfied
                                  ? TextField(
                                      controller: satisfiedController,
                                      style: TextStyle(fontSize: 12),
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                    )
                                  : (satisfiedText != null &&
                                          satisfiedText!.isNotEmpty)
                                      ? Text(
                                          satisfiedText!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF41424C)),
                                        )
                                      : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 5,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isEditingSatisfied) {
                                  if (satisfiedController.text.isNotEmpty) {
                                    satisfiedText = satisfiedController.text;
                                    isEditingSatisfied = false;
                                  }
                                } else {
                                  satisfiedController.text =
                                      satisfiedText ?? '';
                                  isEditingSatisfied = true;
                                }
                                _saveToModel(); // 모델 업데이트
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 3,
                              minimumSize: Size(60, 30),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              satisfiedText == null || satisfiedText!.isEmpty
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
                            '부정 감정 기록',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 90,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SingleChildScrollView(
                              child: isEditingMaintain
                                  ? TextField(
                                      controller: maintainController,
                                      style: TextStyle(fontSize: 12),
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                    )
                                  : (maintainText != null &&
                                          maintainText!.isNotEmpty)
                                      ? Text(
                                          maintainText!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF41424C)),
                                        )
                                      : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 5,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isEditingMaintain) {
                                  if (maintainController.text.isNotEmpty) {
                                    maintainText = maintainController.text;
                                    isEditingMaintain = false;
                                  }
                                } else {
                                  maintainController.text = maintainText ?? '';
                                  isEditingMaintain = true;
                                }
                                _saveToModel(); // 모델 업데이트
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 3,
                              minimumSize: Size(60, 30),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              maintainText == null || maintainText!.isEmpty
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
          SizedBox(height: 20),
          Text(
            '나에게 하고 싶은 한 마디',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: isEditingComment
                      ? TextField(
                          controller: commentController,
                          style: TextStyle(fontSize: 14),
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8),
                          ),
                        )
                      : (commentText != null && commentText!.isNotEmpty)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                commentText!,
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF41424C)),
                              ),
                            )
                          : SizedBox(),
                ),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isEditingComment) {
                      if (commentController.text.isNotEmpty) {
                        commentText = commentController.text;
                        isEditingComment = false;
                      }
                    } else {
                      commentController.text = commentText ?? '';
                      isEditingComment = true;
                    }
                    _saveToModel(); // 모델 업데이트
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  minimumSize: Size(60, 30),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  textStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  (commentText == null || commentText!.isEmpty)
                      ? '작성하기'
                      : (isEditingComment ? '완료' : '수정하기'),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
