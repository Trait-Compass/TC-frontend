import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '나의 프로필',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFFEDEDED),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Container(
                  height: 110,
                  width: 70,
                  child: Image.asset(
                    'assets/istj.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 55,
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              "ENFP",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFD07C58),
                              borderRadius: BorderRadius.circular(12.5),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              "텐션 높은 인싸 여행자",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD07C58)),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 49,
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              "닉네임",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 70,
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "같이 여행가면 재밌는 타입",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "구체적인 계획은 잘 안짜는 타입",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFD07C58).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                            ),
                          ),
                          SizedBox(width: 15), // 오른쪽 여백을 15로 설정
                          Expanded(
                            child: Container(
                              height: 70,
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "❤️ 찰떡궁합 ",
                                        style: GoogleFonts.notoColorEmoji(
                                          textStyle: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "INFJ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "😅 환장궁합 ",
                                        style: GoogleFonts.notoColorEmoji(
                                          textStyle: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "ISTJ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFD07C58).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15), // Right margin for the last box
              ],
            ),
          ),
        ],
      ),
    );
  }
}
