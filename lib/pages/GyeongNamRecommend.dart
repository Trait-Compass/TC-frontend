import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GyeongNamRecommend extends StatelessWidget {
  Future<List<Festival>> fetchFestivals() async {
    final response = await http
        .get(Uri.parse('https://www.traitcompass.store/api/course/festival'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((festival) => Festival.fromJson(festival))
          .toList();
    } else {
      throw Exception('Failed to load festivals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Festival>>(
      future: fetchFestivals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load festivals'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No festivals available'));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '경상남도 행사 & 축제',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.map((festival) {
                    return EventFestivalCard(
                      imagePath: festival.imagePath,
                      title: festival.title,
                      description: festival.description,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class EventFestivalCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const EventFestivalCard({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.4,
      margin:
          EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: screenHeight * 0.01,
            left: screenWidth * 0.025,
            child: Text(
              '$title\n$description',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Festival {
  final String imagePath;
  final String title;
  final String description;

  Festival({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      imagePath: json['imagePath'],
      title: json['title'],
      description: json['description'],
    );
  }
}
