import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
class authoservice{
  Future<bool> isloggin()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
  return  await prefs.getBool('isLoggedIn') ?? false;
  }
  Future<void> login()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
  }
    Future<void> logout()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
  }
}