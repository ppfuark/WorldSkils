import 'package:estudy/common/app_tile.dart';
import 'package:estudy/common/models/course_model.dart';
import 'package:estudy/common/models/disciplines_model.dart';
import 'package:estudy/services/courses_service.dart';
import 'package:estudy/services/discipline_service.dart';
import 'package:flutter/material.dart';

class CourseDatailsPage extends StatefulWidget {
  final CourseModel courseModel;

  const CourseDatailsPage({super.key, required this.courseModel});

  @override
  State<CourseDatailsPage> createState() => _CourseDatailsPageState();
}

class _CourseDatailsPageState extends State<CourseDatailsPage> {
  late Future<List<DisciplineModel>> futureDisciplines;
  final CoursesService coursesService = CoursesService();
  final DisciplineService disciplineService = DisciplineService();

  @override
  void initState() {
    super.initState();
    futureDisciplines = _initializeDisciplines();
  }

  Future<List<DisciplineModel>> _initializeDisciplines() async {
    final List<DisciplineModel> disciplinesOfCourse = [];

    final disciplines = await disciplineService.fetchDisciplines();

    for (DisciplineModel discipline in disciplines) {
      final referenceCoursesIds = discipline.referenceCourses;

      if (referenceCoursesIds!.contains(widget.courseModel.id!)) {
        disciplinesOfCourse.add(discipline);
      }
    }

    return disciplinesOfCourse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.courseModel.name!)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: futureDisciplines,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Erro na busca das disciplinas do curso ${widget.courseModel.name!}: ${snapshot.error}",
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          "Nenhuma disciplinas relaciona ao curso encontrada. ",
                        ),
                      );
                    }

                    final disciplines = snapshot.data!;

                    return ListView.builder(
                      itemCount: disciplines.length,
                      itemBuilder: (context, index) {
                        final discipline = disciplines[index];
                        return AppTile(
                          title: discipline.name!,
                          subtitle: "${discipline.workload!.toString()} Horas",
                          icon: Icons.book,
                          isEditable: false,
                          isDeletable: false,
                          block: false,
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
