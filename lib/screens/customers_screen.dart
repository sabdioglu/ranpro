import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Müşteriler', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Müşteri ara...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                suffixIcon: Icon(Icons.mic, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Filtre Sekmeleri (Tümü, Yeni, Favoriler)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildFilterChip('Tümü (124)', true),
                const SizedBox(width: 8),
                _buildFilterChip('Yeni (8)', false),
                const SizedBox(width: 8),
                _buildFilterChip('Favoriler', false),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Müşteri Listesi
          Expanded(
            child: ListView(
              children: [
                _buildCustomerTile('ED', 'Elif Demir', '0532 123 45 67', 'Son randevu: 18 Eyl 2026', Colors.blue, false),
                _buildCustomerTile('MY', 'Mehmet Yıldız', '0533 987 65 43', 'Son randevu: 18 Eyl 2026', Colors.teal, true),
                _buildCustomerTile('ZK', 'Zeynep Kaya', '0555 668 77 88', 'Son randevu: 18 Eyl 2026', Colors.green, false),
                _buildCustomerTile('AY', 'Ahmet Yılmaz', '0532 111 22 33', 'Son randevu: 16 Eyl 2026', Colors.red, true),
                _buildCustomerTile('SK', 'Selin Karaca', '0541 233 34 44', 'Son randevu: 15 Eyl 2026', Colors.blue, false),
                _buildCustomerTile('DK', 'Derya Koç', '0533 444 55 66', 'Son randevu: 15 Eyl 2026', Colors.red, false),
                _buildCustomerTile('BT', 'Burcu Tekin', '0533 777 88 99', 'Son randevu: 14 Eyl 2026', Colors.purple, false),
                const SizedBox(height: 80), // Alt menü boşluğu
              ],
            ),
          ),
        ],
      ),
      // Sağ Alt Turuncu Ekle Butonu
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Filtre Butonları Tasarımı
  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF5722) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  // Müşteri Liste Elemanı Tasarımı
  Widget _buildCustomerTile(String initials, String name, String phone, String lastVisit, Color avatarColor, bool isFavorite) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: avatarColor.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: avatarColor.withOpacity(0.5), width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: TextStyle(color: avatarColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(phone, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Text(lastVisit, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
      trailing: Icon(
        isFavorite ? Icons.star : Icons.star_border,
        color: isFavorite ? Colors.amber : Colors.grey[300],
        size: 28,
      ),
      onTap: () {}, // İleride müşteri detay sayfasına yönlendirecek
    );
  }
}
