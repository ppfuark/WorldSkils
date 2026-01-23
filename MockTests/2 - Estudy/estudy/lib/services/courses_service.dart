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

  Future<CourseModel?> fetchCourseById(int id) async {
    final response = await http.get(
      Uri.parse("https://json-api-courses-production.up.railway.app/courses"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      final List<dynamic> courseList = decoded[0];

      final courseJson = courseList.firstWhere(
        (course) => course['id'] == id,
        orElse: () => null,
      );

      if (courseJson == null) return null;

      return CourseModel.fromJson(courseJson as Map<String, dynamic>);
    } else {
      throw Exception("Erro ao buscar curso por ID");
    }
  }
}
