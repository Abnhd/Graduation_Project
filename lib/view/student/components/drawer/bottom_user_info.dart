
import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/view/student/subjectname.dart';


class BottomUserInfo extends StatelessWidget {
 
  final bool isCollapsed;

  BottomUserInfo({
    Key? key,
    required this.isCollapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: subjectnamee(),
              );
            },
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isCollapsed ? 70 : 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.school, // Use school icon for class
                      color: Colors.white,
                    ),
                  ),
                ),
                if (isCollapsed) // Show only if not collapsed
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'المواد', // Replace with your class name
                              style: fontwhite.fonttitle,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
