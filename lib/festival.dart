import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FestivalsPage extends StatefulWidget {
  @override
  _FestivalsPageState createState() => _FestivalsPageState();
}

class _FestivalsPageState extends State<FestivalsPage> {
  Future<List<dynamic>> fetchFestivals() async {
    final response = await http.get(
      Uri.parse('https://www.traitcompass.store/course/festival'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load festivals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('행사 & 축제'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchFestivals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var festival = snapshot.data![index];
                return ListTile(
                  title: Text(festival['title']),
                  subtitle: Text(festival['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
