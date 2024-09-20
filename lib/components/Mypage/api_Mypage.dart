import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final String baseUrl = 'https://www.traitcompass.store';
  static String? _accessToken;

  static void setAccessToken(String token) {
    _accessToken = token;
  }

  static Map<String, String> _createHeaders() {
    final headers = {
      'Content-Type': 'multipart/form-data',
    };
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken'; // 토큰 추가
    }
    return headers;
  }

  static Future<void> sendTravelDiary({
    required String courseName,
    required String nature,
    required String travelDate,
    required int foodSatisfaction,
    required String satisfiedEmotions,
    required String keepFeedback,
    required String disappointedEmotions,
    required String sadEmotions,
    required String finalThoughts,
    required String satisfactionFeedback,
    required String surprisedEmotions,
    required int priceSatisfaction,
    required int transportationSatisfaction,
    required int sightseeingSatisfaction,
    required String happyEmotions,
    required String angryEmotions,
    required String travelPhotos, // 여행 사진 (실제 이미지 파일이라면 file 처리 필요)
    required String improvementFeedback,
    required String positiveFeedback,
    required int accommodationSatisfaction,
    required String comfortableEmotions,
    required int environmentSatisfaction,
  }) async {
    var uri = Uri.parse('$baseUrl/diary');

    var headers = _createHeaders();

    var request = http.MultipartRequest('POST', uri)
      ..fields['courseName'] = courseName
      ..fields['nature'] = nature
      ..fields['travelDate'] = travelDate
      ..fields['foodSatisfaction'] = foodSatisfaction.toString()
      ..fields['satisfiedEmotions'] = satisfiedEmotions
      ..fields['keepFeedback'] = keepFeedback
      ..fields['disappointedEmotions'] = disappointedEmotions
      ..fields['sadEmotions'] = sadEmotions
      ..fields['finalThoughts'] = finalThoughts
      ..fields['satisfactionFeedback'] = satisfactionFeedback
      ..fields['surprisedEmotions'] = surprisedEmotions
      ..fields['priceSatisfaction'] = priceSatisfaction.toString()
      ..fields['transportationSatisfaction'] =
          transportationSatisfaction.toString()
      ..fields['sightseeingSatisfaction'] = sightseeingSatisfaction.toString()
      ..fields['happyEmotions'] = happyEmotions
      ..fields['angryEmotions'] = angryEmotions
      ..fields['travelPhotos'] = travelPhotos
      ..fields['improvementFeedback'] = improvementFeedback
      ..fields['positiveFeedback'] = positiveFeedback
      ..fields['accommodationSatisfaction'] =
          accommodationSatisfaction.toString()
      ..fields['comfortableEmotions'] = comfortableEmotions
      ..fields['environmentSatisfaction'] = environmentSatisfaction.toString();

    // 헤더 추가
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      print('성공적으로 업로드되었습니다!');
    } else {
      print('업로드 실패: ${response.statusCode}');
    }
  }
}
