import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

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
        title: const Text('Profil & Ayarlar', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Kısım: İşletme Profili Özeti
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Icon(Icons.spa, color: Colors.grey, size: 30),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Danışmanlık | Spiritüel...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                          SizedBox(height: 4),
                          Text('Adana, İmamoğlu', style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey[400]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Premium Abonelik Kartı
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(color: Colors.amber.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.workspace_premium, color: Colors.amber, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Premium Aktif', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 4),
                        Text('Abonelik', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Aboneliği yönet >', style: TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Randevu Sayfası Linkleri Başlığı
            const Text(
              'Randevu Sayfası',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            // Randevu Linki Kutusu
            _buildLinkBox(
              icon: Icons.link,
              title: 'Randevu Linkiniz',
              url: 'https://randevu.ranpro.app/danismanlik...',
            ),
            const SizedBox(height: 12),

            // Web Sitesi Linki Kutusu
            _buildLinkBox(
              icon: Icons.language,
              title: 'Web Siteniz',
              url: 'https://danismanlik.ranpro.app',
            ),
            const SizedBox(height: 16),

            // Alt Bilgilendirme Metni
            Text(
              'Bu linkleri Instagram, WhatsApp veya Google profilinize ekleyerek müşterilerinizin kolayca randevu almasını sağlayabilirsiniz.',
              style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  // Kopyalanabilir Link Kutusu Tasarımı
  Widget _buildLinkBox({required IconData icon, required String title, required String url}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Icon(icon, color: Colors.black87, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(url, style: const TextStyle(color: Color(0xFFFF5722), fontSize: 13), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.grey),
            onPressed: () {
              // Kopyalama işlevi buraya eklenecek
            },
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
