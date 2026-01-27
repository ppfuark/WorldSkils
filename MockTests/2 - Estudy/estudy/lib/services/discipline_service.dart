import 'dart:convert';
import 'package:estudy/common/models/disciplines_model.dart';
import 'package:http/http.dart' as http;

class DisciplineService {
  Future<List<DisciplineModel>> fetchDisciplines() async {
    final response = await http.get(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/disciplines',
      ),
    );

    if (response.statusCode == 200) {
      final List body = json.decode(response.body);

      return body
          .map((discipline) => DisciplineModel.fromJson(discipline))
          .toList();
    } else {
      throw Exception(
        'Erro na busca de disciplinas. ${response.statusCode.toString()}',
      );
    }
  }

  Future<DisciplineModel?> fetchDisciplinesById(int id) async {
    final response = await http.get(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/disciplines',
      ),
    );

    if (response.statusCode == 200) {
      final List body = json.decode(response.body);

      final courseJson = body.firstWhere(
        (discipline) => discipline['id'] == id,
        orElse: () => null,
      );

      if (courseJson == null) return null;

      return DisciplineModel.fromJson(courseJson);
    } else {
      throw Exception('Erro ao buscar disciplina por ID');
    }
  }

  Future<DisciplineModel> editDisciplines(
    int id,
    Map<String, dynamic> disciplines,
  ) async {
    final response = await http.put(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/disciplines/${id.toString()}',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(disciplines),
    );

    if (response.statusCode == 200) {
      return DisciplineModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Erro ao atualizar disciplinas. ${response.statusCode.toString()}',
      );
    }
  }

  Future<void> deleteDiscipline(int id) async {
    final response = await http.delete(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/disciplines',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (!(response.statusCode == 200)) {
      throw Exception('Erro ao deletar disciplina. ${response.statusCode}');
    }
  }

  Future<DisciplineModel> createDiscipline(DisciplineModel discipline) async {
    final disciplineJson = discipline.toJson();
    final response = await http.post(
      Uri.parse(
        'https://json-api-courses-production.up.railway.app/disciplines',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(disciplineJson),
    );

    if (response.statusCode == 200) {
      return DisciplineModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Erro ao criar disciplina. ${response.statusCode.toString()}',
      );
    }
  }
}
