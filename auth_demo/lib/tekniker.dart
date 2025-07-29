import 'package:auth_demo/login.dart';
import 'package:auth_demo/salon_olustur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//! Tekniker sayfası: Kullanıcı bilgilerini gösterir, segmentlerle farklı içerik sunar
class Tekniker extends StatefulWidget {
  const Tekniker({super.key});

  @override
  State<Tekniker> createState() => _TeknikerState();
}

class _TeknikerState extends State<Tekniker> {
  //! Şu an giriş yapmış kullanıcı bilgisi
  late final User? currentUser;

  //! Seçili segment (sayfa) bilgisi, varsayılan: 'Arıza Kayıtları'
  String selectedSegment = 'Arıza Kayıtları';

  //! 'Salonlar' segmentinde seçilen şehir bilgisi, null ise şehir seçilmemiş demek
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    //! Firebase'den mevcut kullanıcıyı alıyoruz
    currentUser = FirebaseAuth.instance.currentUser;
  }

  //! Kullanıcı bilgilerini Firestore'dan getirmek için async fonksiyon
  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchUserData() {
    if (currentUser == null) {
      //! Eğer kullanıcı yoksa hata fırlatıyoruz (giriş yapılmamış)
      throw Exception('Kullanıcı giriş yapmamış');
    }
    //! Firestore users koleksiyonundan kullanıcı dokümanını çekiyoruz
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
  }

  //! Çıkış yapma fonksiyonu, Firebase oturumu kapatır ve login sayfasına yönlendirir
  void _signOut() async {
    await FirebaseAuth.instance.signOut();

    //! Widget halen aktifse (mounted) login sayfasına yönlendir
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
          //! Çıkış butonu
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: _signOut,
          ),
        ],
      ),

      //! Ana içerik FutureBuilder ile kullanıcı verisini asenkron yükle
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          //! Veriler yüklenirken yükleniyor göstergesi
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //! Eğer hata varsa ekranda göster
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          //! Veriler geldi ama doküman yoksa
          final userDoc = snapshot.data;
          if (userDoc == null || !userDoc.exists) {
            return const Center(child: Text('Kullanıcı verisi bulunamadı.'));
          }

          //! Kullanıcı verisini map olarak alıyoruz
          final data = userDoc.data()!;

          //! Kullanıcıdan çekilen bilgiler, yoksa varsayılan yazı
          final name = data['name'] ?? 'İsim yok';
          final id = snapshot.data!.id;
          final email = data['email'] ?? 'Email yok';
          final role = data['role'] ?? 'Rol yok';
          final manualId = data['id'] ?? 'ID yok';

          //! Sayfanın asıl içeriği Column içinde düzenlenir
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! Kullanıcı bilgileri kartı
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

              //! Segment seçimi için SegmentedButton
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

                  //! Segment değiştiğinde çağrılır
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      selectedSegment = newSelection.first;
                      //! Eğer Salonlar dışına geçilirse seçili şehir sıfırlanır
                      if (selectedSegment != 'Salonlar') {
                        selectedCity = null;
                      }
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              //! Segmentin seçimine göre gösterilen içerik Expanded içinde
              Expanded(
                child: Builder(
                  builder: (context) {
                    //! Eğer segment Salonlar ise özel listeleme yapıyoruz
                    if (selectedSegment == 'Salonlar') {
                      //! Eğer şehir seçilmemişse şehir listesini göster
                      if (selectedCity == null) {
                        //! StreamBuilder ile Firestore salonlar koleksiyonunu dinle
                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('salonlar')
                              .snapshots(),
                          builder: (context, snapshot) {
                            //! Veri beklenirken yükleniyor göstergesi
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            //! Hata varsa göster
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Hata: ${snapshot.error}'),
                              );
                            }

                            //! Gelen salon belgeleri
                            final salonDocs = snapshot.data!.docs;

                            //! Eğer hiç salon yoksa ekrana mesaj göster
                            if (salonDocs.isEmpty) {
                              return const Center(
                                child: Text('Henüz hiç salon eklenmemiş.'),
                              );
                            }

                            //! Şehirleri benzersiz şekilde tutacak set
                            final uniqueCities = <String>{};

                            //! Tüm salonlardan şehir isimlerini topla
                            for (var doc in salonDocs) {
                              final data = doc.data() as Map<String, dynamic>;
                              final city = data['il'] ?? '';
                              if (city.isNotEmpty) {
                                uniqueCities.add(city);
                              }
                            }

                            //! Şehirleri alfabetik sıraya göre listele
                            final sortedCities = uniqueCities.toList()..sort();

                            //! Şehirler listesi gösteriliyor
                            return ListView.builder(
                              itemCount: sortedCities.length,
                              itemBuilder: (context, index) {
                                final city = sortedCities[index];
                                final cityInitial = city.isNotEmpty
                                    ? city[0].toUpperCase()
                                    : '?';

                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: ListTile(
                                    //! Şehir baş harfi avatar içinde
                                    leading: CircleAvatar(
                                      child: Text(
                                        cityInitial,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(city),
                                    //! Sağdaki ok, seçilebilir olduğunu belirtir
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                    ),

                                    //! Şehir seçildiğinde çalışır
                                    onTap: () {
                                      setState(() {
                                        selectedCity = city; //! Şehir seçildi
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        //! Şehir seçildiyse o şehirdeki salonlar listelenir

                        return Column(
                          children: [
                            //! Üstte geri dönmek için geri butonu ve başlık
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  //! Geri butonu, tıklanınca şehir seçimi iptal edilir
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      setState(() {
                                        selectedCity = null; //! Şehiri temizle
                                      });
                                    },
                                  ),

                                  //! Başlık: Seçilen şehrin salonları
                                  Expanded(
                                    child: Text(
                                      '$selectedCity şehirindeki salonlar',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //! Salon listesi, StreamBuilder ile dinleniyor
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('salonlar')
                                    //! Seçilen şehre göre filtrele
                                    .where('il', isEqualTo: selectedCity)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  //! Yüklenme göstergesi
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  //! Hata varsa göster
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Hata: ${snapshot.error}'),
                                    );
                                  }

                                  //! Gelen salon belgeleri
                                  final salonDocs = snapshot.data!.docs;

                                  //! Eğer bu şehirde salon yoksa mesaj göster
                                  if (salonDocs.isEmpty) {
                                    return Center(
                                      child: Text(
                                        '$selectedCity şehrinde salon bulunamadı.',
                                      ),
                                    );
                                  }

                                  //! Salonları listele
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
                                          //! Sol avatarda şehrin baş harfi
                                          leading: CircleAvatar(
                                            child: Text(
                                              selectedCity![0].toUpperCase(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          //! Salon adı
                                          title: Text(
                                            salon['salon_adi'] ??
                                                'Salon adı yok',
                                          ),

                                          //! İl ve ilçe bilgisi alt satırda
                                          subtitle: Text(
                                            '${salon['il'] ?? '-'} / ${salon['ilce'] ?? '-'}',
                                          ),

                                          //! Sağda salonun id'si
                                          trailing: Text(
                                            salon['id'] ?? 'ID yok',
                                          ),
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
                      //! Diğer segmentlerde basit bilgi gösteriyoruz
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

      //! Sayfanın sağ alt köşesindeki + butonu, yeni salon oluşturma sayfasına yönlendirir
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
