import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icgoogo/ui/components/bottom_button.dart';

import 'box_main.dart';

class BottomGame extends StatefulWidget {
  const BottomGame({Key? key}) : super(key: key);

  @override
  BottomGameState createState() => BottomGameState();
}

class BottomGameState extends State<BottomGame> {
  double playerX = 0;
  double playerY = 1;
  bool isDownward = false;

  void moveLeft() {
    setState(() {
      if (playerX - 0.05 < -1) {
        return;
      }
      playerX -= 0.05;
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.05 > 1) {
        return;
      }
      playerX += 0.05;
    });
  }

  void jump() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (playerY - 0.05 < 0) {
          isDownward = true;
          playerY += 0.05;
          return;
        }
        if (isDownward) {
          if (playerY + 0.05 > 1) {
            isDownward = false;
            timer.cancel();
            return;
          }
          playerY += 0.05;
          return;
        }
        playerY -= 0.05;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          jump();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: BoxMain(playerX: playerX, playerY: playerY),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomButton(
                      icon: Icons.keyboard_arrow_left,
                      onPressed: () {
                        moveLeft();
                      }),
                  BottomButton(
                      icon: Icons.keyboard_arrow_up,
                      onPressed: () {
                        jump();
                      }),
                  BottomButton(
                      icon: Icons.keyboard_arrow_right,
                      onPressed: () {
                        moveRight();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
