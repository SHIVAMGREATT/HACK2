import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendors_app/global/global.dart';
import 'package:vendors_app/mainScreens/home_screen.dart';
import 'package:vendors_app/widgets/custom_text_field.dart';
import 'package:vendors_app/widgets/error_dialog.dart';
import 'package:vendors_app/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  formValidation() {
    if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
      //login
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please write Email and Password",
            );
          });
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(
            message: "Checking Credentials",
          );
        });

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return LoadingDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!).then((value) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      });
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      await sharedPreferences!.setString("uid", currentUser.uid);
      await sharedPreferences!
          .setString("email", snapshot.data()!["sellerEmail"]);
      await sharedPreferences!
          .setString("name", snapshot.data()!["sellerName"]);
      await sharedPreferences!
          .setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "images/conusmer logo.jpg",
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailcontroller,
                  hintText: "Email",
                  isObscure: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordcontroller,
                  hintText: "Password",
                  isObscure: true,
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: const Text(
              "Log In",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            onPressed: () {
              formValidation();
            },
          ),
        ],
      ),
    );
  }
}
