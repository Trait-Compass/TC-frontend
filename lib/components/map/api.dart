import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final String baseUrl = 'https://www.traitcompass.store';
  static String? _accessToken; 

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

  // POST 요청 메서드 (static)
  static Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();

    // 로그 출력
    _logRequest('POST', url.toString(), headers, body);

    final response = await http.post(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  // PUT 요청 메서드 (static)
  static Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();

    // 로그 출력
    _logRequest('PUT', url.toString(), headers, body);

    final response = await http.put(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  // DELETE 요청 메서드 (static)
  static Future<http.Response> delete(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();

    // 로그 출력
    _logRequest('DELETE', url.toString(), headers, body);

    final response = await http.delete(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  // 추천 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchRecommendedSpots(String location) async {
    final response = await get('/spot/recommand', params: {'location': location});

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      // 구체적인 오류 메시지 출력
      throw Exception('Failed to load recommended spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // 인기 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchPopularSpots(String location) async {
    final response = await get('/spot/popular',params: {'location': location});

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      // 구체적인 오류 메시지 출력
      throw Exception('Failed to load popular spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }

  // MBTI 여행지 API 호출 (static)
  static Future<List<Map<String, dynamic>>> fetchMbtiSpots() async {
    final response = await get('/spot/mbti');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      // 구체적인 오류 메시지 출력
      throw Exception('Failed to load MBTI spots. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}');
    }
  }
}
