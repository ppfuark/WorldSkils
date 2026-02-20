import 'dart:convert';

import 'package:aero/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DroneDetail extends StatefulWidget {
  final int id;
  const DroneDetail({super.key, required this.id});

  @override
  State<DroneDetail> createState() => _DroneDetailState();
}

class _DroneDetailState extends State<DroneDetail> {
  late Future<Map<String, dynamic>> drone;

  Future<Map<String, dynamic>> fetchDrone() async {
    final response = await http.get(
      Uri.parse("http://10.109.66.116:3000/drones/${widget.id}"),
    );

    drone = jsonDecode(response.body);
    return drone;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text(
          "Drones",
          style: AppStyle.bold.copyWith(
            color: theme.inverseSurface,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                ThemeProvider.toggleTheme();
              });
            },
            icon: (ThemeProvider.themeNotifier.value == AppStyle.lightMode)
                ? Icon(Icons.light_mode_outlined)
                : Icon(Icons.dark_mode_outlined),
            color: theme.inverseSurface,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  FutureBuilder(
                    future: drone,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data == null) {
                        return Center(child: Text("Nenhum drone encontrado"));
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text("Erro na busca de dados"));
                      }

                      final drones = snapshot.data!;

                      final w = MediaQuery.of(context).size.width - 120;

                      return Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                drone['nome'] ?? "Sem nome",
                                style: AppStyle.regular,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: w,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (w *
                                            (drone['nivel_bateria'] / 100)),
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: theme.secondary,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${drone['nivel_bateria']} %",
                                    style: AppStyle.regular,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
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
