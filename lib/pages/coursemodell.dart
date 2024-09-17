class Course {
  final String id;
  final String region;
  final String courseName;
  final String duration;
  final List<Day> day1;
  final List<Day> day2;
  final List<Day> day3;

  Course({
    required this.id,
    required this.region,
    required this.courseName,
    required this.duration,
    required this.day1,
    required this.day2,
    required this.day3,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'] as String,
      region: json['region'] as String,
      courseName: json['courseName'] as String,
      duration: json['duration'] as String,
      day1: json['day1'] != null && json['day1'] is List
          ? (json['day1'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
      day2: json['day2'] != null && json['day2'] is List
          ? (json['day2'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
      day3: json['day3'] != null && json['day3'] is List
          ? (json['day3'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
    );
  }
}

class Day {
  final List<String> keywords;
  final String name;
  final int id;
  final String imageUrl;
  final TravelInfo? travelInfoToNext; // 수정된 부분: travelInfoToNext 객체

  Day({
    required this.keywords,
    required this.name,
    required this.id,
    required this.imageUrl,
    this.travelInfoToNext,
  });

  // JSON 데이터를 받아서 Day 객체로 변환하는 팩토리 생성자
  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      keywords: json['keywords'] != null && json['keywords'] is List
          ? List<String>.from(json['keywords'])
          : [],
      name: json['name'] as String,
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      travelInfoToNext: json['travelInfoToNext'] != null
          ? TravelInfo.fromJson(json['travelInfoToNext'])
          : null,
    );
  }

  // Day 객체를 Map<String, dynamic> 형식으로 변환하는 메서드 추가
  Map<String, dynamic> toMap() {
    return {
      'keywords': keywords,
      'name': name,
      'id': id,
      'imageUrl': imageUrl,
      'travelInfoToNext': travelInfoToNext?.toMap(), // 수정된 부분
    };
  }
}

class TravelInfo {
  final String carTime; // 자동차 이동 시간
  final String walkingTime; // 도보 이동 시간

  TravelInfo({
    required this.carTime,
    required this.walkingTime,
  });

  // JSON 데이터를 받아서 TravelInfo 객체로 변환하는 팩토리 생성자
  factory TravelInfo.fromJson(Map<String, dynamic> json) {
    return TravelInfo(
      carTime: json['carTime'] as String,
      walkingTime: json['walkingTime'] as String,
    );
  }

  // TravelInfo 객체를 Map<String, dynamic> 형식으로 변환하는 메서드 추가
  Map<String, dynamic> toMap() {
    return {
      'carTime': carTime,
      'walkingTime': walkingTime,
    };
  }
}
