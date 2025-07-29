import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalonDetay extends StatelessWidget {
  final String salonId;

  const SalonDetay({super.key, required this.salonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salon Detay')),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('salonlar')
            .doc(salonId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          final salonData = snapshot.data?.data();

          if (salonData == null) {
            return const Center(child: Text('Salon verisi bulunamadı.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                InfoRow(label: 'Salon Adı', value: salonData['salon_adi']),
                InfoRow(label: 'ID', value: salonData['id']),
                InfoRow(label: 'Şehir', value: salonData['il']),
                InfoRow(label: 'İlçe', value: salonData['ilce']),
                InfoRow(label: 'Kurum', value: salonData['kurum']),
                InfoRow(
                  label: 'Durum',
                  value: salonData['active'] == true ? 'Aktif' : 'Pasif',
                ),
                InfoRow(
                  label: 'Oluşturulma Tarihi',
                  value: salonData['tarih'] != null
                      ? (salonData['tarih'] as Timestamp).toDate().toString()
                      : 'Tarih yok',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 3, child: Text(value ?? '-')),
        ],
      ),
    );
  }
}
