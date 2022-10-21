import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;

  const MyBarrier({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
        height: size,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}
