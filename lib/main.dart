import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/services/theme_services.dart';
import 'package:flutter_to_do_app/splash_screen.dart';
import 'package:flutter_to_do_app/ui/home_page.dart';
import 'package:flutter_to_do_app/ui/login_page.dart';
import 'package:flutter_to_do_app/ui/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'db/db_helper.dart';
import 'package:flutter_to_do_app/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
        home: SplashScreen());
  }
}
