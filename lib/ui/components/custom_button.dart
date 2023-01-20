import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color bgColor;
  final Text title;
  final Function() onTap;
  const CustomButton({required this.bgColor, required this.title, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 80),
        constraints: BoxConstraints(
          maxWidth: 400,
        ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: Material(
          color: bgColor,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 16.0,
              ),
              child: Center(child: title),
            ),
          ),
        ),
      ),
    );
  }
}
