import 'package:flutter/material.dart';

class Top3Courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '인기 코스 TOP 3',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(
                  'assets/changwon.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(
                  'assets/namhae.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(
                  'assets/geoje.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
