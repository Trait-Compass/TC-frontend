// lib/pages/hexagonalchart.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../Mypage/mypagemodelforT.dart'; // 모델 파일 경로에 맞게 수정하세요.

class RadarChartWidget extends StatefulWidget {
  final TravelDiary diary; // 모델 인스턴스 전달

  RadarChartWidget({required this.diary});

  @override
  _RadarChartWidgetState createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget> {
  late List<double> values;
  final List<String> labels = [
    '교통\n편의성:\n',
    '관광 명소\n만족도:\n',
    '음식\n만족도:\n',
    '환경 및\n위생:\n',
    '가격대비\n만족도:\n',
    '숙소\n만족도:\n'
  ];
  final double maxValue = 1.0;
  double sideLength = 250;
  late double radius;

  final List<double> scoreLevels = [
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0
  ];

  @override
  void initState() {
    super.initState();
    radius = sideLength / sqrt(3); // 중심에서 꼭짓점까지의 거리

    // 모델에서 값을 가져와서 values 리스트 초기화
    values = [
      (widget.diary.transportationSatisfaction ?? 0) / 10.0,
      (widget.diary.sightseeingSatisfaction ?? 0) / 10.0,
      (widget.diary.foodSatisfaction ?? 0) / 10.0,
      (widget.diary.environmentSatisfaction ?? 0) / 10.0,
      (widget.diary.priceSatisfaction ?? 0) / 10.0,
      (widget.diary.accommodationSatisfaction ?? 0) / 10.0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // 위쪽 정렬
      crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
      children: [
        // 화면의 맨 위에 텍스트 추가
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '여행 만족도 그래프',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        Container(height: 40),
        Center(
          child: GestureDetector(
            onPanUpdate: (details) {
              _updateData(details.localPosition);
            },
            child: Container(
              color: Colors.transparent,
              width: radius * 2.2,
              height: radius * 2.2,
              child: CustomPaint(
                size: Size(radius * 2.2, radius * 2.2),
                painter: _RadarChartPainter(
                  values: values,
                  labels: labels,
                  maxValue: maxValue,
                  radius: radius,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _updateData(Offset position) {
    Offset center = Offset(radius, radius);
    double anglePerSide = (2 * pi) / values.length;

    for (int i = 0; i < values.length; i++) {
      double angle = i * anglePerSide;
      Offset point = Offset(
        center.dx + radius * values[i] * cos(angle),
        center.dy + radius * values[i] * sin(angle),
      );

      if ((position - point).distance < 30) {
        double distanceFromCenter = (position - center).distance / radius;
        double closestScore = scoreLevels.reduce((a, b) =>
            (a - distanceFromCenter).abs() < (b - distanceFromCenter).abs()
                ? a
                : b);

        setState(() {
          values[i] = closestScore; // 값 설정
          _updateModel(i, closestScore);
        });
        break;
      }
    }
  }

  void _updateModel(int index, double value) {
    int score = (value * 10).round();
    switch (index) {
      case 0:
        widget.diary.transportationSatisfaction = score;
        break;
      case 1:
        widget.diary.sightseeingSatisfaction = score;
        break;
      case 2:
        widget.diary.foodSatisfaction = score;
        break;
      case 3:
        widget.diary.environmentSatisfaction = score;
        break;
      case 4:
        widget.diary.priceSatisfaction = score;
        break;
      case 5:
        widget.diary.accommodationSatisfaction = score;
        break;
    }
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<double> values;
  final List<String> labels;
  final double maxValue;
  final double radius;

  _RadarChartPainter({
    required this.values,
    required this.labels,
    required this.maxValue,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    Paint gridPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Paint dataPaint = Paint()
      ..color = Color(0xFF7F7D9C).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    Paint handlePaint = Paint()
      ..color = Color(0xFF4D4C5C)
      ..style = PaintingStyle.fill;

    int sides = labels.length;
    List<int> scores = [2, 4, 6, 8, 10]; // 점수 설정

    double labelOffset = 30; // 텍스트 박스와 차트 사이의 간격 설정
    for (int i = 0; i < sides; i++) {
      double angle = (2 * pi * i) / sides;
      double x = center.dx + (radius + labelOffset) * cos(angle);
      double y = center.dy + (radius + labelOffset) * sin(angle);
      double scoreValue = (values[i] * 10).roundToDouble();

      Rect textBox =
          Rect.fromCenter(center: Offset(x, y), width: 50, height: 50);

      Paint textBoxPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      Paint borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke;

      canvas.drawRect(textBox, textBoxPaint);
      canvas.drawRect(textBox, borderPaint);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: '${labels[i]} $scoreValue점',
            style: TextStyle(color: Colors.black, fontSize: 12)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          textBox.center.dx - textPainter.width / 2,
          textBox.center.dy - textPainter.height / 2,
        ),
      );
    }

    for (int i = 0; i < scores.length; i++) {
      double scale = scores[i] / 10;
      Path path = Path();
      for (int j = 0; j < sides; j++) {
        double angle = (2 * pi * j) / sides;
        double x = center.dx + radius * scale * cos(angle);
        double y = center.dy + radius * scale * sin(angle);
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    Path dataPath = Path();
    for (int i = 0; i < sides; i++) {
      double angle = (2 * pi * i) / sides;
      double x = center.dx + radius * (values[i] / maxValue) * cos(angle);
      double y = center.dy + radius * (values[i] / maxValue) * sin(angle);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();
    canvas.drawPath(dataPath, dataPaint);

    for (int i = 0; i < sides; i++) {
      double angle = (2 * pi * i) / sides;
      double x = center.dx + radius * (values[i] / maxValue) * cos(angle);
      double y = center.dy + radius * (values[i] / maxValue) * sin(angle);
      canvas.drawCircle(Offset(x, y), 5, handlePaint); // 핸들
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
