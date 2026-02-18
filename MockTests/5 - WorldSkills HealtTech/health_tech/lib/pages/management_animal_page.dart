import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_tech/app_style.dart';
import 'package:health_tech/pages/animal_detail_page.dart';
import 'package:http/http.dart' as http;

class ManagementAnimalPage extends StatefulWidget {
  const ManagementAnimalPage({super.key});

  @override
  State<ManagementAnimalPage> createState() => _ManagementAnimalPageState();
}

class _ManagementAnimalPageState extends State<ManagementAnimalPage> {
  late Future<List<dynamic>> animals;

  Future<List<dynamic>> fetchAnimals() async {
    final response = await http.get(
      Uri.parse("http://10.109.66.116:3000/animais"),
    );

    final data = jsonDecode(response.body);
    return data;
  }

  @override
  void initState() {
    super.initState();
    animals = fetchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text("Manejo de Animais", style: AppStyle.black),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              ThemeProvider.toggleTheme();
            },
            icon: ThemeProvider.themeNotifier.value == darkMode
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, "/register_animal"),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: theme.primary,
                      ),
                      child: Center(
                        child: Text(
                          'Cadastrar animal',
                          style: AppStyle.bold.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: animals,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Erro na busca de Animais",
                            style: AppStyle.bold,
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Text(
                            "Nenhum Animal encontrado",
                            style: AppStyle.bold,
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final animal = snapshot.data![index];

                          if (animal['nome'] == null) {
                            return const SizedBox.shrink();
                          }

                          final double percentage =
                              double.tryParse(
                                animal["percentual_abate"].toString(),
                              ) ??
                              0.0;
                          final double widthFactor = (percentage / 100).clamp(
                            0.0,
                            1.0,
                          );

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AnimalDetailPage(animal: animal),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: BoxBorder.all(color: theme.primary),
                                ),
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        animal["nome"] ?? "Sem nome",
                                        style: AppStyle.bold,
                                      ),
                                      Text(
                                        "${animal["peso_kg"].toString()} Kg",
                                        style: AppStyle.regular,
                                      ),
                                      Container(
                                        height: 16,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: widthFactor,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: theme.primary,
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
