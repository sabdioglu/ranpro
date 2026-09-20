import 'package:flutter/material.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({Key? key}) : super(key: key);

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
        title: const Text('Gelir / Gider', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black87, size: 18),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ay Seçici
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
                  const Text('Eylül 2026', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
                ],
              ),
              const SizedBox(height: 16),

              // Özet Kartları (Gelir ve Gider)
              Row(
                children: [
                  Expanded(child: _buildSummaryCard('Toplam Gelir', '₺28.450', '↑ %12', true)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSummaryCard('Toplam Gider', '₺8.250', '↓ %5', false)),
                ],
              ),
              const SizedBox(height: 32),

              // Grafik Başlığı ve Lejant
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gelir / Gider Grafiği', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      _buildLegend(Colors.green, 'Gelir'),
                      const SizedBox(width: 12),
                      _buildLegend(Colors.red, 'Gider'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sütun Grafiği (Tasarımı simüle eden yapı)
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBarGroup('Pzt', 80, 30),
                    _buildBarGroup('Sal', 100, 40),
                    _buildBarGroup('Çar', 60, 20),
                    _buildBarGroup('Per', 120, 50),
                    _buildBarGroup('Cum', 90, 80),
                    _buildBarGroup('Cmt', 140, 40),
                    _buildBarGroup('Paz', 40, 10),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // İşlemler Listesi Başlığı
              const Text('İşlemler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // İşlem Kalemleri
              _buildTransactionTile(Icons.content_cut, 'Saç Kesimi', '18 Eyl 10:30', '+₺450', true),
              _buildTransactionTile(Icons.shopping_bag_outlined, 'Ürün satışı', '16 Eyl 16:20', '+₺320', true),
              _buildTransactionTile(Icons.electrical_services, 'Elektrik faturası', '16 Eyl 11:30', '-₺650', false),
              _buildTransactionTile(Icons.inventory_2_outlined, 'Malzeme', '16 Eyl 09:15', '-₺280', false),
              
              const SizedBox(height: 40), // Alt menü boşluğu
            ],
          ),
        ),
      ),
    );
  }

  // Özet Kartı Tasarımı
  Widget _buildSummaryCard(String title, String amount, String percentage, bool isIncome) {
    Color mainColor = isIncome ? Colors.green : Colors.red;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isIncome ? Icons.arrow_circle_up : Icons.arrow_circle_down, color: mainColor, size: 20),
              const SizedBox(width: 6),
              Text(title, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Text(amount, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: mainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(percentage, style: TextStyle(color: mainColor, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Grafik Altındaki Lejantlar (Yeşil/Kırmızı noktalar)
  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
      ],
    );
  }

  // Grafikteki Günlük Sütunlar
  Widget _buildBarGroup(String day, double incomeHeight, double expenseHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: 8, height: incomeHeight, color: Colors.green, margin: const EdgeInsets.symmetric(horizontal: 2)),
            Container(width: 8, height: expenseHeight, color: Colors.red, margin: const EdgeInsets.symmetric(horizontal: 2)),
          ],
        ),
        const SizedBox(height: 8),
        Text(day, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  // İşlem Listesi Elemanı
  Widget _buildTransactionTile(IconData icon, String title, String date, String amount, bool isIncome) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black87, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(date, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
