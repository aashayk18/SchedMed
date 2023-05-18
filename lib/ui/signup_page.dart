import 'package:flutter_to_do_app/controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/ui/login_page.dart';
import 'package:get/get.dart';
import 'package:flutter_to_do_app/services/constants.dart';


class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            width: w,
            height: h * 0.3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "images/signup.png",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                      //onChanged: () {},
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Your E-mail ID',
                          prefixIcon: const Icon(
                            Icons.perm_identity,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Your Password",
                          prefixIcon: const Icon(
                            Icons.password_rounded,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: TextField(
                      controller: phoneController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Phone Number (Family/Caregiver)",
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)))),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              AuthController.instance.register(
                  emailController.text.trim(), passwordController.text.trim());
              phoneNumber = phoneController.text.trim();
              Get.to(() => LoginPage());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 100, left: 100),
              width: w * 0.5,
              height: h * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.green,
              ),
              child: const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "Have an account?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[500],
                    ))),
          )
        ],
      ),
    );
  }
}
