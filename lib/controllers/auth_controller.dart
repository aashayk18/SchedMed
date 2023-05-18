import 'package:flutter_to_do_app/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ui/welcome_page.dart';

class AuthController extends GetxController {
  // authcontroller instance..
  static AuthController instance = Get.find();
  //email , password , name....
  late Rx<User?> _user;
  // creating variable for firebase authentication module
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth
        .userChanges());
    // bind the user with the stream and our user would be notified
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("Login Page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => WelcomePage());
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About User",
        "User Message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account Creation Failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void signIn(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About User",
        "User Message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Sign-in Failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void logOut() async {
    await auth.signOut();
  }

}
