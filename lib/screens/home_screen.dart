import 'package:flutter/material.dart';
import 'calendar_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'create_appointment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Alt menüye basıldığında açılacak sayfalar
  final List<Widget> _pages = [
    const HomeScreenBody(),
    const CalendarScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateAppointmentScreen()),
          );
        },
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomNavItem(icon: Icons.home, label: 'Ana Sayfa', index: 0),
              _buildBottomNavItem(icon: Icons.calendar_month, label: 'Takvim', index: 1),
              const SizedBox(width: 48), 
              _buildBottomNavItem(icon: Icons.bar_chart, label: 'Raporlar', index: 2),
              _buildBottomNavItem(icon: Icons.settings, label: 'Ayarlar', index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFFFF5722) : Colors.grey;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

// ==================== ANA SAYFA TASARIMI ====================
class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0EB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.spa, color: Color(0xFFFF5722), size: 28),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ayşe Güzellik Salonu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('İyi çalışmalar', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              const Text('Bugün • 18 Eylül 2026 Cuma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _buildStatCard('6', 'Randevu', Icons.people, Colors.teal)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('₺2.850', 'Günlük gelir', Icons.account_balance_wallet, Colors.teal)),
                ],
              ),
              const SizedBox(height: 24),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
                children: [
                  _buildActionIcon(Icons.add_circle, 'Yeni Randevu', Colors.teal),
                  _buildActionIcon(Icons.person_add, 'Müşteri Ekle', Colors.teal),
                  _buildActionIcon(Icons.shopping_bag, 'Hızlı Satış', Colors.teal),
                  _buildActionIcon(Icons.attach_money, 'Gelir Ekle', Colors.green),
                  _buildActionIcon(Icons.money_off, 'Gider Ekle', Colors.red),
                  _buildActionIcon(Icons.language, 'Web Linki', Colors.blue),
                ],
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bugünün randevuları', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Tümünü gör >', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
              const SizedBox(height: 12),

              _buildAppointmentTile('09:30', 'Elif Demir', 'Saç kesimi', 'Tamamlandı', Colors.green),
              _buildAppointmentTile('10:30', 'Mehmet Yıldız', 'Sakal bakımı', 'Bekliyor', Colors.orange),
              _buildAppointmentTile('11:15', 'Zeynep Kaya', 'Cilt bakımı', 'Onaylandı', Colors.blue),
              
              const SizedBox(height: 40), 
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String label, Color iconColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildAppointmentTile(String time, String name, String service, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(service, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
