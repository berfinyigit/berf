import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sign_up_screen.dart'; // SignUpScreen dosya yolu
import 'log_in_screen.dart'; // LogInScreen dosya yolu
import 'firebase_options.dart';
import 'ana_ekran.dart'; // Ana ekran dosya yolu

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key});

  static bool isLoggedIn = false;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 11, 15, 15),
        hintColor: const Color.fromARGB(255, 169, 164, 211),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 243, 243, 243),
          titleTextStyle: TextStyle(color: Color.fromARGB(255, 16, 15, 15)),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 13, 4, 4)),
        ),
      ),
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoggedIn
            ? AnaEkran()
            : PageView(
                controller: _pageController,
                children: [
                  LogInScreen(
                    controller: _pageController,
                    onTap: () {},
                  ),
                  SignUpScreen(controller: _pageController),
                ],
              ),
      ),
    );
  }
}
