import 'package:estudy/common/app_button.dart';
<<<<<<< HEAD
import 'package:estudy/common/app_text_field.dart';
import 'package:estudy/common/app_tile.dart';
import 'package:estudy/common/models/course_model.dart';
import 'package:estudy/common/models/disciplines_model.dart';
import 'package:estudy/services/courses_service.dart';
=======
import 'package:estudy/common/app_tile.dart';
import 'package:estudy/common/models/course_model.dart';
import 'package:estudy/common/models/disciplines_model.dart';
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
import 'package:estudy/services/discipline_service.dart';
import 'package:flutter/material.dart';

class DisciplinesPage extends StatefulWidget {
  const DisciplinesPage({super.key});

  @override
  State<DisciplinesPage> createState() => _DisciplinesPageState();
}

class _DisciplinesPageState extends State<DisciplinesPage> {
<<<<<<< HEAD
  late Future<List<DisciplineModel>> futureDisciplines;
  late Future<List<CourseModel>> futureCourses;
  final DisciplineService disciplineService = DisciplineService();
  final CoursesService coursesService = CoursesService();

  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController workloadContoller = TextEditingController();
  final TextEditingController semestersContoller = TextEditingController();
  late List<int> selectedIds = [];
  bool mandatoryValue = true;
=======
  late Future<List<DisciplinesModel>> futureDisciplines;
  final DisciplineService disciplineService = DisciplineService();

  bool activeOption = true;
  final TextEditingController nameContoller = TextEditingController();
  late List<CourseModel> referenceCourses; 
  final TextEditingController workloadContoller = TextEditingController();
  final TextEditingController semestersContoller = TextEditingController();
  final TextEditingController mandatoryController = TextEditingController();
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3

  @override
  void initState() {
    futureDisciplines = disciplineService.fetchDisciplines();
<<<<<<< HEAD
    futureCourses = coursesService.fetchCourses();
=======
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
    super.initState();
  }

