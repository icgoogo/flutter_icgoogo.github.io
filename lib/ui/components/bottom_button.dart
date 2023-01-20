import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const BottomButton({required this.icon, required this.onPressed, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          )),
      child: Icon(
        icon,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}
