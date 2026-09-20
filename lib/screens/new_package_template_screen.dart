import 'package:flutter/material.dart';

class NewPackageTemplateScreen extends StatefulWidget {
  const NewPackageTemplateScreen({Key? key}) : super(key: key);

  @override
  State<NewPackageTemplateScreen> createState() => _NewPackageTemplateScreenState();
}

class _NewPackageTemplateScreenState extends State<NewPackageTemplateScreen> {
  // Otomatik Seans Düş şalteri durumu
  bool _autoDeductSession = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          'Yeni Paket Şablonu',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Paket Adı
                  _buildSectionLabel('PAKET ADI'),
                  _buildTextField(hint: 'Örn. Lazer Epilasyon Paketi'),
                  const SizedBox(height: 24),

                  // Hizmetler
                  _buildSectionLabel('HİZMETLER'),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('HUANA Şifa Seansı', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                        ),
                        Icon(Icons.radio_button_unchecked, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Toplam Seans
                  _buildSectionLabel('TOPLAM SEANS'),
                  _buildTextField(hint: '10', keyboardType: TextInputType.number),
                  const SizedBox(height: 16),

                  // Otomatik Seans Düş Şalteri
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: _autoDeductSession ? const Color(0xFFFFF0EB) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _autoDeductSession ? const Color(0xFFFF5722).withOpacity(0.5) : Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _autoDeductSession ? const Color(0xFFFF5722) : Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.autorenew, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Otomatik Seans Düş', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              const SizedBox(height: 2),
                              Text('Manuel olarak düşülür', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                            ],
                          ),
                        ),
                        Switch(
                          value: _autoDeductSession,
                          onChanged: (val) {
                            setState(() {
                              _autoDeductSession = val;
                            });
                          },
                          activeColor: const Color(0xFFFF5722),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Paket Fiyatı
                  _buildSectionLabel('PAKET FİYATI'),
                  _buildTextField(hint: '0', keyboardType: TextInputType.number),
                  const SizedBox(height: 24),

                  // Geçerlilik Süresi
                  _buildSectionLabel('GEÇERLİLİK SÜRESİ (opsiyonel, gün)'),
                  _buildTextField(hint: 'Örn. 365', keyboardType: TextInputType.number),
                  const SizedBox(height: 24),

                  // Not
                  _buildSectionLabel('NOT (opsiyonel)'),
                  _buildTextField(hint: 'İçerik, kapsam, koşullar...', maxLines: 3),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Alt Kısım: Oluştur Butonu
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4)),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oluştur',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Gri Başlık Etiketi Tasarımı
  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // Metin Kutusu Tasarımı
  Widget _buildTextField({required String hint, int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF5722)),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
