// lib/models/travel_diary.dart

import 'dart:typed_data';

class TravelDiary {
  // 필수 필드
  String courseName;
  DateTime travelDate;
  String nature;

  // 선택적 필드
  List<String>? travelPhotos; // 이미지 경로 또는 URL
  List<Uint8List>? webImages; // 웹에서 사용하는 이미지 데이터
  int? transportationSatisfaction;
  int? sightseeingSatisfaction;
  int? accommodationSatisfaction;
  int? priceSatisfaction;
  int? environmentSatisfaction;
  int? foodSatisfaction;
  String? satisfactionFeedback;
  String? keepFeedback;
  List<String>? happyEmotions;
  List<String>? satisfiedEmotions;
  List<String>? comfortableEmotions;
  List<String>? surprisedEmotions;
  List<String>? disappointedEmotions;
  List<String>? sadEmotions;
  List<String>? angryEmotions;
  String? positiveFeedback;
  String? improvementFeedback;
  String? finalThoughts;

  TravelDiary({
    required this.courseName,
    required this.travelDate,
    required this.nature,
    this.travelPhotos,
    this.webImages,
    this.transportationSatisfaction,
    this.sightseeingSatisfaction,
    this.accommodationSatisfaction,
    this.priceSatisfaction,
    this.environmentSatisfaction,
    this.foodSatisfaction,
    this.satisfactionFeedback,
    this.keepFeedback,
    this.happyEmotions,
    this.satisfiedEmotions,
    this.comfortableEmotions,
    this.surprisedEmotions,
    this.disappointedEmotions,
    this.sadEmotions,
    this.angryEmotions,
    this.positiveFeedback,
    this.improvementFeedback,
    this.finalThoughts,
  });

  // JSON으로부터 객체 생성
  factory TravelDiary.fromJson(Map<String, dynamic> json) {
    return TravelDiary(
      courseName: json['courseName'],
      travelDate: DateTime.parse(json['travelDate']),
      nature: json['nature'],
      travelPhotos: json['travelPhotos'] != null
          ? List<String>.from(json['travelPhotos'])
          : null,
      webImages: json['webImages'] != null
          ? List<Uint8List>.from(json['webImages']
              .map((x) => Uint8List.fromList(List<int>.from(x))))
          : null,
      transportationSatisfaction: json['transportationSatisfaction'],
      sightseeingSatisfaction: json['sightseeingSatisfaction'],
      accommodationSatisfaction: json['accommodationSatisfaction'],
      priceSatisfaction: json['priceSatisfaction'],
      environmentSatisfaction: json['environmentSatisfaction'],
      foodSatisfaction: json['foodSatisfaction'],
      satisfactionFeedback: json['satisfactionFeedback'],
      keepFeedback: json['keepFeedback'],
      happyEmotions: json['happyEmotions'] != null
          ? List<String>.from(json['happyEmotions'])
          : null,
      satisfiedEmotions: json['satisfiedEmotions'] != null
          ? List<String>.from(json['satisfiedEmotions'])
          : null,
      comfortableEmotions: json['comfortableEmotions'] != null
          ? List<String>.from(json['comfortableEmotions'])
          : null,
      surprisedEmotions: json['surprisedEmotions'] != null
          ? List<String>.from(json['surprisedEmotions'])
          : null,
      disappointedEmotions: json['disappointedEmotions'] != null
          ? List<String>.from(json['disappointedEmotions'])
          : null,
      sadEmotions: json['sadEmotions'] != null
          ? List<String>.from(json['sadEmotions'])
          : null,
      angryEmotions: json['angryEmotions'] != null
          ? List<String>.from(json['angryEmotions'])
          : null,
      positiveFeedback: json['positiveFeedback'],
      improvementFeedback: json['improvementFeedback'],
      finalThoughts: json['finalThoughts'],
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'travelDate': travelDate.toIso8601String(),
      'nature': nature,
      'travelPhotos': travelPhotos,
      'webImages': webImages?.map((x) => x.toList()).toList(),
      'transportationSatisfaction': transportationSatisfaction,
      'sightseeingSatisfaction': sightseeingSatisfaction,
      'accommodationSatisfaction': accommodationSatisfaction,
      'priceSatisfaction': priceSatisfaction,
      'environmentSatisfaction': environmentSatisfaction,
      'foodSatisfaction': foodSatisfaction,
      'satisfactionFeedback': satisfactionFeedback,
      'keepFeedback': keepFeedback,
      'happyEmotions': happyEmotions,
      'satisfiedEmotions': satisfiedEmotions,
      'comfortableEmotions': comfortableEmotions,
      'surprisedEmotions': surprisedEmotions,
      'disappointedEmotions': disappointedEmotions,
      'sadEmotions': sadEmotions,
      'angryEmotions': angryEmotions,
      'positiveFeedback': positiveFeedback,
      'improvementFeedback': improvementFeedback,
      'finalThoughts': finalThoughts,
    };
  }
}
