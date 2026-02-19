import 'dart:convert';

import 'package:fittrack/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorkoutRegister extends StatefulWidget {
  const WorkoutRegister({super.key});

  @override
  State<WorkoutRegister> createState() => _WorkoutRegisterState();
}

class _WorkoutRegisterState extends State<WorkoutRegister> {
  final TextEditingController userId = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController type = TextEditingController();
  String? intensity;
  final List<String> intensityOptns = ['Low', 'Medium', 'High'];
  final TextEditingController durationMin = TextEditingController();
  final TextEditingController calories = TextEditingController();
  final TextEditingController progress = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  bool isPublic = true;

  void createWorkout() async {
    if (userId.text.isNotEmpty &&
        name.text.isNotEmpty &&
        type.text.isNotEmpty &&
        intensity != null &&
        durationMin.text.isNotEmpty &&
        calories.text.isNotEmpty &&
        progress.text.isNotEmpty &&
        startDate.text.isNotEmpty) {
      try {
        var data = {
          "id": DateTime.now().millisecondsSinceEpoch,
          "user_id": userId.text,
          "name": name.text,
          "type": type.text,
          "intensity": intensity,
          "duration_minutes": durationMin.text,
          "calories_target": calories.text,
          "progress_percentage": progress.text,
          "start_date": startDate.text,
          "is_public": isPublic,
        };

        final response = await http.post(
          Uri.parse("http://10.109.66.116:3000/workouts"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );

        if (response.statusCode == 201 && mounted) {
          Navigator.pushNamed(context, '/workouts');
        }
      } catch (e) {
        mounted
            ? ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error on creare workout: ${e.toString()}", style: AppStyle.regular),
                  backgroundColor: Colors.red,
                ),
              )
            : null;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Fields can not be empty", style: AppStyle.regular),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          "Workout Register",
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField(
                        style: AppStyle.regular.copyWith(
                          color: theme.inverseSurface,
                        ),
                        controller: userId,
                        decoration: InputDecoration(
                          hintText: "2",
                          hintStyle: AppStyle.regular.copyWith(
                            color: theme.tertiary,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: theme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppStyle.regular.copyWith(
                          color: theme.inverseSurface,
                        ),
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Jonh Deep",
                          hintStyle: AppStyle.regular.copyWith(
                            color: theme.tertiary,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: theme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppStyle.regular.copyWith(
                          color: theme.inverseSurface,
                        ),
                        controller: type,
                        decoration: InputDecoration(
                          hintText: "Cardio",
                          hintStyle: AppStyle.regular.copyWith(
                            color: theme.tertiary,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: theme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.primary),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            items: intensityOptns
                                .map(
                                  (String optn) => DropdownMenuItem<String>(
                                    value: optn,
                                    child: Text(
                                      optn,
                                      style: AppStyle.regular.copyWith(
                                        color: theme.inverseSurface,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? newOptn) {
                              setState(() {
                                intensity = newOptn;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppStyle.regular.copyWith(
                          color: theme.inverseSurface,
                        ),
                        controller: durationMin,
                        decoration: InputDecoration(
                          hintText: "30",
                          hintStyle: AppStyle.regular.copyWith(
                            color: theme.tertiary,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: theme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppStyle.regular.copyWith(
                          color: theme.inverseSurface,
                        ),
                        controller: calories,
                        decoration: InputDecoration(
                          hintText: "1700",
                          hintStyle: AppStyle.regular.copyWith(
                            color: theme.tertiary,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: theme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppStyle.regular.copyWith(
                          color: theme.inverseSurface,
                        ),
                        controller: progress,
                        decoration: InputDecoration(
                          hintText: "86",
                          hintStyle: AppStyle.regular.copyWith(
                            color: theme.tertiary,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: theme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: AppStyle.regular.copyWith(
                          color: theme.inverseSurface,
                        ),
                        controller: startDate,
                        decoration: InputDecoration(
                          hintText: "2025-12-20",
                          hintStyle: AppStyle.regular.copyWith(
                            color: theme.tertiary,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: theme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: theme.primary,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Public",
                            style: AppStyle.regular.copyWith(
                              color: theme.primary,
                              fontSize: 24,
                            ),
                          ),
                          Switch(
                            value: isPublic,
                            onChanged: (bool newV) {
                              setState(() {
                                isPublic = newV;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: createWorkout,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: theme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 16.0,
                        ),
                        child: Center(
                          child: Text(
                            "Create Workout",
                            style: AppStyle.bold.copyWith(color: theme.surface),
                          ),
                        ),
                      ),
                    ),
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
