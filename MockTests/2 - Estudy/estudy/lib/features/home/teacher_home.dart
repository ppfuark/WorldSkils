import 'package:estudy/common/app_tile.dart';
import 'package:estudy/common/models/course_model.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:estudy/services/courses_service.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  final AuthService authService = AuthService();
  final CoursesService coursesService = CoursesService();
  late Future<List<CourseModel>> futureCourses;

  @override
  void initState() {
    super.initState();
    futureCourses = _initializeCourses();
  }

  Future<List<CourseModel>> _initializeCourses() async {
    final List<int> coursesIds = await authService.getTeacherCoursesId(
      authService.getCurrentUser()!.uid,
    );

    final List<CourseModel> courses = [];

    for (int courseId in coursesIds) {
      final course = await coursesService.fetchCourseById(courseId);

      if (course != null) {
        courses.add(course);
      }
    }

    return courses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Área do Professor"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              final AuthService authService = AuthService();
              authService.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Meus Cursos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: FutureBuilder(
                  future: futureCourses,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Erro na busca dos cursos do professor: ${snapshot.error}",
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          "Nenhum curso ministrado pelo professor encontrado. ",
                        ),
                      );
                    }

                    final courses = snapshot.data!;

                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];

                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: AppTile(
                              title: course.name ?? "",
                              subtitle: (course.active!)
                                  ? "Ativo"
                                  : "Não ativo",
                              icon: Icons.school,
                              isEditable: false,
                              isDeletable: false,
                              block: false,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
