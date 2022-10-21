import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_flappy_fortune_wheel/barrier.dart';
import 'package:game_flappy_fortune_wheel/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double wheelYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = wheelYaxis;
  bool gameHasStarted = false;

  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 2;

  double score = 0;
  double highscore = 10;

  // let g = 9.8;
  // v = 5;
  // acceleration : y = -g;
  // velocity : y - -gt + v;
  // height : y = -gt^/2 + vt;
  // y = -4.9t^ + 5t;

  void jump() {
    time = 0;
    initialHeight = wheelYaxis;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        wheelYaxis = initialHeight - height;
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
        score += 0.1;
   });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (wheelYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, wheelYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const MyBird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const Text("")
                        : const Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                  ),

                  // 중앙 하단 장벽
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 150.0,
                    ),
                  ),

                  // 중앙 상단 장벽
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 200.0,
                    ),
                  ),

                  // 중앙 상단 장벽
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 200.0,
                    ),
                  ),

                  // 우상 상단 장벽
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  // 우 하단 장벽
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 150.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "SCORE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "BEST",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "10",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Text(
              "GAME OVER",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Score: $score",
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // if (score > highscore) {
                    //   highscore = score;
                    // }
                    // initState();
                    // setState(() {
                    //   gameHasStarted = false;
                    // });
                    Navigator.of(context).pop();
                    if (gameHasStarted) {
                      jump();
                    } else {
                      startGame();
                    }
                    },
                  child: const Text("PLAY AGAIN")),
            ],
          );
        });
  }
}
