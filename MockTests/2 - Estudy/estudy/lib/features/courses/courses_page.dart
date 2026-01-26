import 'package:estudy/common/app_text_field.dart';
import 'package:estudy/common/app_tile.dart';
import 'package:estudy/common/models/course_model.dart';
import 'package:estudy/services/courses_service.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late Future<List<CourseModel>> futureCourses;
  final CoursesService coursesService = CoursesService();

  bool activeOption = true;
  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController realeasedContoller = TextEditingController();
  final TextEditingController durationContoller = TextEditingController();
  final TextEditingController areaContoller = TextEditingController();

  @override
  void initState() {
    futureCourses = coursesService.fetchCourses();
    super.initState();
  }

  void coursesEdit(CourseModel course) {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cursos"),
        backgroundColor: Colors.transparent,
        foregroundColor: theme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Expanded(
          child: FutureBuilder(
            future: futureCourses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(
                  "Erro durante a busca de cursos: ${snapshot.error}",
                );
              }
              if (!snapshot.hasData) {
                return Text("Nenhum curso encontrado.");
              }

              return _buildCourses(snapshot.data!);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCourses(List<CourseModel> courses) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];

        return AppTile(
          title: course.name ?? "",
          subtitle: "${course.durationSem ?? "-"} Semestres",
          icon: Icons.book_outlined,
          isEditable: true,
          onEdit: () => _showEditModal(course.toJson(), context),
          isDeletable: true,
          block: false,
        );
      },
    );
  }

  void _showEditModal(Map<String, dynamic> courseData, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar curso"),
          content: SizedBox(
            height: 500,
            width: 250,
            child: Column(
              children: [
                AppTextField(
                  icon: Icons.numbers_outlined,
                  label: "id",
                  hintText: courseData['id'].toString(),
                  isPasswordField: false,
                  enabled: false,
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: nameContoller,
                  icon: Icons.numbers_outlined,
                  label: "Nome",
                  hintText: courseData['name'] ?? "",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: areaContoller,
                  icon: Icons.numbers_outlined,
                  label: "Área",
                  hintText: courseData['area'] ?? "",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: realeasedContoller,
                  icon: Icons.numbers_outlined,
                  label: "Data de lançamento",
                  hintText: courseData['released_date'].toString() ?? "",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: durationContoller,
                  icon: Icons.numbers_outlined,
                  label: "Duração semestral",
                  hintText: courseData['duration_semesters'].toString(),
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ativo",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: activeOption,
                      activeThumbColor: Theme.of(context).colorScheme.primary,
                      onChanged: (bool value) {
                        setState(() {
                          activeOption = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
