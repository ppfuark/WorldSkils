import 'package:flutter/material.dart';
import 'package:health_tech/app_style.dart';

class AnimalDetailPage extends StatefulWidget {
  const AnimalDetailPage({super.key, required this.animal});

  final dynamic animal;

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final loc = widget.animal["localizacao"] ?? "Sem localização";
    final width = MediaQuery.of(context).size.width - 50;
    final Map<String, dynamic> exercices = widget.animal['exercicios_diarios'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Animal", style: AppStyle.black),
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
      backgroundColor: theme.surface,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.animal["nome"] ?? "Sem nome",
                      style: AppStyle.bold,
                    ),
                    SizedBox(height: 20),
                    Text(
                      style: AppStyle.regular,
                      "Lote: 000${widget.animal["lote_id"]}",
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width / 3,
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.inverseSurface),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            color: loc == 'Interno'
                                ? theme.primary
                                : Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(style: AppStyle.regular, "Interno"),
                            ),
                          ),
                        ),
                        Container(
                          width: width / 3,
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.inverseSurface),
                            color: loc == 'Externo'
                                ? theme.primary
                                : Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(style: AppStyle.regular, "Externo"),
                            ),
                          ),
                        ),
                        Container(
                          width: width / 3,
                          decoration: BoxDecoration(
                            color: loc == 'Misto'
                                ? theme.primary
                                : Colors.transparent,
                            border: Border.all(color: theme.inverseSurface),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(style: AppStyle.regular, "Misto"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Vacinado: ", style: AppStyle.bold),
                        Switch(
                          activeThumbColor: theme.secondary,
                          value: widget.animal["vacinado"] ?? false,
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String key = exercices.keys.elementAt(index);

                        return CheckboxListTile(
                          title: Text(key),
                          value: exercices[key],
                          onChanged: (v) {},
                        );
                      },
                      itemCount: exercices.length,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: theme.primary,
                    ),
                    child: Center(
                      child: Text(
                        'Fechar',
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
    );
  }
}
