import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  final bool isColapsed;

  const CustomDrawerHeader({
    Key? key,
    required this.isColapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "img/madrsatylogor.jpg",
              width: 40,
              height: 60,
            ),
          ),
          if (isColapsed) const Spacer(),
          // SizedBox(
          //   width: 10,
          // ),
          if (isColapsed)
            const Expanded(
              flex: 2,
              child: Text(
                'مدرستي',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                maxLines: 1,
              ),
            ),
          if (isColapsed) const SizedBox(width: 10),
          
        ],
      ),
    );
  }
}
