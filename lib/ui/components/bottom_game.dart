import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icgoogo/ui/components/bottom_button.dart';

import 'box_main.dart';

class BottomGame extends StatefulWidget {
  const BottomGame({super.key});

  @override
  BottomGameState createState() => BottomGameState();
}

class BottomGameState extends State<BottomGame> {
  final FocusNode _focusNode = FocusNode();
  Timer? _jumpTimer;

  double playerX = 0;
  double playerY = 1;
  bool isDownward = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _jumpTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

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
    if (_jumpTimer?.isActive ?? false) return;

    _jumpTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

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

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyUpEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      moveLeft();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      moveRight();
    } else if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.arrowUp)) {
      jump();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
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
