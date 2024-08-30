import 'package:flutter/material.dart';
import '../basic_frame_page.dart';

void main() {
  runApp(MaterialApp(
    home: DiaryforT(),
  ));
}

class DiaryforT extends StatelessWidget {
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
