import 'package:flutter/material.dart';
import 'package:go_skiing/global/player.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double hue = 0;

  Color get _jacketColor => HSVColor.fromAHSV(1, hue, 1, 1).toColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(_jacketColor, BlendMode.modulate),
                child: Image.asset(
                  'assets/images/skiing_person.png',
                  width: 220,
                ),
              ),
              SizedBox(height: 40),

              SizedBox(
                width: 300,
                child: Slider(
                  activeColor: Colors.blue.shade200,
                  min: 0,
                  max: 360,
                  value: hue,
                  onChanged: (hueSlider) => setState(() => hue = hueSlider),
                ),
              ),
              SizedBox(height: 40),

              GestureDetector(
                onTap: () {
                  jacketColor = ColorFilter.mode(
                    _jacketColor,
                    BlendMode.modulate,
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(color: Colors.blue.shade200),
                  width: 150,
                  child: Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
