import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:abeermdrsty/view/manager/attendmanager.dart';


class SubjectGrade {
  final String subject;
  final List<String> grades;
  final List<String> months;

  SubjectGrade(this.subject, this.grades, this.months);
}
final List<SubjectGrade>   subjectsGrades = [
      SubjectGrade('القران الكريم', ['90', '80', '70'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
      SubjectGrade('الاسلامية', ['85', '75', '65'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
      SubjectGrade('اللغة العربية', ['95', '85', '75'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
      SubjectGrade('العلوم', ['90', '80', '70'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
      SubjectGrade('الرياضيات', ['85', '75', '65'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
      SubjectGrade('الانجليزي', ['95', '85', '75'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
    ];

class Subjectdary {
  final String subject;
  final String title;

  Subjectdary(
    this.subject,
    this.title,
  );

  contains(String query) {}
}

final List<Subjectdary> dary = [
  Subjectdary('القران الكريم', "سورة العلق"),
  Subjectdary('التربية الاسلامية', "الصلاة"),
  Subjectdary('القران الكريم', "سورة الفلق"),
  Subjectdary('التربية الاسلامية', "الوضوء"),
  Subjectdary('القران الكريم', "سورة العلق"),
  Subjectdary('التربية الاسلامية', "الوضوء"),
  Subjectdary('القران الكريم', "سورة العلق"),
  Subjectdary('القران الكريم', "سورة العلق"),
];

class subject {
  final String name;
  final String image;

  subject({
    required this.name,
    required this.image,
  });
}

final List<subject> subj = [
  subject(
    name: 'القران الكريم',
    image: "images/2.jpg",
  ),
  subject(
    name: 'التربية الاسلامية ',
    image: "images/3.jpg",
  ),
  subject(
    name: 'اللغة العربية ',
    image: "images/1.jpg",
  ),
  subject(
    name: 'العلوم ',
    image: "images/4.jpg",
  ),
];

// final Map<String, String> imagesToPages = {
//   'images/2.jpg': 'grads',
//   'images/3.jpg': 'evaluation',
//   "images/1.jpg": 'daryy',
//   "images/4.jpg": 'Profile',
// };
// Widget getWidgetForImage(String image) {
//   switch (image) {
//     case 'images/2.jpg':
//       return WeekCard();

//     case 'images/3.jpg':
//       return WeekCard();
//     case 'images/1.jpg':
//       return WeekCard();
//     case 'images/4.jpg':
//       return WeekCard();
//   }
//   throw Exception('Invalid image name: $image');
// }

class star {
  final String title;
  late int starRating;
  late String ratingText;

  star({
    required this.title,
    required this.starRating,
    required this.ratingText,
  });
}

final List<star> stars = [
  star(title: " الاداء التعليمي", starRating: 0, ratingText: ""),
  star(title: "ايصال المقرر", starRating: 0, ratingText: ""),
  star(title: "التعامل مع الطلاب", starRating: 0, ratingText: ""),
];

class childrens {
  final String name;
  childrens({required this.name});
}

List<childrens> child = [
  childrens(name: "غلا"),
  childrens(name: "حلا"),
  childrens(name: "عبدالله"),
  childrens(name: "اسامه"),
  childrens(name: "مجاهد"),
  childrens(name: "عنود"),
];
final Map<String, String> nameToPage = {
  'غلا': 'TabStudent',
  'حلا': 'evaluation',
  "عبدالله": 'daryy',
  'اسامه': 'grads',
  'مجاهد': 'evaluation',
  "عنود": 'profilep',
};

Widget getWidgetForPage(String pageName) {
  switch (pageName) {
    // case 'TabStudent':
    //   return TabStudent(); // Replace with the actual page widget

    // case 'evaluation':
    //   return WeekCard(); // Replace with the actual page widget

    // case 'daryy':
    //   return WeekCard();
    case 'grads':
      return attendmanager(); // Replace with the actual page widget

    case 'evaluation':
      return attendmanager(); // Replace with the actual page widget

    case 'profilep':
      return attendmanager();

    default:
      throw Exception('Invalid page name: $pageName');
  }
}

class notivication {
  final String name;
  final String titile;
  final String content;
  final String data;

  notivication(
      {required this.titile,
      required this.content,
      required this.name,
      required this.data});
}

List<notivication> noti = [
  notivication(
      titile: "حفلة الاوائل",
      content:
          "غدا ستقيم المدرسة حفلة تدشين تكريم الاوائل غدا ستقيم المدرسة حفلة تدشين تكريم الاوائل",
      name: 'غلا بن بشر',
      data: "2/2/2024"),
  notivication(
      titile: "jjjjjjjjj",
      content: "hhhhhhhhhhhhhhhhh",
      name: 'غلا بن بشر',
      data: "2/2/2024"),
];

class assigment {
  final String name;
  final String titile;
  final String content;
  final String answer;
  final String data;
  final String data2;
  final String grde;
final String grad2;

  assigment(
      {required this.titile,
      required this.content,
      required this.name,
      required this.data,
      required this.data2,
      required this.grde,
      required this.answer,
      required this.grad2});
}

List<assigment> assig = [
  assigment(
      titile: "  درس الصلاة",
      content: " كم عدد الصلوات؟",
      name: 'غلا بن بشر',
      data: "2/2/2024",
      data2: "2/3/2024",
      grde: "10/10",
      answer: "املا الفراغ خطاء ",
      grad2: "5/10"),
  assigment(
      titile: "درس الوضوء",
      content: "عرف الوضوء؟",
      name: 'غلا بن بشر',
      data: "2/2/2024",
      data2: "2/3/2024",
      grde: "20/20",
      answer: "التعريف غلط",
        grad2: "7/10"),
];

class subjec {
  final String subjectName;
  final String imagePath;

  subjec({
    required this.subjectName,
    required this.imagePath,
  });
}

List<subjec> subb = [
  subjec(
    subjectName: 'chemistry',
    imagePath: 'img/science.jpg',
  ),
  subjec(
    subjectName: 'Math',
    imagePath: 'img/math.jpg',
  ),
  subjec(
    subjectName: 'phisics',
    imagePath: 'img/phisics.jpg',
  ),
  subjec(
    subjectName: 'biology',
    imagePath: 'img/biology.jpg',
  ),
  subjec(
    subjectName: 'Arabic',
    imagePath: 'img/arabic.jpg',
  ),
];

class myclass {
  final String title;
  myclass({required this.title});
}

List<myclass> clases = [
  myclass(title: "دفتر المتابعة"),
  myclass(title: " الدرجات"),
  myclass(title: " الاشعارات"),
  myclass(title: "اقتراحاتي "),
  
];
class clase{
  final String title;
  clase({required this.title});
}

List<clase> clas = [
  clase(title: "الصف الاول"),
  clase(title: " الثاني"),
  clase(title: "الصف الثالث"),
  clase(title: "الصف الرابع"),
  clase(title: "الصف الخامس"),
  clase(title: "الصف السادس"),
  clase(title: "الصف السابع"),
  clase(title: "الصف الثامن"),
  clase(title: "الصف التاسع"),
  clase(title: "الصف اول ثانوي"),
  clase(title: "الصف ثاني ثانوي"),
  clase(title: "الصف ثالث ثانوي"),

  
];
class lesson {
  final String name;
  final String titile;

  final String content;
  
  final String data;

  lesson(
      {required this.titile,
      required this.content,
    
      required this.name,
      required this.data});
}

List<lesson> less = [
  lesson(
      titile: "التكامل",
    

      content:
        "شرح الدرس",
      name: 'غلا بن بشر',
      data: "2/2/2024"),
  lesson(
      titile: " الضرب",
      
      content:  "شرح الدرس",
      name: 'غلا بن بشر',
      data: "2/2/2024"),
];
  List<String> _firstTermSubjects = [
    'Subject 1',
    'Subject 2',
    'Subject 3',
    'Subject 3',
    'Subject 1',
    'Subject 2',
    'Subject 3',
    'Subject 3'
  ];
  List<String> _secondTermSubjects = [
    'Subject A',
    'Subject B',
    'Subject C',
    'Subject 3'
  ];
  List<String> _firstTermSubjectImages = [
    'img/biology.jpg',
    'img/quran.jpg',
    'img/eslamic.jpg',
    'img/quran.jpg',
    'img/biology.jpg',
    'img/quran.jpg',
    'img/eslamic.jpg',
    'img/quran.jpg',
  ];
  List<String> _secondTermSubjectImages = [
    'img/biology.jpg',
    'img/english.jpg',
    'img/biology.jpg',
    'img/quran.jpg',
  ];
  List<String> _firstTermPdfPaths = [
    'assets/pdf/subject1.pdf',
    'assets/pdf/subject2.pdf',
    'assets/pdf/subject3.pdf',
    'assets/pdf/subject3.pdf',
    'assets/pdf/subject1.pdf',
    'assets/pdf/subject2.pdf',
    'assets/pdf/subject3.pdf',
    'assets/pdf/subject3.pdf',
  ];
  List<String> _secondTermPdfPaths = [
    'assets/pdf/subjectA.pdf',
    'assets/pdf/subjectB.pdf',
    'assets/pdf/subjectC.pdf',
    'assets/pdf/subject3.pdf',
  ];
  final List<String> days = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس'
  ];

  final Map<String, List<String>> dayToSubjects = {
    'الأحد': ['رياضيات', 'علوم', 'لغة عربية', 'تاريخ', 'جغرافيا', 'فيزياء','قران'],
    'الاثنين': ['تاريخ', 'جغرافيا', 'فيزياء'],
    'الثلاثاء': ['علوم', 'لغة عربية', 'كيمياء'],
    'الأربعاء': ['رياضيات', 'تاريخ', 'فيزياء'],
    'الخميس': ['جغرافيا', 'لغة عربية', 'كيمياء'],
  };
    final List<Map<String, String>> subjects = [
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
      {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
      {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
      {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
  ];
  class Comment {
  final String userName;
  final String avatarUrl;
  final String text;
  final DateTime date;

  Comment({
    required this.userName,
    required this.avatarUrl,
    required this.text,
    required this.date,
  });
}
class Subjectname {
  final String className;
  final int classNumber;

  Subjectname(this.className, this.classNumber);
}

final List<Subjectname> subjectname = [
  Subjectname('قران', 1),
  Subjectname('عربي', 2),
  Subjectname('رياضيات', 2),
  Subjectname('قران', 1),
  Subjectname('عربي', 2),
  Subjectname('رياضيات', 2),

  
  // Add more classes as needed
];
