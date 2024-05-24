import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:abeermdrsty/view/manager/bttommanager.dart';
import 'package:abeermdrsty/view/student/bottomnav.dart';
import 'package:abeermdrsty/view/teacher/tabbar/tabsbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'helper/datab.dart';

// import 'datab.dart';
// import 'sharedprefernces.dart';

class MyTabLogin extends StatefulWidget {
  @override
  State<MyTabLogin> createState() => _MyTabLoginState();
}

class _MyTabLoginState extends State<MyTabLogin> {
  final _formKey = GlobalKey<FormState>();
  var x = true;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade500,
                        Colors.blue.shade300,
                        Colors.indigo.shade800,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              "img/madrsatylogor.jpg",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: user,
                                    decoration: InputDecoration(
                                      labelText: "ادخل اسم المستخدم",
                                      labelStyle: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.blue.shade900,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ادخل اسم المستخدم';
                                      }
                                      if (!RegExp(r'^[a-zA-Z]+$')
                                          .hasMatch(value)) {
                                        return 'اسم المستخدم يجب أن يحتوي على حروف إنجليزية فقط';
                                      }
                                      if (value.length > 15) {
                                        return 'اسم المستخدم يجب أن يكون أقل من أو يساوي 15 حرفًا';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  TextFormField(
                                    controller: pass,
                                    obscureText: x,
                                    decoration: InputDecoration(
                                      labelText: "ادخل كلمه المرور",
                                      labelStyle: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.blue.shade900,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: x
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            x = !x;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 8,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك ادخل كلمة المرور';
                                      }
                                      if (value.length != 8 ||
                                          int.tryParse(value) == null) {
                                        return 'كلمة المرور 8 ارقام فقط';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      Map<String, dynamic>? islogin = null;
                                      if (_formKey.currentState!.validate()) {
                                        SharedPreferences pref = await SharedPreferences
                                                .getInstance();
                                        islogin = await loginMap(
                                            user.text, pass.text);
                                        if (islogin != null &&
                                            islogin['isAuthenticated']) {
                                          String role = islogin['role'];
                                        
                                          pref.setString('token', '${islogin['token']}');
                                          pref.setString('role', '${islogin['role']}');

                                          if (role == 'Admin') {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      tabsmanager()),
                                            );
                                          }
                                          else if (role == 'teacher') {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      tabsbutton()),
                                            );
                                          }
                                          
                                           else if (role == 'student') {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TabStudent()),
                                            );
                                          }
                                            
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    Text("خطأ في تسجيل الدخول"),
                                                content: Text(
                                                    "اسم المستخدم أو كلمة المرور غير صحيحة."),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("موافق"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.indigo.shade500,
                                            Colors.blue.shade300,
                                            Colors.indigo.shade800,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'تسجيل الدخول ',
                                        style: fontwhite.fonttitle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
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

// void checkUserCredentials(String username, String password) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? savedUser = prefs.getString('username');
//     String? savedPassword = prefs.getString('password');

//     if (username == savedUser && password == savedPassword) {
//       // المستخدم مسجل مسبقاً
//       // توجيه المستخدم إلى الشاشة المناسبة
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => TabStudent()), // يجب استبدال هذا بالشاشة المناسبة لطالب
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("خطأ في تسجيل الدخول"),
//             content: Text("اسم المستخدم أو كلمة المرور غير صحيحة."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("موافق"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void saveData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('username', username!);
//     await prefs.setString('password', password!);
// //   }
// await autho.login();
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => TabStudent()),