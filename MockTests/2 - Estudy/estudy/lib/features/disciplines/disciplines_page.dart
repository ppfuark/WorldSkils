import 'package:estudy/common/app_button.dart';
import 'package:estudy/common/app_tile.dart';
import 'package:estudy/common/models/course_model.dart';
import 'package:estudy/common/models/disciplines_model.dart';
import 'package:estudy/services/discipline_service.dart';
import 'package:flutter/material.dart';

class DisciplinesPage extends StatefulWidget {
  const DisciplinesPage({super.key});

  @override
  State<DisciplinesPage> createState() => _DisciplinesPageState();
}

class _DisciplinesPageState extends State<DisciplinesPage> {
  late Future<List<DisciplinesModel>> futureDisciplines;
  final DisciplineService disciplineService = DisciplineService();

  bool activeOption = true;
  final TextEditingController nameContoller = TextEditingController();
  late List<CourseModel> referenceCourses; 
  final TextEditingController workloadContoller = TextEditingController();
  final TextEditingController semestersContoller = TextEditingController();
  final TextEditingController mandatoryController = TextEditingController();

  @override
  void initState() {
    futureDisciplines = disciplineService.fetchDisciplines();
    super.initState();
  }

  void clearControllers() {
    nameContoller.clear();
    workloadContoller.clear();
    semestersContoller.clear();
    mandatoryController.clear();
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
          block: false,
        );
      },
    );
  }

  void _showDeleteModal(String id) {
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
                await disciplineService.deleteCourse(id);
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

  void _showEditModal(Map<String, dynamic> courseData, BuildContext context) {
    nameContoller.text = courseData['name'] ?? '';
    areaContoller.text = courseData['area'] ?? '';
    realeasedContoller.text = courseData['released_date'] ?? '';
    durationContoller.text = courseData['duration_semesters']?.toString() ?? '';
    activeOption = courseData['active'] ?? true;

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
                ),
              ),
            );
          },
        );
      },
    );
  }
}
