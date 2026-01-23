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

  @override
  void initState() {
    futureCourses = coursesService.fetchCourses();
    super.initState();
  }

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
                return Text("Erro durante a busca de cursos: ${snapshot.error}");
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
          isDeletable: true,
          block: false,
        );
      },
    );
  }
}
