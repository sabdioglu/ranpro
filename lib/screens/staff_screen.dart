import 'package:flutter/material.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({Key? key}) : super(key: key);

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
        title: const Text('Personel', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Arama Çubuğu ve Ekle Butonu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Personel ara...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
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
                const SizedBox(width: 12),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5722),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Personel Listesi
          Expanded(
            child: ListView(
              children: [
                _buildStaffTile('AY', 'Ayşe Yılmaz', 'Saç Uzmanı', true, Colors.red),
                _buildStaffTile('MA', 'Mehmet Arslan', 'Erkek Bakım Uzmanı', true, Colors.blue),
                _buildStaffTile('ZD', 'Zeynep Demir', 'Cilt Bakım Uzmanı', true, Colors.orange),
                _buildStaffTile('MK', 'Merve Kaya', 'Manikür - Pedikür', true, Colors.pink),
                _buildStaffTile('EŞ', 'Emre Şahin', 'Masaj Terapisti', true, Colors.deepOrange),
                const SizedBox(height: 80), // Alt menü boşluğu
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Personel Liste Elemanı Tasarımı
  Widget _buildStaffTile(String initials, String name, String specialization, bool isActive, Color avatarColor) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: avatarColor, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: TextStyle(color: avatarColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(specialization, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: isActive ? Colors.green : Colors.grey),
              const SizedBox(width: 4),
              Text(
                isActive ? 'Aktif' : 'Pasif',
                style: TextStyle(color: isActive ? Colors.green : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
      trailing: Switch(
        value: isActive,
        onChanged: (bool value) {},
        activeColor: Colors.green,
      ),
    );
  }
}
