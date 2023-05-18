import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/ui/widgets/button.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'home_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);
  var emailController = TextEditingController();

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
          const SizedBox(
            height: 80,
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Center(
                  child: Text(
                    "Welcome!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "You have successfully logged in.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const HomePage());
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
                  "Proceed",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              AuthController.instance.logOut();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 100, left: 100),
              width: w * 0.5,
              height: h * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.red,
              ),
              child: const Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            ),
        ],
      ),
    );
  }
}
