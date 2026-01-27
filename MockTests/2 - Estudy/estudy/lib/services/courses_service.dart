import 'dart:convert';

import 'package:estudy/common/models/course_model.dart';
import 'package:http/http.dart' as http;

class CoursesService {
  Future<List<CourseModel>> fetchCourses() async {
    final response = await http.get(
      Uri.parse('https://json-api-courses-production.up.railway.app/courses'),
    );

    if (response.statusCode == 200) {
      final List body = json.decode(response.body);

      return body.map((course) => CourseModel.fromJson(course)).toList();
    } else {
      throw Exception('Erro na busca de cursos.');
    }
  }

  Future<CourseModel?> fetchCourseById(int id) async {
    final response = await http.get(
      Uri.parse("https://json-api-courses-production.up.railway.app/courses"),
    );

    if (response.statusCode == 200) {
      final List body = json.decode(response.body);

      final courseJson = body.firstWhere(
        (course) => course['id'] == id,
        orElse: () => null,
      );

      if (courseJson == null) return null;

      return CourseModel.fromJson(courseJson as Map<String, dynamic>);
    } else {
      throw Exception("Erro ao buscar curso por ID");
    }
  }

  Future<CourseModel> editCourses(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/courses/${id.toString()}',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return CourseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        "Erro ao atualizar curso. ${response.statusCode.toString()}",
      );
    }
  }

  Future<void> deleteCourse(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/courses/$id',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (!(response.statusCode == 200)) {
      throw Exception("Erro ao deletar curso. ${response.statusCode}");
    }
  }
}
