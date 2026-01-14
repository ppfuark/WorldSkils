import 'package:b1_grotech/features/battery/battery_controller.dart';
import 'package:b1_grotech/features/login/login_page.dart';
import 'package:b1_grotech/features/network/network_controller.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NetworkController _networkController = NetworkController();
  final BatteryController _batteryController = BatteryController();
  
  @override
  void initState() {
    super.initState();
    _networkController.init(navigatorKey);
    _batteryController.init(navigatorKey);
  }

  @override
  void dispose() {
    super.dispose();
    _networkController.dispose();
    _batteryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [Text("Home Page")],
        ),
      ),
    );
  }
}
