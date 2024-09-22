import 'package:flutter/material.dart';
import '../login/creataccount.dart';

class TermsAndConditionsPage1 extends StatefulWidget {
  @override
  _TermsAndConditionsPage1State createState() =>
      _TermsAndConditionsPage1State();
}

class _TermsAndConditionsPage1State extends State<TermsAndConditionsPage1> {
  bool _isPressed = false;
  Color _buttonColor = Colors.grey[200]!;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40), 
                  Text(
                    '서비스 이용약관',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.03,
                    ),
                    textAlign: TextAlign.center, 
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    '제 1장 총칙',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15, 
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '제 1조 (목적)\n'
                    '이 약관은 “TraitCompass”(이하 “회사”라 합니다)가 제공하는 “MBTrIp”를 회사와 이용계약을 체결한 '
                    '‘고객’이 이용함에 있어 필요한 회사와 고객의 권리 및 의무, 기타 제반 사항을 정함을 목적으로 합니다.',
                    style: TextStyle(fontSize: 10), 
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 2조 (약관 외 준칙)\n'
                    '이 약관에 명시되지 않은 사항에 대해서는 위치 정보의 보호 및 이용 등에 관한 법률, 전기통신사업법, '
                    '정보통신망 이용 촉진 및 보호 등에 관한 법률 등 관계법령 및 회사가 정한 서비스의 세부이용지침 등의 규정에 따릅니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 2장 서비스의 이용',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15, 
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '제 3조 (가입자격)\n'
                    '① 서비스에 가입할 수 있는 자는 Application 이 설치가능한 모든 사람 입니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 4조 (서비스 가입)\n'
                    '① “Application 관리자”가 정한 본 약관에 고객이 동의하면 서비스 가입의 효력이 발생합니다.\n'
                    '②“Application 관리자”는 다음 각 호의 고객 가입신청에 대해서는 이를 승낙하지 아니할 수 있습니다.\n'
                    '1. 고객 등록 사항을 누락하거나 오기하여 신청하는 경우\n'
                    '2. 공공질서 또는 미풍양속을 저해하거나 저해할 목적으로 신청한 경우\n'
                    '3. 기타 회사가 정한 이용신청 요건이 충족되지 않았을 경우',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 5조 (서비스의 탈퇴)\n'
                    '서비스 탈퇴를 희망하는 고객은 “Application 담당자”가 정한 소정의 절차를 통해 서비스 해지를 신청할 수 있습니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 6조 (서비스의 수준)\n'
                    '① 서비스의 이용은 연중무휴 1일 24시간을 원칙으로 합니다. 단, 회사의 업무상이나 기술상의 이유로 서비스가 일시 중지될 수 '
                    '있으며, 운영상의 목적으로 회사가 정한 기간에는 서비스가 일시 중지될 수 있습니다. 이 경우 회사는 사전/사후에 공지합니다.\n'
                    '② 위치정보는 관련 기술의 발전에 따라 오차가 발생할 수 있습니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 7조 (서비스 이용의 제한 및 정지)\n'
                    '회사는 고객이 다음 각 호에 해당하는 경우 사전 통지 없이 고객의 서비스 이용을 제한/정지하거나 직권 해지를 할 수 있습니다.\n'
                    '1. 타인의 서비스 이용을 방해하거나 타인의 개인정보를 도용한 경우\n'
                    '2. 서비스를 이용하여 법령, 공공질서, 미풍양속 등에 반하는 행위를 한 경우',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 20조 (양도금지)\n'
                    '고객 및 회사는 고객의 서비스 가입에 따른 본 약관상의 지위 또는 권리,의무의 전부 또는 일부를 제3자에게 양도, 위임하거나 '
                    '담보제공 등의 목적으로 처분할 수 없습니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 21조 (손해배상)\n'
                    '① 고객의 고의나 과실에 의해 이 약관의 규정을 위반함으로 인하여 회사에 손해가 발생하게 되는 경우, '
                    '이 약관을 위반한 고객은 회사에 발생하는 모든 손해를 배상하여야 합니다.\n'
                    '② 고객이 서비스를 이용함에 있어 행한 불법행위나 고객의 고의나 과실에 의해 이 약관 위반행위로 인하여 '
                    '회사가 당해 고객 이외의 제3자로부터 손해배상청구 또는 소송을 비롯한 각종 이의제기를 받는 경우 '
                    '당해 고객은 그로 인하여 회사에 발생한 손해를 배상하여야 합니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 22조 (면책사항)\n'
                    '① 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 '
                    '서비스 제공에 관한 책임이 면제됩니다.\n'
                    '② 회사는 고객의 귀책사유로 인한 서비스의 이용장애에 대하여 책임을 지지 않습니다.\n'
                    '③ 회사는 고객이 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며, '
                    '그 밖에 서비스를 통하여 얻은 자료로 인한 손해 등에 대하여도 책임을 지지 않습니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '제 23조 (분쟁의 해결 및 관할법원)\n'
                    '① 서비스 이용과 관련하여 회사와 고객 사이에 분쟁이 발생한 경우, 회사와 고객은 분쟁의 해결을 위해 성실히 협의합니다.\n'
                    '② 제1항의 협의에서도 분쟁이 해결되지 않을 경우 양 당사자는 정보통신망 이용촉진 및 정보보호 등에 관한 '
                    '법률 제33조의 규정에 의한 개인정보분쟁조정위원회에 분쟁조정을 신청할 수 있습니다.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '앱 실행에서 사용되는 권한\n'
                    '모바일 앱 실행을 위해서 선택적으로 위치, 저장, 카메라, 파일 및 미디어 권한이 필요합니다.\n\n'
                    '[선택 허용 권한]\n'
                    '- 위치: 지도상에서 나의 위치를 확인하기 위해서 위치권한을 사용합니다. 단 위치정보는 저장하지 않습니다.\n'
                    '- 저장 : 게시물 이미지 저장, 앱 속도 향상을 위한 캐시 저장\n'
                    '- 카메라 : 게시물 이미지, 사용자 프로필 이미지 업로드를 위해서 카메라 기능 사용\n'
                    '- 파일 및 미디어 : 게시물 파일 및 이미지 첨부를 위해서 파일 및 미디어에 접근기능을 사용',
                  style: TextStyle(fontSize:10),
                ),
                Text(
                  '개인정보의 항목 및 수집방법 및 수집하는 개인정보의 수집·이용 목적',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  '■ 개인정보 수집 항목\n'
                  '회사는 회원가입, 서비스 신청을 위해 아래와 같은 개인정보를 수집하고 있습니다.\n'
                  '*수집항목: 아이디, 비밀번호, 이메일\n'
                  '*개인정보 수집방법: 앱 설치 후 회원가입 메뉴를 통해서 가입\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 개인정보 수집 및 이용목적\n'
                  '회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.\n'
                  '1) 회원 서비스에 이용에 따른 본인 확인 절차에 이용\n'
                  '2) 앱 이용: 회원가입을 한 사용자는 MBTrIp 앱 내 MBTI 검사, 추천 코스 받기, 나만의 일기장 작성 등 활동을 이용할 수 있습니다.\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 개인정보 수집에 대한 동의\n'
                  '회사는 회원님의 개인정보 수집에 대하여 동의를 받고 있으며, '
                  '회원가입 시 이용약관 및 개인정보취급방침에 개인정보 수집 동의절차를 마련해 두고 있습니다. '
                  '회원님께서 ‘회원가입 및 이용약관에 동의하겠습니다’란에 체크하시면 개인정보 수집에 대해 동의한 것으로 봅니다.\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 개인정보 제3자 제공\n'
                  '※회사는 고객님의 동의 없이 고객님의 정보를 제3자에게 제공하지 않습니다.\n'
                  '개인정보를 ‘개인정보의 수집 및 활용 목적, 수집하는 개인정보 항목’에서 고지한 범위 내에서 활용합니다.\n'
                  '수탁자에 공유되는 정보는 당해 목적을 달성하기 위하여 필요한 최소한의 정보에 국한됩니다. '
                  '또한 고객의 서비스 요청에 따라 해당하는 업체에 선택적으로 개인 정보가 제공되고 있습니다.\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 개인정보 보유 및 이용 기간, 개인정보의 파기절차 및 파기방법\n'
                  '고객의 개인정보는 회원탈퇴 등 수집 및 이용목적이 달성되거나 동의철회 요청이 있는 경우 지체없이 파기됩니다.\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 개인정보 파기절차 및 파기방법\n'
                  '회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 파기합니다.\n'
                  '파기절차 및 파기방법은 다음과 같습니다.\n'
                  '1) 파기절차: 회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) '
                  '내부 방침 및 기타 관련 법령에 따라 일정 기간 저장된 후 파기됩니다.\n'
                  '2) 파기방법: 종이에 출력된 개인정보는 분쇄기로 분쇄 또는 소각하여 파기합니다. 전자적 파일형태로 저장된 개인정보는 '
                  '기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 이용자 및 법정대리인의 권리와 그 행사방법\n'
                  '이용자는 언제든지 자신의 개인정보를 조회하거나 수정할 수 있으며 가입해지 및 계정삭제를 요청할 수 있습니다.\n'
                  '개인정보관리책임자에게 이메일로 연락하시면 지체없이 변경된 개인정보에 대하여 정정 및 철회의 조치를 하겠습니다.\n'
                  '또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체없이 통지하여 정정이 이루어지도록 하겠습니다.\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 개인정보 자동수집 장치의 설치·운영 및 거부에 관한 사항\n'
                  '쿠키, 인터넷 서비스 이용 시 자동 생성되는 개인정보를 수집하는 장치를 운영하지 않습니다.\n',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '■ 사용자 계정 삭제 및 데이터 일부 또는 전체 삭제 요청 방법\n'
                  '사용자는 계정 삭제 또는 가입한 정보 일부 또는 전체 정보를 삭제하도록 관리자에게 요청할 수 있습니다.\n'
                  '사용자 아이디, 이름을 기재하여 삭제가 필요한 정보를 메일로 보내주세요.\n'
                  '- 담당자 이메일: hwang020107@naver.com\n'
                  '담당자가 확인하여 사용자가 요청하는 정보를 삭제할 수 있습니다. '
                  '회원탈퇴 시 계정이 삭제 처리되며, 사용자의 가입 정보는 모두 삭제 처리됩니다. '
                  '탈퇴 후 해당 계정은 다시 사용할 수 없으며, 계정 복구는 불가합니다.\n',
                  style: TextStyle(fontSize: 10),
                ),

                SizedBox(height: screenHeight * 0.05),
                Align(
                  alignment: Alignment.center, 
                  child: GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _isPressed = true;
                        _buttonColor = Colors.grey[800]!;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _isPressed = false;
                        _buttonColor = Colors.grey[200]!;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.1,
                      ),
                      decoration: BoxDecoration(
                        color: _isPressed ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '완료',
                        style: TextStyle(
                          fontSize: screenHeight * 0.015,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
