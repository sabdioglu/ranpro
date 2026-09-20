import 'package:flutter/material.dart';

class WebAppointmentScreen extends StatefulWidget {
  const WebAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<WebAppointmentScreen> createState() => _WebAppointmentScreenState();
}

class _WebAppointmentScreenState extends State<WebAppointmentScreen> {
  // Web randevu aktif/pasif şalterinin durumu
  bool _isWebAppointmentActive = true;

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
        title: const Text('Web Randevu', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Üstteki Dünya İkonu ve Başlıklar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0EB), // Çok açık turuncu
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.language, color: Color(0xFFFF5722), size: 48),
            ),
            const SizedBox(height: 24),
            const Text(
              'Online Randevu Sayfanız',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Müşterilerinizin web üzerinden randevu almasını sağlayın.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.4),
            ),
            const SizedBox(height: 32),

            // Randevu Linki Kutusunun Tasarımı
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link, color: Colors.grey),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'https://ranpro.app/ayseguzellik',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Color(0xFFFF5722)),
                    onPressed: () {
                      // Kopyalama işlemi buraya eklenecek
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Aksiyon Butonları (QR, Paylaş, Web Sitesine Ekle)
            _buildActionButton(Icons.qr_code, 'QR Kodu Göster'),
            _buildActionButton(Icons.share_outlined, 'Link Paylaş'),
            _buildActionButton(Icons.code, 'Web Sitesine Ekle'),
            const SizedBox(height: 32),

            // Web Randevu Aç/Kapa Şalteri Kutusu
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isWebAppointmentActive ? const Color(0xFFFFF0EB) : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _isWebAppointmentActive ? const Color(0xFFFF5722).withOpacity(0.5) : Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _isWebAppointmentActive ? const Color(0xFFFF5722) : Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.language, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Web randevuyu aktif et',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Müşterileriniz web üzerinden randevu alabilir.',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _isWebAppointmentActive,
                    onChanged: (bool value) {
                      setState(() {
                        _isWebAppointmentActive = value;
                      });
                    },
                    activeColor: const Color(0xFFFF5722),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Aksiyon Butonları (QR, Paylaş vb.) Tasarımı
  Widget _buildActionButton(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              Icon(icon, color: Colors.black87),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
