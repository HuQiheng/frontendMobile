import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'initial_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Logger logger = Logger();

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    logger.d("Username: $username");
  }

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3), // Loading screen timeout
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            // If we have any token registered already on the app we skip to the initialPage
            builder: (context) =>
                const InitialPage()), // Screen to which it is redirected
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png', height: 175.0),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
