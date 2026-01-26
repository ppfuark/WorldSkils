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

  Future<CourseModel> editCourses(int id, CourseModel course) async {
    final response = await http.put(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/courses/${id.toString()}',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200) {
      return CourseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao atualizar curso.");
    }
  }
}
