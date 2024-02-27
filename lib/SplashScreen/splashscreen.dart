import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendors_app/authentication/auth_screen.dart';
import 'package:vendors_app/global/global.dart';
import 'package:vendors_app/mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 8), () async {
      // if seller is already login
      if (firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      }
      // if seller is not already login
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/vegetable consumers.jpg"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Customer Interface",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
