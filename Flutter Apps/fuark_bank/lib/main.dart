import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fuark_bank/app.dart';
import 'package:fuark_bank/firebase_options.dart';
import 'package:fuark_bank/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(const MyApp());
}
