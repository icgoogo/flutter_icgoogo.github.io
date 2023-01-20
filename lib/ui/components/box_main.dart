import 'package:flutter/material.dart';

class BoxMain extends StatelessWidget {
  const BoxMain({
    Key? key,
    required this.playerX,
    required this.playerY,
  }) : super(key: key);

  final double playerX;
  final double playerY;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
                alignment: Alignment(playerX, playerY),
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Container(
                    color: Colors.blue,
                    height: 50.0,
                    width: 50.0,
                  ),
                ))
          ],
        ));
  }
}
