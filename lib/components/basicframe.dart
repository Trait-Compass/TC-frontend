import 'package:flutter/material.dart';

class BasicFrame1Page extends StatelessWidget {
  final Widget body;

  BasicFrame1Page({required this.body});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: Container(
          color: Colors.white,
          child: AppBar(
            centerTitle: true,
            title:
                Image.asset('assets/mbtilogo.jpg', height: screenHeight * 0.05),
            backgroundColor: Colors.white,
            elevation: 0,
             flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/alarm.jpg'),
            onPressed: () {},
          ),
        ],
      ),
        ),
      ),
      body: body,
    );
  }
}
