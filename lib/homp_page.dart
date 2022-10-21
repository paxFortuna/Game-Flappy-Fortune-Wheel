import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_flappy_fortune_wheel/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double wheelYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;

  // let g = 9.8;
  // v = 5;
  // acceleration : y = -g;
  // velocity : y - -gt + v;
  // height : y = -gt^/2 + vt;
  // y = -4.9t^ + 5t;
  void jump() {
    initialHeight = wheelYaxis;

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        wheelYaxis = initialHeight - height;
      });
      if(wheelYaxis > 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: jump,
              child: AnimatedContainer(
                alignment: Alignment(0, wheelYaxis),
                duration: const Duration(milliseconds: 0),
                color: Colors.blue,
                child: MyBird(),
              ),
            ),
          ),
          Expanded(child: Container(color: Colors.green)),
        ],
      ),
    );
  }
}
