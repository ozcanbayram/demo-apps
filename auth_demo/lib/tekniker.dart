import 'package:auth_demo/login.dart';
import 'package:auth_demo/salon_detay.dart';
import 'package:auth_demo/salon_olustur.dart';
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
  String selectedSegment = 'Arıza Kayıtları';
  String? selectedDistrict;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchUserData() {
    if (currentUser == null) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: ListTile(
                    title: Text(name, style: const TextStyle(fontSize: 20)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'Arıza Kayıtları',
                      label: Text('Arıza Kayıtları'),
                    ),
                    ButtonSegment(
                      value: 'Yaklaşan Bakımlar',
                      label: Text('Yaklaşan Bakımlar'),
                    ),
                    ButtonSegment(value: 'Salonlar', label: Text('Salonlar')),
                  ],
                  selected: {selectedSegment},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      selectedSegment = newSelection.first;
                      if (selectedSegment != 'Salonlar') {
                        selectedDistrict = null;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (selectedSegment == 'Salonlar') {
                      if (selectedDistrict == null) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('salonlar')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Hata: ${snapshot.error}'),
                              );
                            }
                            final salonDocs = snapshot.data!.docs;
                            if (salonDocs.isEmpty) {
                              return const Center(
                                child: Text('Henüz hiç salon eklenmemiş.'),
                              );
                            }
                            final uniqueDistricts = <String>{};
                            for (var doc in salonDocs) {
                              final data = doc.data() as Map<String, dynamic>;
                              final district = data['ilce'] ?? '';
                              if (district.isNotEmpty) {
                                uniqueDistricts.add(district);
                              }
                            }
                            final sortedDistricts = uniqueDistricts.toList()
                              ..sort();
                            return ListView.builder(
                              itemCount: sortedDistricts.length,
                              itemBuilder: (context, index) {
                                final district = sortedDistricts[index];
                                final initial = district.isNotEmpty
                                    ? district[0].toUpperCase()
                                    : '?';
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text(
                                        initial,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(district),
                                    // TODO Subtitle --> city name (optional)
                                    subtitle: Text(
                                      '$district ilçesindeki salonlar',
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedDistrict = district;
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      setState(() {
                                        selectedDistrict = null;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      '$selectedDistrict ilçesindeki salonlar',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('salonlar')
                                    .where('ilce', isEqualTo: selectedDistrict)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Hata: ${snapshot.error}'),
                                    );
                                  }
                                  final salonDocs = snapshot.data!.docs;
                                  if (salonDocs.isEmpty) {
                                    return Center(
                                      child: Text(
                                        '$selectedDistrict ilçesinde salon bulunamadı.',
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    itemCount: salonDocs.length,
                                    itemBuilder: (context, index) {
                                      final salon =
                                          salonDocs[index].data()
                                              as Map<String, dynamic>;
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Text(
                                              selectedDistrict![0]
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            salon['salon_adi'] ??
                                                'Salon adı yok',
                                          ),
                                          subtitle: Text(
                                            '${salon['il'] ?? '-'} / ${salon['ilce'] ?? '-'}',
                                          ),
                                          trailing: Text(
                                            salon['id'] ?? 'ID yok',
                                          ),
                                          onTap: () {
                                            final salonId = salonDocs[index].id;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SalonDetay(
                                                      salonId: salonId,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          '$selectedSegment sayfası gösteriliyor...',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SalonOlustur()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
