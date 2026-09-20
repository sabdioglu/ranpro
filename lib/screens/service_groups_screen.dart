import 'package:flutter/material.dart';

class ServiceGroupsScreen extends StatelessWidget {
  const ServiceGroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          'Hizmet Grupları',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Sağ Üst Turuncu Artı Butonu
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFF5722),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
      // Orta Kısım: Boş Durum (Empty State) Tasarımı
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Büyük Klasör İkonu
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[200]!, width: 2),
                ),
                child: Icon(
                  Icons.folder_open_rounded,
                  size: 80,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 32),
              
              // Başlık
              const Text(
                'Henüz grup yok',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              
              // Alt Açıklama
              Text(
                'Hizmetlerinizi gruplandırmak için + butonuna tıklayın',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[500],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 60), // Biraz yukarıda durması için alt boşluk
            ],
          ),
        ),
      ),
    );
  }
}
