import 'dart:convert';

import 'package:estudy/common/models/course_model.dart';
import 'package:http/http.dart' as http;

class CoursesService {
  Future<List<CourseModel>> fetchCourses() async {
    final response = await http.get(
      Uri.parse('https://json-api-courses-production.up.railway.app/courses'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);

      final List<dynamic> coursesList = decoded[0];

      return coursesList.map((e) => CourseModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro na busca de cursos.');
    }
  }
}