  void clearControllers() {
    nameContoller.clear();
    workloadContoller.clear();
    semestersContoller.clear();
<<<<<<< HEAD
=======
    mandatoryController.clear();
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Disciplinas"),
        backgroundColor: Colors.transparent,
        foregroundColor: theme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Expanded(
                child: FutureBuilder(
                  future: futureDisciplines,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text(
                        "Erro durante a busca de Disciplinas: ${snapshot.error}",
                      );
                    }
                    if (!snapshot.hasData) {
                      return Text("Nenhuma Disciplina encontrado.");
                    }

                    return _buildDisciplines(snapshot.data!);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            AppButton(
              label: "Criar Nova Disciplina",
              onTap: () => showCreateModal(context),
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildDisciplines(List<DisciplineModel> disciplines) {
    return ListView.builder(
      itemCount: disciplines.length,
      itemBuilder: (context, index) {
        final discipline = disciplines[index];

        return AppTile(
          title: discipline.name ?? "",
          subtitle: "${discipline.semester ?? "-"} Semestres",
          icon: Icons.book_outlined,
          isEditable: true,
          onEdit: () => _showEditModal(discipline, context),
          isDeletable: true,
          onDelete: () => _showDeleteModal(discipline.id!),
=======
  Widget _buildDisciplines(List<DisciplinesModel> Disciplines) {
    return ListView.builder(
      itemCount: Disciplines.length,
      itemBuilder: (context, index) {
        final course = Disciplines[index];

        return AppTile(
          title: course.name ?? "",
          subtitle: "${course.durationSem ?? "-"} Semestres",
          icon: Icons.book_outlined,
          isEditable: true,
          onEdit: () => _showEditModal(course.toJson(), context),
          isDeletable: true,
          onDelete: () => _showDeleteModal(course.id.toString()),
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
          block: false,
        );
      },
    );
  }

<<<<<<< HEAD
  void _showDeleteModal(int id) {
=======
  void _showDeleteModal(String id) {
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Deseja mesmo excluir o Disciplina? "),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
<<<<<<< HEAD
                await disciplineService.deleteDiscipline(id);
=======
                await disciplineService.deleteCourse(id);
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
                if (context.mounted) {
                  Navigator.pop(context);
                }
                setState(() {
                  futureDisciplines = disciplineService.fetchDisciplines();
                });
              },
              child: Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

<<<<<<< HEAD
  void _showEditModal(DisciplineModel discipline, BuildContext context) {
    nameContoller.text = discipline.name ?? '';
    workloadContoller.text = discipline.workload?.toString() ?? '';
    semestersContoller.text = discipline.semester?.toString() ?? '';
    mandatoryValue = discipline.mandatory ?? true;
    selectedIds = List<int>.from(discipline.referenceCourses ?? []);
=======
  void _showEditModal(Map<String, dynamic> courseData, BuildContext context) {
    nameContoller.text = courseData['name'] ?? '';
    areaContoller.text = courseData['area'] ?? '';
    realeasedContoller.text = courseData['released_date'] ?? '';
    durationContoller.text = courseData['duration_semesters']?.toString() ?? '';
    activeOption = courseData['active'] ?? true;
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: Text("Editar Disciplina"),
              content: SizedBox(
                height: 570,
                width: 250,
<<<<<<< HEAD
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextField(
                        icon: Icons.numbers_outlined,
                        label: "id",
                        hintText: discipline.id.toString(),
                        isPasswordField: false,
                        enabled: false,
                      ),
                      SizedBox(height: 10),
                      AppTextField(
                        controller: nameContoller,
                        icon: Icons.school,
                        label: "Nome",
                        hintText: discipline.name ?? "",
                        isPasswordField: false,
                      ),
                      SizedBox(height: 10),
                      FutureBuilder(
                        future: futureCourses,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Erro durante a busca de Cursos'),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text('Nenhum curso encontrado'),
                            );
                          }
                          final courses = snapshot.data!;

                          return SizedBox(
                            height: 200,
                            child: SingleChildScrollView(
                              child: Wrap(
                                spacing: 8,
                                children: courses.map((course) {
                                  final isSelected = selectedIds.contains(
                                    course.id,
                                  );

                                  return FilterChip(
                                    label: Text(
                                      course.name ?? "-",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    selected: isSelected,
                                    selectedColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    onSelected: (selected) {
                                      selected
                                          ? selectedIds.add(course.id!)
                                          : selectedIds.remove(course.id!);

                                      setModalState(() {});
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      AppTextField(
                        controller: workloadContoller,
                        icon: Icons.hourglass_bottom,
                        label: "Duração em horas",
                        hintText: discipline.workload?.toString() ?? '',
                        isPasswordField: false,
                        onlyNumbers: true,
                      ),
                      SizedBox(height: 10),
                      AppTextField(
                        controller: semestersContoller,
                        icon: Icons.date_range,
                        label: "Quantidade de semestres",
                        hintText: discipline.semester.toString(),
                        isPasswordField: false,
                        onlyNumbers: true,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Obrigatório",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: mandatoryValue,
                            activeThumbColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            onChanged: (value) {
                              setModalState(() {
                                mandatoryValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      AppButton(
                        label: "Editar",
                        onTap: () async {
                          final updatedData = {
                            "id": discipline.id,
                            "name": nameContoller.text,
                            "reference_course": selectedIds,
                            "workload_hours": int.tryParse(
                              workloadContoller.text,
                            ),
                            "semester": int.tryParse(semestersContoller.text),
                            "mandatory": mandatoryValue,
                          };

                          await disciplineService.editDisciplines(
                            discipline.id!,
                            updatedData,
                          );

                          setState(() {
                            futureDisciplines = disciplineService
                                .fetchDisciplines();
                          });

                          clearControllers();

                          if (context.mounted) Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
=======
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
                      icon: Icons.school,
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
                      icon: Icons.date_range,
                      label: "Data de lançamento",
                      hintText: courseData['released_date'].toString(),
                      isPasswordField: false,
                    ),
                    SizedBox(height: 10),
                    AppTextField(
                      controller: durationContoller,
                      icon: Icons.timelapse,
                      label: "Duração semestral",
                      hintText: courseData['duration_semesters'].toString(),
                      isPasswordField: false,
                      keyboardType: TextInputType.number,
                      onlyNumbers: true,
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
                          activeThumbColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          onChanged: (value) {
                            setModalState(() {
                              activeOption = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AppButton(
                      label: "Editar",
                      onTap: () async {
                        final updateData = {
                          "id": courseData['id'],
                          "name": nameContoller.text,
                          "area": areaContoller.text,
                          "released_date": realeasedContoller.text,
                          "duration_semesters": int.tryParse(
                            durationContoller.text,
                          ),
                          "active": activeOption,
                        };

                        await disciplineService.editDisciplines(
                          courseData['id'],
                          updateData,
                        );

                        setState(() {
                          futureDisciplines = disciplineService.fetchDisciplines();
                        });

                        clearControllers();

                        if (context.mounted) Navigator.pop(context);
                      },
                    ),
                  ],
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showCreateModal(BuildContext context) {
    clearControllers();
<<<<<<< HEAD
    selectedIds = [];
=======
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: Text("Criar Disciplina"),
              content: SizedBox(
                height: 500,
                width: 250,
<<<<<<< HEAD
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextField(
                        controller: nameContoller,
                        icon: Icons.school,
                        label: "Nome",
                        hintText: "Lopal",
                        isPasswordField: false,
                      ),
                      SizedBox(height: 10),
                      FutureBuilder(
                        future: futureCourses,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Erro durante a busca de Cursos'),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text('Nenhum curso encontrado'),
                            );
                          }
                          final courses = snapshot.data!;

                          return SizedBox(
                            height: 200,
                            child: SingleChildScrollView(
                              child: Wrap(
                                spacing: 8,
                                children: courses.map((course) {
                                  final isSelected = selectedIds.contains(
                                    course.id,
                                  );

                                  return FilterChip(
                                    label: Text(
                                      course.name!,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    selected: isSelected,
                                    selectedColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    onSelected: (selected) {
                                      selected
                                          ? selectedIds.add(course.id!)
                                          : selectedIds.remove(course.id!);

                                      setModalState(() {});
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      AppTextField(
                        controller: workloadContoller,
                        icon: Icons.hourglass_bottom,
                        label: "Duração em horas",
                        hintText: "80",
                        isPasswordField: false,
                        onlyNumbers: true,
                      ),
                      SizedBox(height: 10),
                      AppTextField(
                        controller: semestersContoller,
                        icon: Icons.date_range,
                        label: "Quantidade de semestres",
                        hintText: "4",
                        isPasswordField: false,
                        onlyNumbers: true,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Obrigatório",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: mandatoryValue,
                            activeThumbColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            onChanged: (value) {
                              setModalState(() {
                                mandatoryValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      AppButton(
                        label: "Criar",
                        onTap: () async {
                          final DisciplineModel newDiscipline = DisciplineModel(
                            name: nameContoller.text,
                            referenceCourses: selectedIds,
                            workload: int.tryParse(workloadContoller.text),
                            semester: int.tryParse(semestersContoller.text),
                            mandatory: mandatoryValue,
                          );

                          await disciplineService.createDiscipline(
                            newDiscipline,
                          );

                          setState(() {
                            futureDisciplines = disciplineService
                                .fetchDisciplines();
                          });

                          clearControllers();

                          if (context.mounted) Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
=======
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    AppTextField(
                      controller: nameContoller,
                      icon: Icons.school,
                      label: "Nome",
                      hintText: "Banco de dados",
                      isPasswordField: false,
                    ),
                    SizedBox(height: 10),
                    AppTextField(
                      controller: areaContoller,
                      icon: Icons.numbers_outlined,
                      label: "Área",
                      hintText: "Tecnologia",
                      isPasswordField: false,
                    ),
                    SizedBox(height: 10),
                    AppTextField(
                      controller: realeasedContoller,
                      icon: Icons.date_range,
                      label: "Data de criação",
                      hintText: "yyyy-mm-dd",
                      isPasswordField: false,
                    ),
                    SizedBox(height: 10),
                    AppTextField(
                      controller: durationContoller,
                      icon: Icons.timelapse,
                      label: "Duração de semestres",
                      hintText: "1",
                      isPasswordField: false,
                      keyboardType: TextInputType.number,
                      onlyNumbers: true,
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
                          activeThumbColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          onChanged: (bool value) {
                            setModalState(() {
                              activeOption = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AppButton(
                      label: "Criar",
                      onTap: () async {
                        final DisciplinesModel DisciplinesModel =
                            DisciplinesModel(
                              name: nameContoller.text,
                              active: activeOption,
                              area: areaContoller.text,
                              durationSem: int.parse(durationContoller.text),
                              realeasedDate: realeasedContoller.text,
                            );

                        await disciplineService.createCourse(DisciplinesModel);

                        setState(() {
                          futureDisciplines = disciplineService.fetchDisciplines();
                        });

                        clearControllers();

                        if (context.mounted) Navigator.pop(context);
                      },
                    ),
                  ],
>>>>>>> d389e4cc1bfd3ccdb1f4ecd769d62f0d6bc164d3
                ),
              ),
            );
          },
        );
      },
    );
  }
}
