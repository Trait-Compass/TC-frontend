class MBTIData {
  final String type;
  final String description;
  final String mascotImage;
  final String bestMatchType;
  final String bestMatchDescription;
  final String bestMatchImage;
  final String worstMatchType;
  final String worstMatchDescription;
  final String worstMatchImage;
  final List<String> traits;

  MBTIData({
    required this.type,
    required this.description,
    required this.mascotImage,
    required this.bestMatchType,
    required this.bestMatchDescription,
    required this.bestMatchImage,
    required this.worstMatchType,
    required this.worstMatchDescription,
    required this.worstMatchImage,
    required this.traits,
  });
}

final List<MBTIData> mbtiDataList = [
  MBTIData(
    type: 'ISTJ',
    description: '꼼꼼한 계획형 여행자',
    mascotImage: 'assets/istj.png',
    bestMatchType: 'ESFP',
    bestMatchDescription: '파티를 즐기는 여행자',
    bestMatchImage: 'assets/esfp.png',
    worstMatchType: 'ENFP',
    worstMatchDescription: '텐션 높은 인싸 여행자',
    worstMatchImage: 'assets/enfp.png',
    traits: [
      '항상 모든 것을 계획하고 준비하는 타입',
      '시간과 일정에 철저히 따르는 성격',
      '예상치 못한 상황에 스트레스를 받을 수 있음',
      '여행 중 규칙과 질서를 중시',
    ],
  ),
  // 다른 MBTI 데이터 추가...
];
