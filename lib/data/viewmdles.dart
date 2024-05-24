import 'package:flutter/material.dart';
import 'package:abeermdrsty/login.dart';
import 'package:abeermdrsty/repository/app_repo.dart';
import 'package:abeermdrsty/repository/online_repo.dart';
import 'package:abeermdrsty/utility/endpoints.dart';

import 'modles.dart';

class Gradvm with ChangeNotifier {
  List<SubjecGrade> allgrad = [];

  loaddata() async {
    await getgrad(OnlineRepo(), source: API_URL.Grads);
  }

  Future<List<SubjecGrade>> getgrad(ApplicationRepo repo,
      {String source = API_URL.Grads}) async {
    try {
      print(source);
      dynamic data = await repo.getData(source: source);
      print("data..$data");
      List<dynamic> post = data;
      allgrad = post.map<SubjecGrade>((e) => SubjecGrade.fromJson(e)).toList();
      return allgrad;
    } catch (ex) {
      print("error  $ex");
      return [];
    }
  }
}

class Lessonvm with ChangeNotifier {
  List<Lessone> lessons = [];

  loaddata() async {
    await getlesson(OnlineRepo(), source: API_URL.Grads);
  }

  Future<List<Lessone>> getlesson(ApplicationRepo repo,
      {String source = API_URL.Grads}) async {
    try {
      print(source);
      dynamic data = await repo.getData(source: source);
      // print("data..$data");
      List<dynamic> post = data;
      // print(post);
      lessons = post.map<Lessone>((e) => Lessone.fromJson(e)).toList();
      // print(lessons);
      return lessons;
    } catch (ex) {
      print("error  $ex");
      return [];
    }
  }
}

class Notificationmanagervm with ChangeNotifier {
  List<Notificationmanager> notification = [];

  loaddata() async {
    await getnotification(OnlineRepo(), source: API_URL.Grads);
  }

  Future<List<Notificationmanager>> getnotification(ApplicationRepo repo,
      {String source = API_URL.Grads}) async {
    try {
      print(source);
      dynamic data = await repo.getData(source: source);
      // print("data..$data");
      List<dynamic> post = data;
      // print(post);
      notification = post
          .map<Notificationmanager>((e) => Notificationmanager.fromJson(e))
          .toList();
      // print(lessons);
      return notification;
    } catch (ex) {
      print("error  $ex");
      return [];
    }
  }
}

class Daryvm with ChangeNotifier {
  List<Dary> daries = [];

  loaddata() async {
    await getdary(OnlineRepo(), source: API_URL.Grads);
  }

  Future<List<Dary>> getdary(ApplicationRepo repo,
      {String source = API_URL.Grads}) async {
    try {
      print(source);
      dynamic data = await repo.getData(source: source);
      // print("data..$data");
      List<dynamic> post = data;
      // print(post);
      daries = post.map<Dary>((e) => Dary.fromJson(e)).toList();
      // print(lessons);
      return daries;
    } catch (ex) {
      print("error  $ex");
      return [];
    }
  }
}

class Assigmentvm with ChangeNotifier {
  List<Assigment> assign = [];

  loaddata() async {
    await getassigment(OnlineRepo(), source: API_URL.Grads);
  }

  Future<List<Assigment>> getassigment(ApplicationRepo repo,
      {String source = API_URL.Grads}) async {
    try {
      print(source);
      dynamic data = await repo.getData(source: source);
      // print("data..$data");
      List<dynamic> post = data;
      // print(post);
      assign = post.map<Assigment>((e) => Assigment.fromJson(e)).toList();
      // print(lessons);
      return assign;
    } catch (ex) {
      print("error  $ex");
      return [];
    }
  }
}

class Termstvm with ChangeNotifier {
  List<Terms> term = [];

  loaddata() async {
    await getterm(OnlineRepo(), source: API_URL.Grads);
  }

  Future<List<Terms>> getterm(ApplicationRepo repo,
      {String source = API_URL.Grads}) async {
    try {
      print(source);
      dynamic data = await repo.getData(source: source);
      // print("data..$data");
      List<dynamic> post = data;
      // print(post);
      term = post.map<Terms>((e) => Terms.fromJson(e)).toList();
      // print(lessons);
      return term;
    } catch (ex) {
      print("error  $ex");
      return [];
    }
  }
}

class Libraryvm with ChangeNotifier {
  List<Library> library = [];

  loaddata() async {
    await getlibrary(OnlineRepo(), source: API_URL.Grads);
  }

  Future<List<Library>> getlibrary(ApplicationRepo repo,
      {String source = API_URL.Grads}) async {
    try {
      print(source);
      dynamic data = await repo.getData(source: source);
      // print("data..$data");
      List<dynamic> post = data;
      // print(post);
      library = post.map<Library>((e) => Library.fromJson(e)).toList();
      // print(lessons);
      return library;
    } catch (ex) {
      print("error  $ex");
      return [];
    }
  }
}
