import 'dart:convert';
import 'dart:io';

import 'package:aero/app_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DroneAdminPage extends StatefulWidget {
  const DroneAdminPage({super.key});

  @override
  State<DroneAdminPage> createState() => _DroneAdminPageState();
}

class _DroneAdminPageState extends State<DroneAdminPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  bool jsonLoaded = false;
  bool saved = false;
  String serviceTime = "";

  Future<void> pickJsonFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.first;

      if (file.bytes == null && file.path == null) {
        throw Exception("Arquivo inválido");
      }

      String content;

      if (file.bytes != null) {
        content = utf8.decode(file.bytes!);
      } else {
        content = await File(file.path!).readAsString();
      }

      final jsonMap = jsonDecode(content) as Map<String, dynamic>;

      setState(() {
        nameController.text = jsonMap['name'] ?? '';
        emailController.text = jsonMap['email'] ?? '';
        dateController.text = jsonMap['service_date'] ?? '';
        jsonLoaded = true;
        saved = false;
        calculateServiceTime();
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "JSON carregado. Clique em Salvar para confirmar.",
            style: AppStyle.regular.copyWith(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erro ao carregar JSON",
            style: AppStyle.regular.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void calculateServiceTime() {
    if (dateController.text.isEmpty) return;

    try {
      final serviceDate = DateTime.parse(dateController.text);
      final now = DateTime.now();

      int years = now.year - serviceDate.year;
      int months = now.month - serviceDate.month;
      int days = now.day - serviceDate.day;

      if (days < 0) {
        months--;
        days += 30;
      }

      if (months < 0) {
        years--;
        months += 12;
      }

      serviceTime = "$years anos, $months meses, $days dias";
    } catch (_) {
      serviceTime = "";
    }
  }

  void save() {
    setState(() {
      saved = true;
      jsonLoaded = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Dados salvos com sucesso",
          style: AppStyle.regular.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text(
          "Admin Drone",
          style: AppStyle.bold.copyWith(
            color: theme.inverseSurface,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome", style: AppStyle.bold),
                  TextField(
                    style: AppStyle.regular,
                    controller: nameController,
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
                children: [
                  Text("Email", style: AppStyle.bold),
                  TextField(
                    style: AppStyle.regular,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
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
                  Text("Data de Serviço", style: AppStyle.bold),
                  TextField(
                    style: AppStyle.regular,
                    controller: dateController,
                    decoration: InputDecoration(
                      hintText: "Data de Serviço (YYYY-MM-DD)",
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
              const SizedBox(height: 16),

              if (serviceTime.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.secondary),
                  ),
                  child: Text(
                    "Tempo de Serviço:\n$serviceTime",
                    style: AppStyle.bold,
                  ),
                ),

              SizedBox(height: 20),

              GestureDetector(
                onTap: pickJsonFile,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: theme.secondary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Center(
                    child: Text(
                      "Upload JSON",
                      style: AppStyle.bold.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              GestureDetector(
                onTap: jsonLoaded ? save : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: jsonLoaded ? theme.primary : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Salvar",
                      style: AppStyle.bold.copyWith(
                        color: jsonLoaded ? theme.inverseSurface : Colors.grey,
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
  }
}
