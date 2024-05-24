import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/drawer/custom_list_tile.dart';
import 'package:abeermdrsty/utility/shared.dart';
import 'package:abeermdrsty/view/teacher/book.dart';
import 'package:abeermdrsty/view/teacher/components/drawer/bottom_user_info.dart';
import 'package:abeermdrsty/constant/drawer/header.dart';
import 'package:abeermdrsty/view/teacher/notesteachers.dart';
import 'package:abeermdrsty/view/teacher/tabbar/classtab/desctutionT/tdescution.dart';
import 'package:abeermdrsty/view/teacher/tabbar/classtab/diaryclass/diaryclass.dart';
import 'package:abeermdrsty/view/teacher/tabbar/classtab/grads/grads.dart';
import 'package:abeermdrsty/view/teacher/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:abeermdrsty/view/teacher/tabbar/classtab/questionfromstudents/question.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../attendteacher.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;
  int _currentTabIndex = 0;
  int _selectedTabIndex = 0; // Now persisted
  Color activeColor = Colors.grey.shade400;

  // ... other code

  @override
  void initState() {
    super.initState();
    _loadSelectedTabIndex();
  }

  void _loadSelectedTabIndex() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedTabIndex = prefs.getInt('selectedTabIndex') ?? 0;
    setState(() {});
  }

  void _onTabChanged(int newIndex) async {
    final prefs = await DrawerHelper.getDrawerState();
    activeColor = prefs['color'];
    setState(() {
      _currentTabIndex = newIndex;
      _selectedTabIndex = newIndex;
      this.activeColor = activeColor;
    });
    await DrawerHelper.saveDrawerState(newIndex, activeColor);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (_isCollapsed) {
              setState(() {
                _isCollapsed = false;
              });
            } else {
              setState(() {
                _isCollapsed = true;
              });
            }
          },
          child: AnimatedContainer(
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 500),
            width: _isCollapsed ? 300 : 70,
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade700,
                  Colors.blue.shade700,
                  Colors.blue.shade900
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDrawerHeader(isColapsed: _isCollapsed),
                  const Divider(
                    color: Colors.grey,
                  ),
                    CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.book_sharp,
                    title: 'الكتاب',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(0);
                      await DrawerHelper.saveDrawerState(0, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: book(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 0,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                      CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.book_sharp,
                    title: 'التقرير اليومي',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(1);
                      await DrawerHelper.saveDrawerState(1, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: notesteachers(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 1,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.notifications,
                    title: 'الأشعارات',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(2);
                      await DrawerHelper.saveDrawerState(2, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: descutiont(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex ==
                        2, // Use persisted _selectedTabIndex
                    activeColor: activeColor,
                  ),
                
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.grading_sharp,
                    title: 'الدرجات',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(3);
                      await DrawerHelper.saveDrawerState(3, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: StudentMarksPage(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 3,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.note_alt_rounded,
                    title: ' الواجبات',
                    infoCount: 8,
                    onPressed: () async {
                      _onTabChanged(4);
                      await DrawerHelper.saveDrawerState(4, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: NotificationPage(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 4,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.note,
                    title: 'الشروحات',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(5);
                      await DrawerHelper.saveDrawerState(5, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: diary(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 5,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.question_answer,
                    title: 'الاسئله',
                    infoCount: 2,
                    onPressed: () async {
                      _onTabChanged(6);
                      await DrawerHelper.saveDrawerState(6, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: ViewQuestion(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 6,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
            
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  BottomUserInfo(isCollapsed: _isCollapsed),
                  Align(
                    alignment: _isCollapsed
                        ? Alignment.bottomLeft
                        : Alignment.bottomCenter,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(
                        _isCollapsed
                            ? Icons.arrow_back_ios
                            : Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          _isCollapsed = !_isCollapsed;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
