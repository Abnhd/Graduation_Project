import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';


import 'package:abeermdrsty/constant/fontstyle.dart';

class Profileteacher extends StatefulWidget {
  @override
  State<Profileteacher> createState() => _ProfileteacherState();
}

class _ProfileteacherState extends State<Profileteacher> {
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  String _password = '12345678'; // Initial password value

  @override
  void initState() {
    super.initState();
    _passwordController.text = _password;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide keyboard when tapping anywhere on the screen
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: "مدرستي",),
        
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("img/biology.jpg"),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                      TextFormField(
                        readOnly: true,
                        initialValue: 'عبير برك بن بشر ',
                        decoration: InputDecoration(
                          labelText: 'اسم المستخدم',
                          labelStyle:fontstyle.fontheading,
                          enabled: false,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController, // Use the controller
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          labelStyle:fontstyle.fontheading,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue.shade900,
                          ),
                          suffixIcon: IconButton(
                            color: Colors.indigo[900]!,
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 8,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigo.shade500,
                                    Colors.blue.shade300,
                                    Colors.indigo.shade800,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'حفظ ',
                                style:fontwhite.fonttitle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _passwordController.text = _password; // Reset to initial password
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.indigo.shade500,
                                    Colors.blue.shade300,
                                    Colors.indigo.shade800,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '  الغاء ',
                                style:fontwhite.fonttitle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
        ),
      ),
    );
  }
}
