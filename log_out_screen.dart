import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'log_in_screen.dart'; // Giriş ekranı dosya yolu

class LogOutScreen extends StatelessWidget {
  final PageController controller;

  const LogOutScreen({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Out'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              // Oturum kapatma işlemi başarılı olduğunda giriş ekranına yönlendir
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LogInScreen(
                          controller: controller,
                          onTap: () {},
                        )),
              );
            }).catchError((error) {
              // Hata durumunda kullanıcıya bilgi ver
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Log Out'),
                    content: Text('Failed to log out: $error'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            });
          },
          child: Text('Log Out'),
        ),
      ),
    );
  }
}
