import 'dart:convert';

import 'package:fittrack/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkoutDetailPage extends StatefulWidget {
  final int workId;
  final String workName;
  const WorkoutDetailPage({
    super.key,
    required this.workId,
    required this.workName,
  });

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  late Future<List<dynamic>> exercises;

  @override
  void initState() {
    super.initState();
    exercises = fetchExercises();
  }

  Future<List<dynamic>> fetchExercises() async {
    final response = await http.get(
      Uri.parse("http://10.109.66.116:3000/exercises"),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return body;
    }
    mounted
        ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Fields can not be empty", style: AppStyle.regular),
              backgroundColor: Colors.red,
            ),
          )
        : null;
    throw Exception(
      'Error on fetch exercises of Workout ${widget.workId.toString()}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        iconTheme: IconThemeData(color: theme.inverseSurface),
        backgroundColor: theme.surface,
        title: Text(
          "${widget.workName} - ${widget.workId}",
          style: AppStyle.bold.copyWith(color: theme.primary),
        ),
        actions: [
          IconButton(
            onPressed: () => ThemeNotifier.toggleTheme(),
            icon: (ThemeNotifier.themeNotifier.value == AppStyle.lightMode)
                ? Icon(Icons.light_mode_outlined)
                : Icon(Icons.dark_mode_outlined),
            color: theme.inverseSurface,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  FutureBuilder(
                    future: exercises,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) {
                        return Center(child: Text("No workouts found"));
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text("Error on fetch workouts"));
                      }

                      final exercices = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: exercices.length,
                        itemBuilder: (context, index) {
                          final exercise = exercices[index];
                          return GestureDetector(
                            onLongPress: () {},

                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          exercise['name'] ?? "Unnamed",
                                          style: AppStyle.regular.copyWith(
                                            color: theme.inverseSurface,
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "-",
                                          style: AppStyle.regular.copyWith(
                                            color: theme.inverseSurface,
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "${exercise['reps'].toString()} Reps",
                                          style: AppStyle.regular.copyWith(
                                            color: theme.inverseSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
