// lib/models/mypagemodelforF.dart

class TravelDiaryEmotion {
  // 필수 필드
  String courseName;
  DateTime travelDate;
  List<String>? travelPhotos; // 이미지 경로 또는 URL

  // 감정 데이터
  List<String>? happyEmotions;
  List<String>? satisfiedEmotions;
  List<String>? comfortableEmotions;
  List<String>? surprisedEmotions;
  List<String>? disappointedEmotions;
  List<String>? sadEmotions;
  List<String>? angryEmotions;

  // 피드백 텍스트
  String? positiveFeedback; // '긍정 감정 기록'
  String? negativeFeedback; // '부정 감정 기록'
  String? finalThoughts; // '나에게 하고 싶은 한 마디'

  TravelDiaryEmotion({
    required this.courseName,
    required this.travelDate,
    this.travelPhotos,
    this.happyEmotions,
    this.satisfiedEmotions,
    this.comfortableEmotions,
    this.surprisedEmotions,
    this.disappointedEmotions,
    this.sadEmotions,
    this.angryEmotions,
    this.positiveFeedback,
    this.negativeFeedback,
    this.finalThoughts,
  });

  // JSON으로부터 객체 생성
  factory TravelDiaryEmotion.fromJson(Map<String, dynamic> json) {
    return TravelDiaryEmotion(
      courseName: json['courseName'],
      travelDate: DateTime.parse(json['travelDate']),
      travelPhotos: json['travelPhotos'] != null
          ? List<String>.from(json['travelPhotos'])
          : null,
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
      negativeFeedback: json['negativeFeedback'],
      finalThoughts: json['finalThoughts'],
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'travelDate': travelDate.toIso8601String(),
      'travelPhotos': travelPhotos,
      'happyEmotions': happyEmotions,
      'satisfiedEmotions': satisfiedEmotions,
      'comfortableEmotions': comfortableEmotions,
      'surprisedEmotions': surprisedEmotions,
      'disappointedEmotions': disappointedEmotions,
      'sadEmotions': sadEmotions,
      'angryEmotions': angryEmotions,
      'positiveFeedback': positiveFeedback,
      'negativeFeedback': negativeFeedback,
      'finalThoughts': finalThoughts,
    };
  }
}
