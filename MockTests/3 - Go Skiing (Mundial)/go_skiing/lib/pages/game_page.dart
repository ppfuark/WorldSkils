import 'dart:async';
import 'dart:math';
import 'package:go_skiing/global/models/rank_model.dart';
import 'package:go_skiing/services/rank_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

import 'package:go_skiing/global/player.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final RankService rankService = RankService();

  late final AudioPlayer bgmPlayer;
  late final AudioPlayer sfxPlayer;

  bool isPaused = false;
  int coinCount = 10;
  int seconds = 0;
  Timer? secondsTimer;
  Timer? gameTimer;
  Timer? gameVelocity;

  int gameVelocityCount = 10;

  String playerName = name;
  bool isPlayerJumping = false;

  bool obstacleInScreen = false;
  double obstacleLeft = 1000;

  bool coinInScreen = false;
  double coinLeft = 1000;

  @override
  void initState() {
    super.initState();

    bgmPlayer = AudioPlayer();
    sfxPlayer = AudioPlayer();

    _initBgm();

    nextObject();
    _startTimer();
    startGameLoop();
  }

  Future<void> _initBgm() async {
    await bgmPlayer.setAsset('assets/audio/bgm.mp3');
    bgmPlayer.setLoopMode(LoopMode.one);
    bgmPlayer.play();
  }

  void jump() async {
    if (isPlayerJumping) return;

    await sfxPlayer.setAsset('assets/audio/jump.wav');
    sfxPlayer.play();

    setState(() => isPlayerJumping = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => isPlayerJumping = false);
      }
    });
  }

  void _startTimer() {
    secondsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          seconds++;
        });
      }
    });
  }

  void startGameLoop() {
    gameTimer = Timer.periodic(Duration(milliseconds: 40), (_) {
      if (!isPaused) {
        gameUpdate();
      }
    });

    gameVelocity = Timer.periodic(Duration(seconds: 10), (_) {
      if (!isPaused) {
        gameVelocityCount == 30 ? gameVelocityCount += 2 : gameVelocity;
      }
    });
  }

  void gameUpdate() {
    setState(() {
      if (obstacleInScreen) {
        obstacleLeft -= gameVelocityCount;
        if (obstacleLeft < -80) {
          obstacleInScreen = false;
          obstacleLeft = 1000;
          nextObject();
        }
        checkCollison();
      }

      if (coinInScreen) {
        coinLeft -= gameVelocityCount;
        if (coinLeft < -80) {
          coinInScreen = false;
          coinLeft = 1000;
          nextObject();
        }
      }
      checkCoinCollison();
    });
  }

  void nextObject() {
    if (!isPaused) {
      bool isCoin = Random().nextBool();

      if (isCoin) {
        coinInScreen = true;
        obstacleInScreen = false;
      } else {
        coinInScreen = false;
        obstacleInScreen = true;
      }
    }
  }

  void checkCollison() {
    if (obstacleLeft < 100 && obstacleLeft > 0) {
      if (!isPlayerJumping) {
        gameOver();
        isPaused = true;
      }
    }
  }

  void checkCoinCollison() {
    if (coinLeft < 100 && coinLeft > 0) {
      if (!isPlayerJumping) {
        coinInScreen = false;
        coinLeft = 1000;
        coinCount += 1;
        nextObject();
      }
    }
  }

  void gameOver() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("You lose!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
    await rankService.addRank(
      RankModel(coin: coinCount, playerName: playerName, duration: seconds),
    );
  }

  @override
  void dispose() {
    bgmPlayer.dispose();
    sfxPlayer.dispose();

    secondsTimer?.cancel();
    gameTimer?.cancel();
    super.dispose();
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
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        width: 100,
                        bottom: isPlayerJumping ? 300 : 200,
                        child: Image.asset('assets/images/skiing_person.png'),
                      ),

                      Positioned(
                        bottom: 200,
                        left: coinInScreen ? coinLeft : obstacleLeft,
                        child: coinInScreen
                            ? Image.asset(height: 40, 'assets/images/coin.png')
                            : Image.asset(
                                height: 40,
                                'assets/images/obstacle.png',
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 200,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: size.width,
                            height: 200,
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
