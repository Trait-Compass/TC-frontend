import 'package:flutter/material.dart';
import '../basic_frame_page.dart';
import '../Mypage/uploadmypictures.dart';

void main() {
  runApp(MaterialApp(
    home: DiaryforF(),
  ));
}

class DiaryforF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              color: Color(0xFFE4E4E4),
              thickness: 1,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
