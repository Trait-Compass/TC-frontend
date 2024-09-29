// lib/models/travel_diary.dart

import 'dart:typed_data';

class TravelDiaryT {
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

  TravelDiaryT({
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

  // Map<String, dynamic>으로부터 객체 생성
  factory TravelDiaryT.fromMap(Map<String, dynamic> map) {
    return TravelDiaryT(
      courseName: map['courseName'] ?? '',
      travelDate: map['travelDate'] != null
          ? DateTime.parse(map['travelDate'])
          : DateTime.now(),
      nature: map['nature'] ?? 'T',
      travelPhotos: map['imageUrls'] != null
          ? List<String>.from(map['imageUrls'])
          : null,
      transportationSatisfaction: map['transportationSatisfaction'] != null
          ? int.tryParse(map['transportationSatisfaction'].toString())
          : null,
      sightseeingSatisfaction: map['sightseeingSatisfaction'] != null
          ? int.tryParse(map['sightseeingSatisfaction'].toString())
          : null,
      accommodationSatisfaction: map['accommodationSatisfaction'] != null
          ? int.tryParse(map['accommodationSatisfaction'].toString())
          : null,
      priceSatisfaction: map['priceSatisfaction'] != null
          ? int.tryParse(map['priceSatisfaction'].toString())
          : null,
      environmentSatisfaction: map['environmentSatisfaction'] != null
          ? int.tryParse(map['environmentSatisfaction'].toString())
          : null,
      foodSatisfaction: map['foodSatisfaction'] != null
          ? int.tryParse(map['foodSatisfaction'].toString())
          : null,
      satisfactionFeedback: map['satisfactionFeedback'],
      keepFeedback: map['keepFeedback'],
      happyEmotions: map['happyEmotions'] != null
          ? (map['happyEmotions'] as String).split(',')
          : null,
      satisfiedEmotions: map['satisfiedEmotions'] != null
          ? (map['satisfiedEmotions'] as String).split(',')
          : null,
      comfortableEmotions: map['comfortableEmotions'] != null
          ? (map['comfortableEmotions'] as String).split(',')
          : null,
      surprisedEmotions: map['surprisedEmotions'] != null
          ? (map['surprisedEmotions'] as String).split(',')
          : null,
      disappointedEmotions: map['disappointedEmotions'] != null
          ? (map['disappointedEmotions'] as String).split(',')
          : null,
      sadEmotions: map['sadEmotions'] != null
          ? (map['sadEmotions'] as String).split(',')
          : null,
      angryEmotions: map['angryEmotions'] != null
          ? (map['angryEmotions'] as String).split(',')
          : null,
      positiveFeedback: map['positiveFeedback'],
      improvementFeedback: map['improvementFeedback'],
      finalThoughts: map['finalThoughts'],
    );
  }

  // 객체를 Map<String, dynamic>으로 변환
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
      'happyEmotions': happyEmotions?.join(','),
      'satisfiedEmotions': satisfiedEmotions?.join(','),
      'comfortableEmotions': comfortableEmotions?.join(','),
      'surprisedEmotions': surprisedEmotions?.join(','),
      'disappointedEmotions': disappointedEmotions?.join(','),
      'sadEmotions': sadEmotions?.join(','),
      'angryEmotions': angryEmotions?.join(','),
      'positiveFeedback': positiveFeedback,
      'improvementFeedback': improvementFeedback,
      'finalThoughts': finalThoughts,
    };
  }
}