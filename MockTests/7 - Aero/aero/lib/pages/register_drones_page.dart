import 'dart:convert';

import 'package:aero/app_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterDronesPage extends StatefulWidget {
  const RegisterDronesPage({super.key});

  @override
  State<RegisterDronesPage> createState() => _RegisterDronesPageState();
}

class _RegisterDronesPageState extends State<RegisterDronesPage> {
  final nome = TextEditingController();
  final modeloId = TextEditingController();
  final baseId = TextEditingController();
  final peso = TextEditingController();
  final dataM = TextEditingController();
  final propulsao = TextEditingController();
  bool sensor = true;
  final nivelBat = TextEditingController();
  bool missao = true;
  final horasVoo = TextEditingController();
  Map<String, dynamic> checklist = {
    "seg": true,
    "ter": true,
    "qua": true,
    "qui": true,
    "sex": true,
    "sab": true,
    "dom": true,
  };

  void create() async {
    if (nome.text.isNotEmpty &&
        modeloId.text.isNotEmpty &&
        baseId.text.isNotEmpty &&
        peso.text.isNotEmpty &&
        dataM.text.isNotEmpty &&
        propulsao.text.isNotEmpty &&
        nivelBat.text.isNotEmpty &&
        horasVoo.text.isNotEmpty) {
      var data = {
        "id": DateTime.timestamp().millisecondsSinceEpoch.toString(),
        "nome": nome.text,
        "modelo_id": modeloId.text,
        "base_id": baseId.text,
        "peso_carga_kg": int.tryParse(peso.text),
        "data_primeira_missao": dataM.text,
        "propulsao": propulsao.text,
        "sensor_termico": sensor,
        "nivel_bateria": int.tryParse(nivelBat.text),
        "em_missao": missao,
        "horas_voo": int.tryParse(horasVoo.text),
        "checklist_decolagem": checklist,
      };

      final response = await http.post(
        Uri.parse("http://10.109.66.116:3000/drones"),
        headers: {
            "Content-Type": "application/json",
          },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        mounted ? Navigator.pushNamed(context, "/drones") : null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text(
          "Criar Drone",
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nome", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: nome,
                            decoration: InputDecoration(
                              hintText: "Nome",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Modelo Id", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: modeloId,
                            decoration: InputDecoration(
                              hintText: "Modelo Id",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Base Id", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: baseId,
                            decoration: InputDecoration(
                              hintText: "Base Id",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Peso Kg", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: peso,
                            decoration: InputDecoration(
                              hintText: "Peso Kg",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Data primeira missão", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: dataM,
                            decoration: InputDecoration(
                              hintText: "2025-12-20",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Propulsão", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: propulsao,
                            decoration: InputDecoration(
                              hintText: "Propulsão",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sensor Térmico", style: AppStyle.bold),
                          Switch(
                            value: sensor,
                            onChanged: (v) {
                              setState(() {
                                sensor = v;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nível bateria", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: nivelBat,
                            decoration: InputDecoration(
                              hintText: "Nível bateria",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Em missão", style: AppStyle.bold),
                          Switch(
                            value: missao,
                            onChanged: (v) {
                              setState(() {
                                missao = v;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Horas Voo", style: AppStyle.bold),
                          TextField(
                            style: AppStyle.regular,
                            controller: horasVoo,
                            decoration: InputDecoration(
                              hintText: "Horas Voo",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintStyle: AppStyle.regular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          String key = checklist.keys.elementAt(index);
                          return CheckboxListTile(
                            value: checklist[key],
                            title: Text(key.toUpperCase()),
                            onChanged: (bool? v) {
                              setState(() {
                                checklist[key] = v!;
                              });
                            },
                          );
                        },
                        itemCount: checklist.length,
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: create,
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
                          "Criar Drone",
                          style: AppStyle.bold.copyWith(color: Colors.white),
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
