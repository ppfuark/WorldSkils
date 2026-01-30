import 'dart:async';
import 'package:flutter/material.dart';

import 'package:go_skiing/global/player.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool isPaused = false;
  int coinCount = 10;
  int seconds = 0;
  Timer? _timer;

  String playerName = name;
  bool isPlayerJumping = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          seconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void jump() {
    setState(() async {
      isPlayerJumping = true;
      await Future.delayed(Duration(seconds: 1));
      isPlayerJumping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => isPaused = !isPaused),
                            child: Image.asset(
                              isPaused
                                  ? 'assets/icons/play.png'
                                  : 'assets/icons/pause.png',
                              width: 50,
                            ),
                          ),
                          Text(
                            playerName,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/coin.png',
                                  width: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  coinCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amberAccent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "$seconds",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "S",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                width: size.width,
                height: size.height * 0.5,
                child: GestureDetector(
                  onTap: () {
                    jump();
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: size.height * 0.5,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/trees.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        width: 100,
                        bottom: isPlayerJumping
                            ? size.height * 0.3
                            : size.height * 0.2,
                        child: Image.asset('assets/images/skiing_person.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: size.height * 0.2,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: size.width,
                            height: size.height * 0.25,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
