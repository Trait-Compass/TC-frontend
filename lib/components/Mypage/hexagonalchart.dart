import 'dart:math';
import 'package:flutter/material.dart';

class RadarChartWidget extends StatefulWidget {
  @override
  _RadarChartWidgetState createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget> {
  List<double> values = [0.8, 0.6, 0.7, 0.5, 0.9, 0.4];
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

  // 사용자가 설정할 수 있는 점수 리스트 (2, 4, 6, 8, 10)
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
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanUpdate: (details) {
          _updateData(details.localPosition);
        },
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: CustomPaint(
            size: Size(radius * 2, radius * 2),
            painter: _RadarChartPainter(
              values: values,
              labels: labels,
              maxValue: maxValue,
              radius: radius,
            ),
          ),
        ),
      ),
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
        // 마우스와 포인트 간의 거리가 30 이하일 때
        double distanceFromCenter = (position - center).distance / radius;

        // 가장 가까운 점수 단계로 값 설정
        double closestScore = scoreLevels.reduce((a, b) =>
            (a - distanceFromCenter).abs() < (b - distanceFromCenter).abs()
                ? a
                : b);

        setState(() {
          values[i] = closestScore; // 값 설정
        });
        break;
      }
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
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    Paint handlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    int sides = labels.length;
    List<int> scores = [2, 4, 6, 8, 10]; // 점수 설정

    // 텍스트 박스 그리기
    double labelOffset = 30; // 텍스트 박스와 차트 사이의 간격 설정 (5만큼 떨어짐)
    for (int i = 0; i < sides; i++) {
      double angle = (2 * pi * i) / sides;
      double x = center.dx + (radius + labelOffset) * cos(angle);
      double y = center.dy + (radius + labelOffset) * sin(angle);
      double scoreValue = (values[i] * 10).roundToDouble(); // 레이블 옆 점수 계산

      // 텍스트 박스를 만들기 위해 Rect 사용
      Rect textBox = Rect.fromCenter(
          center: Offset(x, y), width: 50, height: 50); // 텍스트 박스 크기와 위치 설정

      Paint textBoxPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      Paint borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke;

      // 텍스트 박스 그리기
      canvas.drawRect(textBox, textBoxPaint);
      canvas.drawRect(textBox, borderPaint);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: '${labels[i]} $scoreValue점',
            style: TextStyle(color: Colors.black, fontSize: 12)),
        textAlign: TextAlign.center, // 텍스트 중앙 정렬
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

    // 그리드 그리기 및 점수 표시 (텍스트 박스 아래로 그려짐)
    for (int i = 0; i < scores.length; i++) {
      double scale = scores[i] / 10; // 각 단계별 점수 (2점, 4점, ...)
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

    // 데이터 그리기
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

    // 핸들 그리기
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
