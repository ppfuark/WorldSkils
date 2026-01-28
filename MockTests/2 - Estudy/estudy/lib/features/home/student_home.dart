import 'package:estudy/common/app_tile.dart';
import 'package:estudy/common/models/course_model.dart';
import 'package:estudy/features/details/course_datails_page.dart';
import 'package:estudy/services/auth_service.dart';
import 'package:estudy/services/courses_service.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    super.initState();
    futureCourses = _initializeCourses();
  }

  late Future<List<CourseModel>> futureCourses;

  final AuthService authService = AuthService();
  final CoursesService coursesService = CoursesService();

  Future<List<CourseModel>> _initializeCourses() async {
    final List<CourseModel> coursesEnrolled = [];

    final coursesId = await authService.getStudentCoursesId(
      authService.getCurrentUser()!.uid,
    );

    for (int courseId in coursesId) {
      final course = await coursesService.fetchCourseById(courseId);

      if (course != null) {
        coursesEnrolled.add(course);
      }
    }

    return coursesEnrolled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Área do estudante"),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.signOut();
            },
            icon: Icon(Icons.logout),
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
                          "Erro na busca dos cursos do estudante: ${snapshot.error}",
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          "Nenhum curso ministrado pelo estudante encontrado. ",
                        ),
                      );
                    }

                    final courses = snapshot.data!;

                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CourseDatailsPage(courseModel: course),
                              ),
                            );
                          },
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
