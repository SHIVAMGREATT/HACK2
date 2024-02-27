import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendors_app/global/global.dart';
import 'package:vendors_app/mainScreens/home_screen.dart';
import 'package:vendors_app/widgets/custom_text_field.dart';
import 'package:vendors_app/widgets/error_dialog.dart';
import 'package:vendors_app/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String sellerImageUrl = "";
  String completeAddress = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please Select an Image",
            );
          });
    } else {
      if (passwordcontroller.text == confirmPasswordcontroller.text) {
        // start uploading the image

        if (confirmPasswordcontroller.text.isNotEmpty &&
            emailcontroller.text.isNotEmpty &&
            namecontroller.text.isNotEmpty &&
            phonecontroller.text.isNotEmpty &&
            locationcontroller.text.isNotEmpty) {
          // start uploading image
          showDialog(
              context: context,
              builder: (c) {
                return LoadingDialog(
                  message: "Registring Account",
                );
              });
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("sellers")
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;

            // save info to firestore database
            authenticateSellerAndSignUp();
          });
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorDialog(
                  message: "Please write required info for registration",
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Password does not match",
              );
            });
      }
    }
  }

  void authenticateSellerAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
      ;
    });
    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);

        // send user to homepage
        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName": namecontroller.text.trim(),
      "sellerAvatarUrl": sellerImageUrl,
      "phone": phonecontroller.text.trim(),
      "address": completeAddress,
      "status": "approved",
      "earnings": 0.0,
      // "lat": position!.latitude,
      // "lng": position!.longitude,
    });

    // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", namecontroller.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage:
                  imageXFile == null ? null : FileImage(File(imageXFile!.path)),
              child: imageXFile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.person,
                  controller: namecontroller,
                  hintText: "Name",
                  isObscure: false,
                ),
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
                CustomTextField(
                  data: Icons.lock,
                  controller: confirmPasswordcontroller,
                  hintText: "Confirm Password",
                  isObscure: true,
                ),
                CustomTextField(
                  data: Icons.phone_android,
                  controller: phonecontroller,
                  hintText: "Phone No.",
                  isObscure: false,
                ),
                CustomTextField(
                  data: Icons.my_location,
                  controller: locationcontroller,
                  hintText: "Vendor Address",
                  isObscure: false,
                  enabled: true,
                ),
                Container(
                  width: 400,
                  height: 40,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: const Text(
                      "Get my current location",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    onPressed: () => print("clicked"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            onPressed: () {
              formValidation();
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
