import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SalonOlustur extends StatefulWidget {
  const SalonOlustur({super.key});

  @override
  State<SalonOlustur> createState() => _SalonOlusturState();
}

class _SalonOlusturState extends State<SalonOlustur> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _salonAdiController = TextEditingController();
  //TODO final TextEditingController _aciklamaController = TextEditingController();

  String? _secilenIl;
  String? _secilenIlce;
  String? _secilenKurum;

  final Map<String, List<String>> ilceler = {
    'Adana': ['Seyhan', 'Yüreğir', 'Çukurova'],
    'Gaziantep': ['Şahinbey', 'Şehitkamil', 'Oğuzeli'],
    'Urfa': ['Haliliye', 'Eyyübiye', 'Karaköprü'],
  };

  final Map<String, Map<String, List<String>>> kurumlar = {
    'Adana': {
      'Seyhan': ['Seyhan Fit', 'Adana SporLife'],
      'Yüreğir': ['Yüreğir Gym', 'FitZone'],
      'Çukurova': ['Çukurova Spor', 'ProBody'],
    },
    'Gaziantep': {
      'Şahinbey': ['Şahin Gym', 'Fit Antep'],
      'Şehitkamil': ['Şehitkamil Fitness', 'BodyZone'],
      'Oğuzeli': ['Oğuzeli Spor', 'FitCity'],
    },
    'Urfa': {
      'Haliliye': ['Haliliye Gym', 'FitUrfa'],
      'Eyyübiye': ['Eyyübiye Fitness', 'UrfaFit'],
      'Karaköprü': ['Karaköprü Spor', 'GymPark'],
    },
  };

  Future<void> _randomIdOlustur() async {
    final firestore = FirebaseFirestore.instance;
    String id = '';
    bool mevcut = true;

    while (mevcut) {
      id = (Random().nextInt(900000) + 100000).toString();
      final snapshot = await firestore.collection('salonlar').doc(id).get();
      mevcut = snapshot.exists;
    }

    setState(() {
      _idController.text = id;
    });
  }

  Future<void> _salonKaydet() async {
    final firestore = FirebaseFirestore.instance;

    if (_idController.text.isEmpty ||
        _secilenIl == null ||
        _secilenIlce == null ||
        _secilenKurum == null ||
        _salonAdiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurunuz.')),
      );
      return;
    }

    final id = _idController.text;

    final varMi = await firestore.collection('salonlar').doc(id).get();
    if (varMi.exists) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bu ID zaten mevcut!')));
      return;
    }

    await firestore.collection('salonlar').doc(id).set({
      'id': id,
      'il': _secilenIl,
      'ilce': _secilenIlce,
      'kurum': _secilenKurum,
      'salon_adi': _salonAdiController.text,
      //TODO 'aciklama': _aciklamaController.text,
      'tarih': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Salon başarıyla kaydedildi!')),
    );

    _idController.clear();
    _salonAdiController.clear();
    //TODO _aciklamaController.clear();
    setState(() {
      _secilenIl = null;
      _secilenIlce = null;
      _secilenKurum = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salon Oluştur')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _idController,
                    decoration: const InputDecoration(labelText: 'Salon ID'),
                    readOnly: true,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _randomIdOlustur,
                  tooltip: 'ID Oluştur',
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'İl'),
              value: _secilenIl,
              items: ilceler.keys
                  .map((il) => DropdownMenuItem(value: il, child: Text(il)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _secilenIl = value;
                  _secilenIlce = null;
                  _secilenKurum = null;
                });
              },
            ),
            const SizedBox(height: 12),
            if (_secilenIl != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'İlçe'),
                value: _secilenIlce,
                items: ilceler[_secilenIl]!
                    .map(
                      (ilce) =>
                          DropdownMenuItem(value: ilce, child: Text(ilce)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _secilenIlce = value;
                    _secilenKurum = null;
                  });
                },
              ),
            const SizedBox(height: 12),
            if (_secilenIl != null && _secilenIlce != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Kurum'),
                value: _secilenKurum,
                items: kurumlar[_secilenIl]![_secilenIlce]!
                    .map(
                      (kurum) =>
                          DropdownMenuItem(value: kurum, child: Text(kurum)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _secilenKurum = value;
                  });
                },
              ),
            const SizedBox(height: 12),
            TextField(
              controller: _salonAdiController,
              decoration: const InputDecoration(labelText: 'Salon Adı'),
            ),
            const SizedBox(height: 12),
            // TextField(
            //   controller: _aciklamaController,
            //   decoration: const InputDecoration(labelText: 'Açıklama'),
            //   maxLines: 2,
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salonKaydet,
              child: const Text('Salon Oluştur'),
            ),
          ],
        ),
      ),
    );
  }
}
