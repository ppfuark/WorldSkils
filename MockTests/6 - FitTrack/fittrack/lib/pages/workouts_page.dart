import 'dart:convert';

import 'package:fittrack/app_style.dart';
import 'package:fittrack/pages/workout_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  late Future<List<dynamic>> futureWorkouts;

  Future<List<dynamic>> fecthWorkouts() async {
    final response = await http.get(
      Uri.parse("http://10.109.66.116:3000/workouts"),
    );

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);

      return body;
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error on fecth courses: ${response.statusCode.toString()}",
            style: AppStyle.regular,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    throw Exception(
      "Error on fecth courses: ${response.statusCode.toString()}",
    );
  }

  @override
  void initState() {
    super.initState();
    futureWorkouts = fecthWorkouts();
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
          "Workouts",
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
        top: true,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  FutureBuilder(
                    future: futureWorkouts,
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

                      final workouts = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: workouts.length,
                        itemBuilder: (context, index) {
                          final workout = workouts[index];
                          return GestureDetector(
                            onLongPress: () {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Delete Workout?',
                                      style: AppStyle.bold.copyWith(
                                        color: theme.inverseSurface,
                                      ),
                                    ),
                                    content: Text(
                                      'This action can not be unmaded',
                                      style: AppStyle.regular.copyWith(
                                        color: theme.inverseSurface,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.labelLarge,
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: AppStyle.regular,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.labelLarge,
                                        ),
                                        child: Text(
                                          'Continue',
                                          style: AppStyle.regular,
                                        ),
                                        onPressed: () {
                                          http.delete(
                                            Uri.parse(
                                              "http://10.109.66.116:3000/workouts/${workout['id']}",
                                            ),
                                          );

                                          setState(() {
                                            futureWorkouts = fecthWorkouts();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WorkoutDetailPage(
                                    workId: workout['id'] ?? 1,
                                    workName: workout['name'] ?? "Sem nome",
                                  ),
                                ),
                              );
                            },
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
                                          workout['name'] ?? "Unnamed",
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
                                          "${workout['duration_minutes'].toString()} Min",
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
