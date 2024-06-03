

import 'dart:io';


import 'package:abeermdrsty/view/student/lesson.dart';
import 'package:abeermdrsty/view/teacher/report.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:abeermdrsty/loadpage.dart';
import 'package:abeermdrsty/view/manager/bttommanager.dart';
import 'package:abeermdrsty/view/manager/notivicatio.dart';

import 'package:abeermdrsty/view/student/bottomnav.dart';
import 'package:abeermdrsty/view/student/viewassigment.dart';
import 'package:abeermdrsty/view/teacher/tabbar/tabsbar.dart';
import 'package:provider/provider.dart';



import 'data/viewmdles.dart';
import 'login.dart';




import 'utility/shared.dart';
import 'view/parent/bottomnav.dart';

import 'view/teacher/tabbar/classtab/desctutionT/tdescution.dart';
import 'view/teacher/tabbar/classtab/diaryclass/diaryclass.dart';
import 'view/teacher/tabbar/classtab/questionfromstudents/question.dart';

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
 await Shared.retrieveinfo();
//  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Shared()),
          ChangeNotifierProvider(create: (ctx) => Gradvm()),
          ChangeNotifierProvider(create: (ctx) => Lessonvm()),
          ChangeNotifierProvider(create: (ctx) => Notificationmanagervm()),
          ChangeNotifierProvider(create: (ctx) => Daryvm()),
          ChangeNotifierProvider(create: (ctx) => Assigmentvm()),
          ChangeNotifierProvider(create: (ctx) => Termstvm())
        ],
        child: MaterialApp(
          
          debugShowCheckedModeBanner: false,
        
        
          home:diary(),
        ));  
  } 

  Widget ChechAuth() {
    Shared.retrieveinfo();
    print(Shared.role);
    if (Shared.role == "Admin") {
      return tabsmanager();
    } else if (Shared.role == "student") {
      return TabStudent();
    }
    return TabStudent();
  }
}
