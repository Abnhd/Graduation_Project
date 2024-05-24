import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Shared with ChangeNotifier {
  static String? token;
  static String? role;
  int? currentTabIndex = 0;

  static Future<SharedPreferences> getinstains() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  Future<void> getrole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
  }

  static Future<void> retrieveinfo() async {
    var pref = await getinstains();
    token = pref.getString("token");
    role = pref.getString("role");
  }

  static Future<void> reset() async {
    var sp = await getinstains();
    sp.clear();
  }
  //   static Future<void> update(String newtoken,String newrole) async {
  //   var pref = await getinstains();
  //    pref.setString("token",newtoken);
  //    pref.setString("role",newrole);
  // }
}

class DrawerHelper {
  static const String selectedTabIndexKey = 'selectedTabIndex';
  static const String activeColorKey = 'activeColor';

  static Future<void> saveDrawerState(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(selectedTabIndexKey, index);
    await prefs.setInt(activeColorKey, color.value);
  }

  static Future<Map<String, dynamic>> getDrawerState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt(selectedTabIndexKey) ?? 0;
    int colorValue = prefs.getInt(activeColorKey) ?? Colors.blue.value;
    Color color = Color(colorValue);
    return {'index': index, 'color': color};
  }
}












// class authoservice {
//   Future<bool> isloggin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return await prefs.getBool('isLoggedIn') ?? false;
//   }

//   Future<void> login() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//   }

//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//   }
// }
