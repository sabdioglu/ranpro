import 'package:flutter/material.dart';

void main() {
  runApp(const RanProApp());
}

class RanProApp extends StatelessWidget {
  const RanProApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RanPro Ana Sayfa',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5722)),
        scaffoldBackgroundColor: Colors.grey[50], // Çok açık gri arkaplan
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Üst Bar (AppBar)
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
        title: const Text(
          'RanPro',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),

      // Ana İçerik
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Karşılama ve Tarih
              const Text(
                'Hoş Geldiniz, Patron!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 4),
              Text(
                'Bugün: 20 Eylül 2026, Pazar',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Özet Kartları (Yan yana)
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Bugünkü\nRandevular',
                      count: '8',
                      icon: Icons.calendar_today,
                      color: Colors.blue[600]!,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Bekleyen\nOnaylar',
                      count: '3',
                      icon: Icons.pending_actions,
                      color: Colors.orange[600]!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Yaklaşan Randevular Başlığı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Yaklaşan Randevular',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: const Color(0xFFFF5722)),
                    child: const Text('Tümünü Gör'),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Randevu Listesi (Şimdilik Sahte Verilerle)
              _buildAppointmentCard(
                time: '10:00',
                name: 'Ahmet Yılmaz',
                service: 'Saç Kesimi',
                status: 'Onaylandı',
                statusColor: Colors.green,
              ),
              _buildAppointmentCard(
                time: '11:30',
                name: 'Ayşe Kaya',
                service: 'Boya & Bakım',
                status: 'Bekliyor',
                statusColor: Colors.orange,
              ),
              _buildAppointmentCard(
                time: '14:00',
                name: 'Mehmet Demir',
                service: 'Sakal Tıraşı',
                status: 'Onaylandı',
                statusColor: Colors.green,
              ),
            ],
          ),
        ),
      ),

      // Yeni Randevu Ekleme Butonu (Sağ Alt Köşe)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Yeni Randevu', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Özet Kartı Tasarım Şablonu
  Widget _buildSummaryCard({required String title, required String count, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            count,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.2),
          ),
        ],
      ),
    );
  }

  // Randevu Listesi Kart Tasarım Şablonu
  Widget _buildAppointmentCard({
    required String time,
    required String name,
    required String service,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Saat Kısmı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0EB), // Çok açık turuncu
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF5722), fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
          // İsim ve Hizmet
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  service,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          // Durum Rozeti
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

