import 'package:flutter/material.dart';

final InputDecoration textFieldDecoration = InputDecoration(
  hintText: '아이디',
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(horizontal: 16),
);

final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.grey,
  foregroundColor: Colors.white,
  padding: EdgeInsets.symmetric(vertical: 16),
  minimumSize: Size(double.infinity, 48),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: BorderSide(color: Colors.grey),
  ),
);

final ButtonStyle kakaoButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.yellow,
  padding: EdgeInsets.symmetric(vertical: 16),
  minimumSize: Size(double.infinity, 48),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: BorderSide(color: Colors.grey),
  ),
);
