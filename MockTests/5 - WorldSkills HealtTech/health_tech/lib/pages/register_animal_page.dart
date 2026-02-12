import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_tech/app_style.dart';
import 'package:http/http.dart' as http;

class RegisterAnimalPage extends StatefulWidget {
  const RegisterAnimalPage({super.key});

  @override
  State<RegisterAnimalPage> createState() => _RegisterAnimalPageState();
}

class _RegisterAnimalPageState extends State<RegisterAnimalPage> {
  final PageController pageController = PageController(
    viewportFraction: 0.6,
    initialPage: 1,
  );

  final List<String> animals = [
    'assets/images/cow.png',
    'assets/images/pig.png',
    'assets/images/sheep.png',
  ];

  double currentPage = 1;

  String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController loteController = TextEditingController();
  int? idRaca;
  final TextEditingController kgController = TextEditingController();
  final TextEditingController bornController = TextEditingController();
  String? sex;
  bool castrado = false;
  bool vacina = false;
  final TextEditingController percentContoller = TextEditingController();
  final TextEditingController locController = TextEditingController();
  Map<String, bool> exercices = {
    "seg": false,
    "ter": false,
    "qua": false,
    "qui": false,
    "sex": false,
    "sab": false,
    "dom": false,
  };

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!;
        idRaca = currentPage.round();
      });
    });
  }

  Future<void> register() async {
    if (nameController.text.isNotEmpty &&
        loteController.text.isNotEmpty &&
        kgController.text.isNotEmpty &&
        bornController.text.isNotEmpty &&
        percentContoller.text.isNotEmpty &&
        locController.text.isNotEmpty &&
        idRaca != null &&
        sex != null) {
      var data = {
        "id": uniqueId,
        "nome": nameController.text,
        "lote_id": loteController.text,
        "raca_id": idRaca,
        "peso_kg": kgController.text,
        "data_nascimento": bornController.text,
        "sexo": sex,
        "castrado": castrado,
        "vacinado": vacina,
        "percentual_abate": percentContoller.text,
        "localizacao": locController.text,
        "exercicios_diarios": exercices,
      };
      try {
        final response = await http.post(
          // Note: use 10.0.2.2 if using Android Emulator to access localhost
          Uri.parse("http://10.109.66.116:3000/animais"),
          headers: {
            "Content-Type": "application/json",
          }, // Always add headers for JSON
          body: jsonEncode(data),
        );

        if (response.statusCode == 201 && mounted) {
          Navigator.pushNamed(context, "/management_animal");
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erro: ${response.statusCode}"),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erro de conexão: $e"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Os Campos não podem estar vazios"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: Color(0xFF00A3E0)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text("Escolha o tipo de Animal", style: AppStyle.bold),
                        SizedBox(
                          height: 280,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: animals.length,
                            itemBuilder: (context, index) {
                              bool isCurrent = index == currentPage.round();

                              return Center(
                                child: SizedBox(
                                  height: isCurrent ? 250 : 200,
                                  width: isCurrent ? 250 : 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      animals[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome do Animal",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: Color(0xFF00A3E0),
                          suffixIcon: Icon(
                            Icons.pets_outlined,
                            color: Color(0xFF00A3E0),
                          ),
                          hintText: "Nome",
                          hintStyle: AppStyle.regular.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00A3E0),
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Id do Lote",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      TextField(
                        controller: loteController,
                        decoration: InputDecoration(
                          fillColor: Color(0xFF00A3E0),
                          suffixIcon: Icon(
                            Icons.format_list_numbered_outlined,
                            color: Color(0xFF00A3E0),
                          ),
                          hintText: "X",
                          hintStyle: AppStyle.regular.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00A3E0),
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pesagem em Kg",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      TextField(
                        controller: kgController,
                        decoration: InputDecoration(
                          fillColor: Color(0xFF00A3E0),
                          suffixIcon: Icon(
                            Icons.fitness_center,
                            color: Color(0xFF00A3E0),
                          ),
                          hintText: "X.x",
                          hintStyle: AppStyle.regular.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00A3E0),
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data de nascimento",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      TextField(
                        controller: bornController,
                        decoration: InputDecoration(
                          fillColor: Color(0xFF00A3E0),
                          suffixIcon: Icon(
                            Icons.date_range_outlined,
                            color: Color(0xFF00A3E0),
                          ),
                          hintText: "2021-08-20",
                          hintStyle: AppStyle.regular.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00A3E0),
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tipo",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      RadioGroup(
                        groupValue: sex,
                        onChanged: (String? value) {
                          setState(() {
                            sex = value;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              value: 'Male',
                              activeColor: Color(0xFF00A3E0),
                            ),
                            Text("Male"),
                            SizedBox(width: 20),
                            Radio(
                              value: 'Female',
                              activeColor: Color(0xFF00A3E0),
                            ),
                            Text("Female"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Castrado",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      Switch(
                        value: castrado,
                        activeThumbColor: Color(0xFF00A3E0),
                        onChanged: ((value) {
                          setState(() {
                            castrado = value;
                          });
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vacinado",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      Switch(
                        value: vacina,
                        activeThumbColor: Color(0xFF00A3E0),
                        onChanged: ((value) {
                          setState(() {
                            vacina = value;
                          });
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Percentual do abate",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      TextField(
                        controller: percentContoller,
                        decoration: InputDecoration(
                          fillColor: Color(0xFF00A3E0),
                          suffixIcon: Icon(
                            Icons.percent,
                            color: Color(0xFF00A3E0),
                          ),
                          hintText: "60",
                          hintStyle: AppStyle.regular.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00A3E0),
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Localização",
                        style: AppStyle.regular.copyWith(color: Colors.black),
                      ),
                      TextField(
                        controller: locController,
                        decoration: InputDecoration(
                          fillColor: Color(0xFF00A3E0),
                          suffixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF00A3E0),
                          ),
                          hintText: "Misto",
                          hintStyle: AppStyle.regular.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00A3E0),
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00A3E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: exercices.length,
                    itemBuilder: (context, index) {
                      String key = exercices.keys.elementAt(index);
                      return CheckboxListTile(
                        title: Text(key.toUpperCase()),
                        value: exercices[key],
                        activeColor: const Color(0xFF00A3E0),
                        onChanged: (bool? value) {
                          setState(() {
                            exercices[key] = value!;
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: register,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
