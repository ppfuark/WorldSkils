import 'dart:convert';

import 'package:aero/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DronesPage extends StatefulWidget {
  const DronesPage({super.key});

  @override
  State<DronesPage> createState() => _DronesPageState();
}

class _DronesPageState extends State<DronesPage> {
  late Future<List<dynamic>> futureDrones;

  Future<List<dynamic>> fetchDrones() async {
    final response = await http.get(
      Uri.parse("http://10.109.66.116:3000/drones"),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body;
    }
    mounted
        ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erro na busca de drones"),
              backgroundColor: Colors.red,
            ),
          )
        : null;
    throw Exception("Erro na busca de drones");
  }

  @override
  void initState() {
    super.initState();
    futureDrones = fetchDrones();
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
                    future: futureDrones,
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

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/register_drones',
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: theme.secondary,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Center(
                                child: Text(
                                  "Criar novo Drone",
                                  style: AppStyle.bold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final drone = drones[index];

                              final w = MediaQuery.of(context).size.width - 120;

                              return GestureDetector(
                                child: Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (d) async {
                                    if (drone['id'] != null) {
                                      await http.delete(
                                        Uri.parse(
                                          "http://10.109.66.116:3000/drones/${drone['id']}",
                                        ),
                                      );
                                      setState(() {
                                        futureDrones = fetchDrones();
                                      });
                                      context.mounted
                                          ? ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Drone ${drone['nome'] ?? "Sem nome"} deletado",
                                                  style: AppStyle.regular
                                                      .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            )
                                          : null;
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: theme.primary),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      (w *
                                                      (drone['nivel_bateria'] /
                                                          100)),
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: theme.secondary,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                  ),
                                ),
                              );
                            },
                            itemCount: drones.length,
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
