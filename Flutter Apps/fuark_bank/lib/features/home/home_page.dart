import 'package:flutter/material.dart';
import 'package:fuark_bank/common/constants/app_routes.dart';
import 'package:fuark_bank/common/widgets/app_button.dart';
import 'package:fuark_bank/services/secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BOA"),
            AppButton(
              onPressed: () {
                _secureStorage
                    .deleteOne(key: "CURRENT_USER")
                    .then(
                      (_) =>
                          Navigator.popAndPushNamed(context, AppRoutes.initial),
                    );
              },
              label: "Sign Out",
            ),
          ],
        ),
      ),
    );
  }
}
