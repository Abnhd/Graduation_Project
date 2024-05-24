import 'package:flutter/material.dart';

Map<String, dynamic> loginMap(String username, String password) {
  String usern = 'g';
  String pass = '11111111';
  if (username == usern && password == pass) {
    return { 
      "message": null,
      "isAuthenticated": true,
      "username": usern, 
      "email": "A",
      "role": "teacher",
      "token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJqdGkiOiIwN2Q2N2NlNC05ZTNkLTRlZmItYTExZC01OWJjNWQwN2EzMWEiLCJleHAiOjE3MTc1MDA4MDAsImlzcyI6IlNlY3VyZUFwaSIsImF1ZCI6IlNlY3VyZUFwaVVzZXIifQ.9W6LrtICi4ENxbVqS4LzXVubv4m1B2vMTJAdOkyCijc",
      "expiresOn": "2024-06-04T11:33:20Z"
    };
  } 
  else {
    return {
      "isAuthenticated": false,
      "token": null, 
    };
  }
}


