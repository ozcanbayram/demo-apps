import 'package:auth_demo/hoca.dart';
import 'package:auth_demo/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          // Kullanıcı giriş yaptıysa ana sayfaya yönlendir
          return Hoca(); // Kendi ana sayfa widget'ını buraya koy
        }
        // Kullanıcı giriş yapmadıysa login sayfasına yönlendir
        return Login();
      },
    );
  }
}

class HomePage {
}