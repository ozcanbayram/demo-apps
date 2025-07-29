import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Bu sayfaları kendi içinde tanımlamalısın veya başka dosyalardan import etmelisin.
import 'hoca.dart';
import 'tekniker.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _girisYapVeYonlendir() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      // Firestore'dan kullanıcı bilgilerini al
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final role = userDoc['role'] as String;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(' $role girişi başarılı')));

        if (role == 'hoca') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Hoca()),
          );
        } else if (role == 'tekniker') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Tekniker()),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tanımsız rol.')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kullanıcı verisi bulunamadı.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Bir hata oluştu: ${e.message}';
      if (e.code == 'user-not-found') {
        message = 'Kullanıcı bulunamadı';
      } else if (e.code == 'wrong-password') {
        message = 'Hatalı şifre';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      print(message);
    } catch (e) {
      print('Genel hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bilinmeyen bir hata oluştu.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _girisYapVeYonlendir,
                child: const Text('Giriş Yap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
