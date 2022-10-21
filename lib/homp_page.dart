import 'package:flutter/material.dart';
import 'package:game_flappy_fortune_wheel/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
              child: MyBird(),
            ),
          ),
          Expanded(child: Container(color: Colors.green)),
        ],
      ),
    );
  }
}
