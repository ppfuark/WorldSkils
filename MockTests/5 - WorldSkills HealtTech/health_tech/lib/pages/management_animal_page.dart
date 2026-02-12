import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_tech/app_style.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text("Manejo de Animais", style: AppStyle.black)),
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
                        color: Color(0xFF4169E1),
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
                          // 2. Convert to a factor between 0.0 and 1.0
                          final double widthFactor = (percentage / 100).clamp(
                            0.0,
                            1.0,
                          );

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: BoxBorder.all(color: Color(0xFF00A3E0)),
                              ),
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      animal["nome"] ?? "Sem nome",
                                      style: AppStyle.bold,
                                    ),
                                    Text(
                                      animal["peso_kg"].toString(),
                                      style: AppStyle.regular.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      height: 16,
                                      width: double
                                          .infinity,
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .grey
                                            .shade300,
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor:
                                            widthFactor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFF4169E1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              999,
                                            ),
                                          ),
                                        ),
                                      ),
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
