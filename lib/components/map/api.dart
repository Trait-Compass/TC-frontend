import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final String baseUrl = 'https://www.traitcompass.store';
  static String? _accessToken;

  static void setAccessToken(String token) {
    _accessToken = token;
    print('Access token set: $_accessToken');
  }

  static Map<String, String> _createHeaders() {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
      print('Authorization header set: Bearer $_accessToken');
    }
    return headers;
  }

  static void _logRequest(
      String method, String url, Map<String, String> headers,
      [Map<String, dynamic>? body]) {
    print('--- $method Request ---');
    print('URL: $url');
    print('Headers: $headers');
    if (body != null) {
      print('Body: ${jsonEncode(body)}');
    }
    print('-----------------------');
  }

  static Future<http.Response> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    String path = endpoint.startsWith('/') ? endpoint : '/$endpoint';

    String queryString = '';
    if (params != null) {
      List<String> queryParts = [];

      params.forEach((key, value) {
        if (value is List) {
          for (var item in value) {
            queryParts.add(
                '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(item.toString())}');
          }
        } else {
          queryParts.add(
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}');
        }
      });

      queryString = queryParts.join('&');
    }

    Uri uri = Uri.parse(
        '$baseUrl$path${queryString.isNotEmpty ? '?$queryString' : ''}');

    final headers = _createHeaders();

    // 요청 로그 출력
    _logRequest('GET', uri.toString(), headers);

    final response = await http.get(uri, headers: headers);

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }
  
  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    String path = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    Uri uri = Uri.parse('$baseUrl$path');

    final headers = _createHeaders();

    _logRequest('POST', uri.toString(), headers, body);

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

 static Future<void> saveUserMBTI(String mbti) async {
  // 쿼리 파라미터로 'mbti'를 포함하여 URI 생성
  final uri = Uri.parse('$baseUrl/user/mbti').replace(queryParameters: {
    'mbti': mbti,
  });

  // PATCH 요청 보내기
  final response = await http.patch(
    uri,
    headers: _createHeaders(),
  );

  // 요청 결과 처리
  if (response.statusCode == 200) {
    print('MBTI 저장 성공');
  } else {
    throw Exception(
        'MBTI 저장 실패: 상태 코드 ${response.statusCode}, 이유: ${response.reasonPhrase}');
  }
}


  // P형 여행 일정 API 호출 (static)
static Future<Map<String, dynamic>> fetchCourseForP({
  required String mbti,
  required String startDate,
  required String endDate,
  required String location,
  required String companion,
}) async {
  final response = await get('/course/p', params: {
    'mbti': mbti,
    'startDate': startDate,
    'endDate': endDate,
    'location': location,
    'companion': companion,
  });

  if (response.statusCode == 200) {
    try {
      final data = json.decode(response.body);

      final course = data['result'];
      final region = course['region'];
      final courseName = course['courseName'];
      final duration = course['duration'];
      final day1 = course['day1'];
      final day2 = course['day2'];
      final day3 = course['day3'];

     
      List<int> contentIds = [];
      for (var item in day1) {
        contentIds.add(item['contentId']);
      }
      for (var item in day2) {
        contentIds.add(item['contentId']);
      }
      for (var item in day3) {
        contentIds.add(item['contentId']);
      }

      print('추출된 contentId 값들: $contentIds');
      print('지역: $region, 코스 이름: $courseName, 기간: $duration');

      // POST 요청으로 모든 정보를 서버에 저장하기
      await saveCourseToServer(region, courseName, duration, contentIds);

      return data;
    } catch (e) {
      throw Exception('실패: $e');
    }
  } else {
    throw Exception('실패: ${response.statusCode}, Reason: ${response.reasonPhrase}');
  }
}

// POST 요청으로 course 정보와 contentId 값 저장하는 함수
static Future<void> saveCourseToServer(
  String region,
  String courseName,
  String duration,
  List<int> contentIds,
) async {
  final url = Uri.parse('$baseUrl/course/p');
  try {
    // POST 요청 보내기
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $_accessToken'},
      body: jsonEncode({
        'region': region,             
        'courseName': courseName,      
        'duration': duration,          
        'day1': contentIds.map((id) => {'contentId': id}).toList(),
        'day2': contentIds.map((id) => {'contentId': id}).toList(),
        'day3': contentIds.map((id) => {'contentId': id}).toList(),
      }),
    );

    // 응답 상태 확인
    if (response.statusCode == 201) {
      print('코스 정보와 contentId 값들이 성공적으로 저장되었습니다!');
    } else {
      print('코스 정보 저장 실패. 상태 코드: ${response.statusCode}');
    }
  } catch (e) {
    print('코스 정보 저장 중 오류 발생: $e');
  }
}

      throw Exception(
          '실패: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }


  // J형 여행 일정 API 호출 (static)
  static Future<Map<String, dynamic>> fetchCourseForJ({
    required String mbti,
    required String startDate,
    required String endDate,
    required String location,
    required String companion,
    required List<String> keyword,
  }) async {
    final response = await get('/course/j', params: {
      'mbti': mbti,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'companion': companion,
      'keyword': keyword,
    });

    if (response.statusCode == 200) {
      try {
        return json.decode(response.body);
      } catch (e) {
        throw Exception('Failed to parse J course data. Error: $e');
      }
    } else {
      throw Exception(
          'Failed to load J course. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // 사용자 프로필 API 호출 (static)
  static Future<Map<String, dynamic>> fetchUserProfile() async {
    final response = await get('/user/profile');

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['result'] is Map<String, dynamic>) {
          return data['result']; // 'result' 데이터 반환
        } else {
          throw Exception('Unexpected data format: result is not a Map');
        }
      } catch (e) {
        throw Exception('Failed to parse user profile data. Error: $e');
      }
    } else {
      throw Exception(
          'Failed to load user profile. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // 추천 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchRecommendedSpots(
      String location) async {
    final response =
        await get('/spot/recommand', params: {'location': location});

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['result'] is List) {
          List<dynamic> resultList = data['result'];
          return resultList.map((e) => e as Map<String, dynamic>).toList();
        } else {
          throw Exception('Unexpected data format: result is not a list');
        }
      } catch (e) {
        throw Exception('Failed to parse recommended spots. Error: $e');
      }
    } else {
      throw Exception(
          'Failed to load recommended spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // 인기 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchPopularSpots(
      String location) async {
    final response = await get('/spot/popular', params: {'location': location});

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['result'] is List) {
          List<dynamic> resultList = data['result'];
          return resultList.map((e) => e as Map<String, dynamic>).toList();
        } else {
          throw Exception('Unexpected data format: result is not a list');
        }
      } catch (e) {
        throw Exception('Failed to parse popular spots. Error: $e');
      }
    } else {
      throw Exception(
          'Failed to load popular spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // MBTI 여행지 API 호출 (static)
  static Future<Map<String, dynamic>> fetchMbtiSpots() async {
    final response = await get('/spot/mbti');

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = json.decode(response.body); // 최상위 Map으로 파싱
        if (data['result'] != null && data['result']['tourList'] is List) {
          List<dynamic> tourList =
              data['result']['tourList']; // 'result'에서 'tourList' 가져오기
          String mbti = data['result']['mbti']; // 'mbti' 값 가져오기
          return {
            'mbti': mbti,
            'tourList': tourList.map((e) => e as Map<String, dynamic>).toList(),
          };
        } else {
          throw Exception(
              'Unexpected data format: result or tourList is not valid');
        }
      } catch (e) {
        throw Exception('Failed to parse MBTI spots. Error: $e');
      }
    } else {
      throw Exception(
          'Failed to load MBTI spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }
}


