import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

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
        title: const Text('Raporlar', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarih Aralığı Seçici
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_month_outlined, color: Colors.grey),
                  Text('1 - 30 Eylül 2026', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Gelir / Gider Kartları
            Row(
              children: [
                Expanded(child: _buildFinanceCard('Toplam Gelir', '₺28.450', '↑ %12', true)),
                const SizedBox(width: 12),
                Expanded(child: _buildFinanceCard('Toplam Gider', '₺8.250', '↓ %5', false)),
              ],
            ),
            const SizedBox(height: 16),

            // Randevu / Müşteri İstatistik Kartları
            Row(
              children: [
                Expanded(child: _buildStatCard('132', 'Randevu', '↑ %18')),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('28', 'Yeni Müşteri', '↑ %25')),
              ],
            ),
            const SizedBox(height: 32),

            // En Popüler Hizmetler Başlığı
            const Text(
              'En Popüler Hizmetler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            // Popüler Hizmetler Listesi
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  _buildPopularServiceItem('1', 'Saç Kesimi', '42'),
                  const Divider(height: 1),
                  _buildPopularServiceItem('2', 'Cilt Bakımı', '28'),
                  const Divider(height: 1),
                  _buildPopularServiceItem('3', 'Manikür', '24'),
                  const Divider(height: 1),
                  _buildPopularServiceItem('4', 'Saç Boyama', '20', isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 40), // Alt menü boşluğu
          ],
        ),
      ),
    );
  }

  // Gelir/Gider Kartı Tasarımı
  Widget _buildFinanceCard(String title, String amount, String percentage, bool isIncome) {
    Color color = isIncome ? Colors.green : Colors.red;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          Text(amount, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(percentage, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Sayısal İstatistik Kartı Tasarımı (Randevu, Yeni Müşteri)
  Widget _buildStatCard(String value, String title, String percentage) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 8),
          Text(percentage, style: const TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Popüler Hizmet Liste Elemanı Tasarımı
  Widget _buildPopularServiceItem(String rank, String title, String count, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              rank,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[500]),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
          Text(
            count,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
