import 'package:flutter/material.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentScreen> createState() => _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  // Müşteri / Misafir sekmesi seçimi (true = Müşteri, false = Misafir)
  bool _isCustomerSelected = true;

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
        title: const Text('Randevu Oluştur', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Müşteri / Misafir Geçiş Sekmeleri
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isCustomerSelected = true),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: _isCustomerSelected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(21),
                                boxShadow: _isCustomerSelected
                                    ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                                    : [],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Müşteri',
                                style: TextStyle(
                                  fontWeight: _isCustomerSelected ? FontWeight.bold : FontWeight.normal,
                                  color: _isCustomerSelected ? Colors.black87 : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isCustomerSelected = false),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: !_isCustomerSelected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(21),
                                boxShadow: !_isCustomerSelected
                                    ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                                    : [],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Misafir',
                                style: TextStyle(
                                  fontWeight: !_isCustomerSelected ? FontWeight.bold : FontWeight.normal,
                                  color: !_isCustomerSelected ? Colors.black87 : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Seçim Alanları (Liste Görünümü)
                  _buildSelectionRow(Icons.person_outline, 'Müşteri seçin'),
                  _buildSelectionRow(Icons.spa_outlined, 'Hizmet seçin'),
                  _buildSelectionRow(Icons.badge_outlined, 'Personel seçin'),
                  
                  // Tarih Seçimi
                  _buildSelectionRow(Icons.calendar_today_outlined, '18 Eylül 2026', isDate: true),
                  
                  // Saat Seçimi
                  _buildSelectionRow(Icons.access_time, '10:30', isDate: true),
                  
                  const SizedBox(height: 16),

                  // Not Ekleme Alanı
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Icon(Icons.note_alt_outlined, color: Colors.grey[500]),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Not ekleyin...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFFF5722)),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Alt Kısım: Randevu Oluştur Butonu
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))
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
                  Text('Randevu Oluştur', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tıklanabilir Seçim Satırı Tasarımı
  Widget _buildSelectionRow(IconData icon, String title, {bool isDate = false}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[500], size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDate ? Colors.black87 : Colors.grey[600],
                  fontWeight: isDate ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }
}
