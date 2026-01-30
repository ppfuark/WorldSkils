import 'dart:async';
import 'dart:math'; // Importante para a aleatoriedade
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // --- Estados do Jogo ---
  bool isPaused = false;
  int coinCount = 0;
  int seconds = 0;
  bool skiJumped = false;
  final Random _random = Random();

  // --- Lógica de Tempo ---
  Timer? gameClock;
  final stopwatch = Stopwatch();

  // --- Lógica de Objetos (Obstáculos e Moedas) ---
  bool obstacleInScreen = false;
  double obstacleLeft = 1000;
  double obstacleHeight = 60;

  bool coinVisible = false;
  double coinLeft = 1000;
  double coinHeight = 60;

  double gameSpeed = 7.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resetObstacle();
      startGameLoop();
    });
  }

  void startGameLoop() {
    stopwatch.start();
    gameClock = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isPaused) {
        updateGame();
      }
    });
  }

  void updateGame() {
    setState(() {
      seconds = stopwatch.elapsed.inSeconds;

      // 1. Movimentação do Obstáculo
      if (obstacleInScreen) {
        obstacleLeft -= gameSpeed;
        obstacleHeight += 0.8; 
        if (obstacleLeft < -80) {
          obstacleInScreen = false;
          _decideNextSpawn(); // Quando o obstáculo sai, decide o que vem próximo
        }
        checkCollision();
      }

      // 2. Movimentação da Moeda
      if (coinVisible) {
        coinLeft -= gameSpeed;
        coinHeight += 0.8;
        if (coinLeft < -80) {
          coinVisible = false;
          _decideNextSpawn();
        }
        checkCoinCollection();
      }
    });
  }

  // Escolhe aleatoriamente o que vai aparecer e em quanto tempo
  void _decideNextSpawn() async {
    // Espera um tempo aleatório entre 0.5 e 1.5 segundos para o próximo item
    int delay = 500 + _random.nextInt(1000);
    await Future.delayed(Duration(milliseconds: delay));
    
    if (!mounted || isPaused) return;

    setState(() {
      // 60% de chance de ser obstáculo, 40% de ser moeda
      if (_random.nextDouble() > 0.4) {
        resetObstacle();
      } else {
        spawnCoin();
      }
    });
  }

  void resetObstacle() {
    final size = MediaQuery.of(context).size;
    obstacleLeft = size.width + 50;
    obstacleHeight = 60;
    obstacleInScreen = true;
    coinVisible = false; // Garante que não tenha moeda junto
  }

  void spawnCoin() {
    final size = MediaQuery.of(context).size;
    coinLeft = size.width + 50;
    // A moeda pode aparecer um pouco mais alta ou baixa (aleatório)
    coinHeight = 60;
    coinVisible = true;
    obstacleInScreen = false;
  }

  void checkCollision() {
    final size = MediaQuery.of(context).size;
    final userLocation = size.width * 0.4;
    double margin = size.width * 0.08;

    if ((obstacleLeft - userLocation).abs() < margin && !skiJumped) {
      pauseGame();
    }
  }

  void checkCoinCollection() {
    final size = MediaQuery.of(context).size;
    final userLocation = size.width * 0.4;
    double margin = size.width * 0.08;

    // Se o jogador encostar na moeda (pulando ou no chão)
    if ((coinLeft - userLocation).abs() < margin) {
      // Verifica se a altura do jogador bate com a da moeda
      double playerHeight = skiJumped ? 200 : 110;
      if ((coinHeight - playerHeight).abs() < 50) {
        setState(() {
          coinCount++;
          coinVisible = false; // Moeda "coletada"
          _decideNextSpawn();
        });
      }
    }
  }

  void pauseGame() {
    setState(() {
      isPaused = true;
      stopwatch.stop();
    });
  }

  @override
  void dispose() {
    gameClock?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userLocation = size.width * 0.4;

    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            SafeArea(child: _buildHUD()),
            _buildGameScene(size, userLocation),
          ],
        ),
      ),
    );
  }

  Widget _buildHUD() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Image.asset(isPaused ? 'assets/icons/play.png' : 'assets/icons/pause.png', width: 40),
                onPressed: () => setState(() {
                  isPaused = !isPaused;
                  isPaused ? stopwatch.stop() : stopwatch.start();
                }),
              ),
              Text("$seconds S", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/images/coin.png', width: 25),
              Text(" $coinCount", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameScene(Size size, double userLocation) {
    return Positioned(
      bottom: 0, left: 0, right: 0, height: size.height * 0.5,
      child: GestureDetector(
        onTap: () async {
          if (skiJumped || isPaused) return;
          setState(() => skiJumped = true);
          await Future.delayed(const Duration(milliseconds: 800));
          if (mounted) setState(() => skiJumped = false);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: Image.asset('assets/images/trees.png', fit: BoxFit.cover)),
            Positioned(
              bottom: 0, left: 0, right: 0, height: 160,
              child: ClipPath(clipper: SlopeClipper(), child: Container(color: Colors.white)),
            ),

            // Moeda (Aparece se coinVisible for true)
            if (coinVisible)
              Positioned(
                bottom: coinHeight,
                left: coinLeft,
                child: Image.asset('assets/images/coin.png', width: 35),
              ),

            // Obstáculo
            if (obstacleInScreen)
              Positioned(
                bottom: obstacleHeight,
                left: obstacleLeft,
                child: Image.asset('assets/images/obstacle.png', width: 60),
              ),

            // Jogador
            Positioned(
              bottom: skiJumped ? 200 : 110,
              left: userLocation,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(10 / 360),
                child: Image.asset('assets/images/skiing_person.png', width: 100),
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
    path.moveTo(0, 0); 
    path.lineTo(size.width, size.height * 0.6); 
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}