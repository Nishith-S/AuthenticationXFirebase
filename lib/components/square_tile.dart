import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String message;
  final Function()? onTap;
  const SquareTile({super.key, required this.imagePath, required this.onTap, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: message,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.081,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200
          ),
          child: Image.asset(imagePath, height: 72,),
        ),
      ),
    );
  }
}