import 'package:auth_demo/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tekniker extends StatefulWidget {
  const Tekniker({super.key});

  @override
  State<Tekniker> createState() => _TeknikerState();
}

class _TeknikerState extends State<Tekniker> {
  late final User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchUserData() {
    if (currentUser == null) {
      // Eğer kullanıcı yoksa boş belge dönebiliriz, ama burası çağrılmamalı normalde
      throw Exception('Kullanıcı giriş yapmamış');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tekniker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: _signOut,
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          final userDoc = snapshot.data;
          if (userDoc == null || !userDoc.exists) {
            return const Center(child: Text('Kullanıcı verisi bulunamadı.'));
          }

          final data = userDoc.data()!;
          final name = data['name'] ?? 'İsim yok';
          final id = snapshot.data!.id;
          final email = data['email'] ?? 'Email yok';
          final role = data['role'] ?? 'Rol yok';
          final manualId = data['id'] ?? 'ID yok';

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: ListTile(
                    title: Text(name, style: const TextStyle(fontSize: 20)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        Text('Name: $name'),
                        Text('Otomotik ID: $id'),
                        Text('Email: $email'),
                        Text('Rol: $role'),
                        Text('Manuel ID: $manualId'),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _signOut,
                child: const Text('Salon Oluştur'),
              ),
            ],
          );
        },
      ),
    );
  }
}
