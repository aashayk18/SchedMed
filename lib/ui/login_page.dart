import 'package:flutter_to_do_app/ui/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              width: w,
              height: h * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "images/login.jpg",
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
                  Text(
                    "SchedMed",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Text("Sign In to your account",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500])),
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
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                AuthController.instance.signIn(emailController.text.trim(),
                    passwordController.text.trim());
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
                    "Sign In",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: w * 0.1),
            Center(
              child: RichText(
                  text: TextSpan(
                text: "Don't have an account?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                      text: " Create",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignUpPage()))
                ],
              )),
            ),
          ],
        ));
  }
}
