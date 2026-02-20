import 'dart:convert';

import 'package:aero/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DroneDetail extends StatefulWidget {
  final String id;
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

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro ao carregar drone");
    }
  }

  @override
  void initState() {
    super.initState();
    drone = fetchDrone();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text(
          "Drones - ${widget.id}",
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
                  FutureBuilder<Map<String, dynamic>>(
                    future: drone,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Erro na busca de dados"),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("Nenhum drone encontrado"),
                        );
                      }

                      final droneData = snapshot.data!;
                      final w = MediaQuery.of(context).size.width - 120;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            droneData['nome'] ?? "Sem nome",
                            style: AppStyle.regular,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: w,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        w *
                                        ((droneData['nivel_bateria'] ?? 0) /
                                            100),
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: theme.secondary,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${droneData['nivel_bateria'] ?? 0} %",
                                style: AppStyle.regular,
                              ),
                            ],
                          ),
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
