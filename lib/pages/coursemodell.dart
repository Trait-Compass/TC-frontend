// course_model.dart

class Course {
  final String id;
  final String region;
  final String courseName;
  final String duration;
  final List<Day> day1;
  final List<Day> day2;

  Course({
    required this.id,
    required this.region,
    required this.courseName,
    required this.duration,
    required this.day1,
    required this.day2,
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
    );
  }
}

class Day {
  final List<String> keywords;
  final String name;
  final int id;
  final String imageUrl;

  Day({
    required this.keywords,
    required this.name,
    required this.id,
    required this.imageUrl,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      keywords: json['keywords'] != null && json['keywords'] is List
          ? List<String>.from(json['keywords'])
          : [],
      name: json['name'] as String,
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
