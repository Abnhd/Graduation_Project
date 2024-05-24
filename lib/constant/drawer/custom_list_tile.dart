
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomListTile extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String title;
  final IconData? doHaveMoreOptions;
  final int infoCount;
  final bool isTabSelected;
  final VoidCallback onPressed;
  final Color activeColor;

  const CustomListTile(
      {Key? key,
      required this.isCollapsed,
      required this.icon,
      required this.title,
      this.doHaveMoreOptions,
      required this.infoCount,
      required this.isTabSelected,
      required this.onPressed,
      required this.activeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isTabSelected ? activeColor : Colors.transparent, // Set the background color
      child: InkWell(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: isCollapsed ? 300 : 80,
          height: 40,
          child: Row(
            children: [
              // icon
              Expanded(
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(icon, color: Colors.white),
                      if (infoCount > 0)
                        Positioned(
                          right: -5,
                          top: -5,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // text
              if (isCollapsed) const Spacer(),
              if (isCollapsed)
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              // arrow near the text title
              if (isCollapsed) const SizedBox(width: 10),
              if (isCollapsed)
                Expanded(
                  flex: 1,
                  child: doHaveMoreOptions != null
                      ? IconButton(
                          icon: Icon(
                            doHaveMoreOptions,
                            color: isTabSelected
                                ? Colors.grey
                                : Colors.white, // Set the icon color
                          ),
                          onPressed: () {
                            // Handle the arrow button press
                          },
                        )
                      : SizedBox(), // Optional: Hide the icon if not needed
                ),
            ],
          ),
        ),
      ),
    );
  }
}


