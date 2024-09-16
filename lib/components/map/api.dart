import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final String baseUrl = 'https://www.traitcompass.store';
  static String? _accessToken; // AccessToken을 스태틱으로 변경

  // AccessToken 설정 메서드 (static)
  static void setAccessToken(String token) {
    _accessToken = token;
    print('Access token set: $_accessToken'); // 토큰 설정 로그 추가
  }

  // 공통 헤더 생성 메서드 (static)
  static Map<String, String> _createHeaders() {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
      print('Authorization header set: Bearer $_accessToken'); // Authorization 헤더 설정 로그 추가
    }
    return headers;
  }

  // 요청 로그 출력 메서드 (static)
  static void _logRequest(String method, String url, Map<String, String> headers, [Map<String, dynamic>? body]) {
    print('--- $method Request ---');
    print('URL: $url');
    print('Headers: $headers');
    if (body != null) {
      print('Body: ${jsonEncode(body)}');
    }
    print('-----------------------');
  }

  // GET 요청 메서드 (static)
  static Future<http.Response> get(String endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
    final headers = _createHeaders();

    // 로그 출력
    _logRequest('GET', uri.toString(), headers);

    final response = await http.get(uri, headers: headers);
    
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
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
      throw Exception('Failed to load user profile. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // 추천 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchRecommendedSpots(String location) async {
    final response = await get('/spot/recommand', params: {'location': location});

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
      throw Exception('Failed to load recommended spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // 인기 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchPopularSpots(String location) async {
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
      throw Exception('Failed to load popular spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // MBTI 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchMbtiSpots() async {
    final response = await get('/spot/mbti');

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = json.decode(response.body); // 최상위 Map으로 파싱
        if (data['result'] != null && data['result']['tourList'] is List) {
          List<dynamic> tourList = data['result']['tourList']; // 'result'에서 'tourList' 가져오기
          return tourList.map((e) => e as Map<String, dynamic>).toList();
        } else {
          throw Exception('Unexpected data format: result or tourList is not valid');
        }
      } catch (e) {
        throw Exception('Failed to parse MBTI spots. Error: $e');
      }
    } else {
      throw Exception('Failed to load MBTI spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }
}
