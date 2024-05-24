import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/drawer/custom_list_tile.dart';
import 'package:abeermdrsty/constant/drawer/header.dart';
import 'package:abeermdrsty/utility/shared.dart';
import 'package:abeermdrsty/view/student/comment.dart';
import 'package:abeermdrsty/view/student/components/drawer/bottom_user_info.dart';

import 'package:abeermdrsty/view/student/lesson.dart';
import 'package:abeermdrsty/view/student/pdf.dart';

import 'package:abeermdrsty/view/student/viewassigment.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../info_subject.dart';
import '../../rating.dart';
import '../../viewnotification.dart';
import '../../viewnotivication2.dart';

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
                    icon: Icons.menu_book,
                    title: 'الكتاب',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(0);
                      await DrawerHelper.saveDrawerState(0, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: bookpdf(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex ==
                        0, // Use persisted _selectedTabIndex
                    activeColor: activeColor,
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.assignment,
                    title: 'الواجبات',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(1);
                      await DrawerHelper.saveDrawerState(1, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: viewassigment(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 1,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.notifications_active,
                    title: 'الاشعارات',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(2);
                      await DrawerHelper.saveDrawerState(2, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: viewnotifisuper(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 2,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.star,
                    title: ' التقييم',
                    infoCount: 8,
                    onPressed: () async {
                      _onTabChanged(3);
                      await DrawerHelper.saveDrawerState(3, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: RatingScreen(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 3,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.note,
                    title: 'الشروحات',
                    infoCount: 0,
                    onPressed: () async {
                      _onTabChanged(4);
                      await DrawerHelper.saveDrawerState(4, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: lesson(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 4,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.question_answer,
                    title: 'الاسئله',
                    infoCount: 2,
                    onPressed: () async {
                      _onTabChanged(5);
                      await DrawerHelper.saveDrawerState(5, activeColor);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: CommentPage(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 5,
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
