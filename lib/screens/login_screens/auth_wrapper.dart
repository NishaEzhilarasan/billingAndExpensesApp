import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/screens/home_screen.dart';
import 'package:flutter_expense_tracker/screens/login_screens/login_screen.dart';
import 'package:flutter_expense_tracker/services/auth_services.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          // If the user is logged in, show the HomeScreen
          if (user == null) {
            // If the user is not logged in, show the LoginScreen
            return LoginScreen();
          } else {
            return HomeScreen();
          }
        } else {
          // While waiting for the connection state, show a loading indicator
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
