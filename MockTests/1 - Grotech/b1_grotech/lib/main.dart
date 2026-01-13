import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final Connectivity connectivity = Connectivity();

  bool isConnected = false;
  late final StreamSubscription connectivityStream;

  void checkConnectivity() async {
    List<ConnectivityResult> results = await connectivity.checkConnectivity();

    setState(() {
      isConnected = !results.contains(ConnectivityResult.none);
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();

    connectivityStream = connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results){
      setState(() {
        isConnected = !results.contains(ConnectivityResult.none);
      });
    });
  }

  @override
  void dispose() {
    connectivityStream.cancel(); 

    super.dispose();
  }

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
          children: [
            isConnected? 
            Text("Connected"):
            Text("Not Connected")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: checkConnectivity,
        tooltip: 'Increment',
        child: const Icon(Icons.wifi),
      ),
    );
  }
}
