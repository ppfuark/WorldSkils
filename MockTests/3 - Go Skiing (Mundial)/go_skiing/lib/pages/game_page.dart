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
  final stopwatch = Stopwatch();
  Timer? secondsTimer;
  int seconds = 0;

  bool skiJumped = false;

  @override
  void initState() {
    super.initState();
    stopwatch.start();

    secondsTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!isPaused) {
        setState(() {
          seconds = stopwatch.elapsed.inSeconds;
        });
      }
    });
  }

  @override
  void dispose() {
    secondsTimer?.cancel();
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
            ),
            SafeArea(
              top: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPaused = !isPaused;
                                  if (isPaused) {
                                    stopwatch.stop();
                                  } else {
                                    stopwatch.start();
                                  }
                                });
                              },
                              child: Image.asset(
                                width: 40,
                                height: 40,
                                isPaused
                                    ? 'assets/icons/play.png'
                                    : 'assets/icons/pause.png',
                              ),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              width: 20,
                              height: 20,
                              'assets/images/coin.png',
                            ),
                            Text(
                              coinCount.toString(),
                              style: TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              seconds.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "S",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        skiJumped = true;
                      });

                      await Future.delayed(const Duration(seconds: 1));

                      setState(() {
                        skiJumped = false;
                      });
                    },

                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/trees.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 160,
                            child: ClipPath(
                              clipper: SlopeClipper(),
                              child: Container(color: Colors.white),
                            ),
                          ),

                          Positioned(
                            bottom: skiJumped ? 200 : 110,

                            left: MediaQuery.of(context).size.width * 0.4,
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(10 / 360),
                              child: Image.asset(
                                'assets/images/skiing_person.png',
                                width: 100,
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
          ],
        ),
      ),
    );
  }
}

class SlopeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width, size.height * 0.5); // top flat
    path.lineTo(size.width, size.height * 0.5); // diagonal slope
    path.lineTo(size.width, size.height); // bottom-right
    path.lineTo(0, size.height); // bottom-left

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
