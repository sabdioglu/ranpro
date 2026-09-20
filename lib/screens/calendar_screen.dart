import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Seçili görünüm sekmesi (Gün, Hafta, Ay)
  String _selectedView = 'Gün';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Üst Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Takvim', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Ay Seçici (Eylül 2026)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
                const Text('Eylül 2026', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
              ],
            ),
          ),
          
          // Günler Şeridi (Pzt, Sal, Çar...)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDayColumn('Pzt', '8', false),
                _buildDayColumn('Sal', '18', false),
                _buildDayColumn('Çar', '20', false),
                _buildDayColumn('Per', '21', false),
                _buildDayColumn('Cum', '22', true), // Seçili olan gün
                _buildDayColumn('Cmt', '23', false),
                _buildDayColumn('Paz', '24', false),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Gün / Hafta / Ay Sekmeleri
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  _buildViewTab('Gün'),
                  _buildViewTab('Hafta'),
                  _buildViewTab('Ay'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Zaman ve Randevu Çizelgesi (Aşağı Doğru Kaydırılabilir Liste)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildTimelineItem('09:30', 'Elif Demir', 'Saç kesimi', Colors.green),
                _buildTimelineItem('10:30', 'Mehmet Yıldız', 'Sakal bakımı', Colors.orange),
                _buildTimelineItem('11:15', 'Zeynep Kaya', 'Cilt bakımı', Colors.blue),
                _buildTimelineItem('12:15', 'Öğle arası', '12:15 - 13:15', Colors.grey),
                _buildTimelineItem('13:30', 'Ahmet Yılmaz', 'Saç boyama', Colors.red),
                _buildTimelineItem('15:00', 'Derya Koç', 'Manikür', Colors.purple),
                _buildTimelineItem('16:30', 'Selin Karaca', 'Cilt bakımı', Colors.blue),
                const SizedBox(height: 80), // Alt menünün arkasında kalmaması için boşluk
              ],
            ),
          ),
        ],
      ),
      // Sağ alt köşedeki Turuncu Yeni Ekle Butonu
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Takvimin üstündeki günler listesi (Aktif günü turuncu yapar)
  Widget _buildDayColumn(String dayName, String dayNumber, bool isActive) {
    return Column(
      children: [
        Text(dayName, style: TextStyle(color: isActive ? const Color(0xFFFF5722) : Colors.grey, fontSize: 13, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        const SizedBox(height: 4),
        Text(dayNumber, style: TextStyle(color: isActive ? const Color(0xFFFF5722) : Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Gün, Hafta, Ay seçme butonları
  Widget _buildViewTab(String title) {
    bool isActive = _selectedView == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedView = title;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFF5722) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[700],
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // Saat saat randevu çizelgesindeki her bir satır
  Widget _buildTimelineItem(String time, String name, String service, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sol taraf: Saat
          SizedBox(
            width: 50,
            child: Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          // Sağ taraf: Randevu Kartı
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1), // Rengin çok açık ve şeffaf hali
                borderRadius: BorderRadius.circular(12),
                border: Border(left: BorderSide(color: color, width: 4)), // Sol taraftaki kalın renk çizgisi
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color.withOpacity(0.9))),
                  const SizedBox(height: 4),
                  Text(service, style: TextStyle(color: color.withOpacity(0.8), fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
