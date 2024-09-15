// lib/services/api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal();

  final String baseUrl = 'https://traitcompass.store';
  String? _accessToken;

  // AccessToken 설정 메서드
  void setAccessToken(String token) {
    _accessToken = token;
  }

  // 공통 헤더 생성 메서드
  Map<String, String> _createHeaders() {
    return {
      'Content-Type': 'application/json',
      if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
    };
  }

  // GET 요청 메서드
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();
    return await http.get(url, headers: headers);
  }

  // POST 요청 메서드
  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();
    return await http.post(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // PUT 요청 메서드
  Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();
    return await http.put(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // DELETE 요청 메서드
  Future<http.Response> delete(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = _createHeaders();
    return await http.delete(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // 추천 여행지 API 호출
  Future<List<Map<String, dynamic>>> fetchRecommendedSpots(String location) async {
    final response = await get('/spot/recommand');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load recommended spots');
    }
  }

  // 인기 여행지 API 호출
  Future<List<Map<String, dynamic>>> fetchPopularSpots(String location) async {
    final response = await get('/spot/popular');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load popular spots');
    }
  }

  // MBTI 여행지 API 호출
  Future<List<Map<String, dynamic>>> fetchMbtiSpots() async {
    final response = await get('/spot/mbti');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load MBTI spots');
    }
  }
}
