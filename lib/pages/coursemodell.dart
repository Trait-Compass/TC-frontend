// coursemodell.dart
class Course {
  final String id;
  final String region;
  final String courseName;
  final String duration;
  final List<Day> day1;
  final List<Day> day2;
  final List<Day> day3;
  final List<Day> day4; 
  final List<Day> day5; 

  Course({
    required this.id,
    required this.region,
    required this.courseName,
    required this.duration,
    required this.day1,
    required this.day2,
    required this.day3,
    required this.day4, 
    required this.day5, 
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
      day4: json['day4'] != null && json['day4'] is List
          ? (json['day4'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
      day5: json['day5'] != null && json['day5'] is List
          ? (json['day5'] as List).map((item) => Day.fromJson(item)).toList()
          : [],
    );
  }
}

class Day {
  final List<String> keywords;
  final String name;
  final int id;
  final String imageUrl;
  final TravelInfo? travelInfoToNext;

  Day({
    required this.keywords,
    required this.name,
    required this.id,
    required this.imageUrl,
    this.travelInfoToNext,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'keywords': keywords,
      'name': name,
      'id': id,
      'imageUrl': imageUrl,
      'travelInfoToNext': travelInfoToNext?.toMap(),
    };
  }
}

class TravelInfo {
  final String carTime;
  final String walkingTime;

  TravelInfo({
    required this.carTime,
    required this.walkingTime,
  });

  factory TravelInfo.fromJson(Map<String, dynamic> json) {
    return TravelInfo(
      carTime: json['carTime'] as String,
      walkingTime: json['walkingTime'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carTime': carTime,
      'walkingTime': walkingTime,
    };
  }
}