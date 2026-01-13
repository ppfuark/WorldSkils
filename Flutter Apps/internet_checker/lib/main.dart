import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_checker/dependency_injection.dart';

void main() {
  DependencyInjection.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page1()
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({ Key ? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text('FLUTTER GUYS'),
          centerTitle: true,
      ),
      body: Center(
        child: MaterialButton(
          height: 60,
          minWidth: 200,
          color: const Color(0xff1D1E22),
          onPressed: () => Navigator.push < void > (
            context,
            MaterialPageRoute < void > (
              builder: (BuildContext context) => const Page2(),
            ),
          ),
          child: const Text(
            'GO TO PAGE 2',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({ Key ? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: const Text('FLUTTER GUYS'),
        centerTitle: true,
      ),
    );
  }
}