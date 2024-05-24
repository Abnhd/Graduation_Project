import 'package:flutter/material.dart';

class TeacherClass {
  final String className;
  final int classNumber;

  TeacherClass(this.className, this.classNumber);
}

final List<TeacherClass> teacherClasses = [
  TeacherClass('class one', 1),
  TeacherClass('class two', 2),
  TeacherClass('class two', 2),
  TeacherClass('class two', 2),
  TeacherClass('class two', 2),
  TeacherClass('class two', 2),
  TeacherClass('class two', 2),
  
  // Add more classes as needed
];
