import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // Seçili Kategori
  String _selectedCategory = 'Tümü';

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
        title: const Text('Hizmetler', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Kategori Sekmeleri
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildCategoryTab('Tümü'),
                const SizedBox(width: 8),
                _buildCategoryTab('Saç'),
                const SizedBox(width: 8),
                _buildCategoryTab('Cilt'),
                const SizedBox(width: 8),
                _buildCategoryTab('Tırnak'),
                const SizedBox(width: 8),
                _buildCategoryTab('Diğer'),
              ],
            ),
          ),
          const Divider(height: 1),

          // Hizmetler Listesi
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 8.0, bottom: 80.0), // Alt butonun arkasında kalmasın
              children: [
                _buildServiceTile(icon: Icons.content_cut, title: 'Saç Kesimi', duration: '45 dk', price: '₺450'),
                _buildServiceTile(icon: Icons.color_lens_outlined, title: 'Saç Boyama', duration: '90 dk', price: '₺750'),
                _buildServiceTile(icon: Icons.face_retouching_natural, title: 'Cilt Bakımı', duration: '60 dk', price: '₺800'),
                _buildServiceTile(icon: Icons.back_hand_outlined, title: 'Manikür', duration: '60 dk', price: '₺400'),
                _buildServiceTile(icon: Icons.do_not_step, title: 'Pedikür', duration: '45 dk', price: '₺400'),
                _buildServiceTile(icon: Icons.face, title: 'Kaş Tasarımı', duration: '30 dk', price: '₺300'),
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
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }

  // Kategori Sekmesi Tasarımı
  Widget _buildCategoryTab(String title) {
    bool isActive = _selectedCategory == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF5722) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[700],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Hizmet Liste Elemanı Tasarımı
  Widget _buildServiceTile({required IconData icon, required String title, required String duration, required String price}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Sol Taraftaki Turuncu İkon Kutusu
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0EB), // Çok açık turuncu
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFFF5722), size: 24),
          ),
          const SizedBox(width: 16),
          
          // Orta Kısım: İsim ve Süre
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(duration, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          
          // Sağ Kısım: Fiyat
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
