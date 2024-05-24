import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool hasHomework;

  const CustomGradientButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    this.hasHomework = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = hasHomework
        ? [Colors.blueGrey.shade900, Colors.blue.shade900, Colors.blue.shade300]
        : [Colors.grey, Colors.grey, Colors.grey];

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: gradientColors,
        ),
      ),
      child: ElevatedButton(
        onPressed: hasHomework ? onPressed : null,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent, // Set transparent background
          elevation: 0, // Remove elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
