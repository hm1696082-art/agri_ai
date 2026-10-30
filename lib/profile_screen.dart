import 'package:flutter/material.dart';
import 'user_store.dart';
import 'login_screen.dart';
import 'notifications_screen.dart';
import 'help_screen.dart';
import 'edit_profile_screen.dart';
import 'history_screen.dart';
import 'guidelines_screen.dart';
const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);
const Color _mint = Color(0xFFEAF6F0);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final u = await UserStore.currentUser();
    if (mounted) setState(() => _user = u);
  }

  Future<void> _logout() async {
    await UserStore.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = _user?['name'] ?? '-';
    final email = _user?['email'] ?? '-';
    final phone = _user?['phone'] ?? '-';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: _green,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text('الملف الشخصي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _headerCard(name),
                    const SizedBox(height: 14),
                    _mapCard(),
                    const SizedBox(height: 14),
                    _farmInfo(email, phone),
                    const SizedBox(height: 14),
                    _healthCard(),
                    const SizedBox(height: 14),
                    _actionTile(Icons.edit_outlined, 'تعديل البيانات', 'تحديث بيانات المزرعة', () async {
                      final ok = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfileScreen(user: _user ?? {})),
                      );
                      if (ok == true) _load();
                    }),
                    _actionTile(Icons.notifications_outlined, 'الإشعارات والتنبيهات',
                        'تنبيهات الآفات والطقس', () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
                    _actionTile(Icons.support_agent, 'المساعدة والدعم الزراعي',
                        'تواصل مع المرشدين', () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const HelpScreen()))),
                    _actionTile(Icons.logout, 'تسجيل الخروج', 'التبديل إلى حساب آخر', _logout,
                        danger: true),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _bottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomBar(BuildContext context) {
    final items = [
      {'label': 'الرئيسية', 'icon': Icons.home_outlined},
      {'label': 'السجل', 'icon': Icons.history},
      {'label': 'الإرشادات', 'icon': Icons.menu_book_outlined},
      {'label': 'حسابي', 'icon': Icons.person_outline},
    ];
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final active = i == 3;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (active) return;
                if (i == 0) {
                  Navigator.popUntil(context, (r) => r.isFirst);
                } else if (i == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                } else if (i == 2) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const GuidelinesScreen()));
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(items[i]['icon'] as IconData,
                      size: 22,
                      color: active ? _agri : const Color(0xFF94A3B8)),
                  const SizedBox(height: 4),
                  Text(items[i]['label'] as String,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          color: active ? _agri : const Color(0xFF94A3B8))),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _headerCard(String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 34,
                backgroundColor: _mint,
                child: Icon(Icons.person, size: 38, color: _green),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800, color: _green)),
                    const SizedBox(height: 4),
                    const Text('المنوفية - جمهورية مصر العربية',
                        style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: _mint, borderRadius: BorderRadius.circular(20)),
                      child: const Text('مزارع معتمد',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700, color: _agri)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _Stat(Icons.assessment, '12', 'فحص مسجل'),
              _Stat(Icons.grass, '3', 'محاصيل نشطة'),
              _Stat(Icons.workspace_premium, 'ذهبية', 'العضوية'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mapCard() {
    return Container(
      width: double.infinity,
      height: 130,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF9CC9B2), _green],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 26),
            SizedBox(height: 4),
            Text('موقع الحقل الرئيسي',
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
            Text('حوض الباجور - القطعة 4B',
                style: TextStyle(color: Color(0xFFD1FAE5), fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _farmInfo(String email, String phone) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معلومات المزرعة',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _green)),
          const SizedBox(height: 12),
          _row(Icons.grass, 'المحاصيل الحالية', 'قمح، أرز، طماطم'),
          _row(Icons.square_foot, 'المساحة الكلية', '12 فدان'),
          _row(Icons.phone_outlined, 'رقم الهاتف', phone),
          _row(Icons.mail_outline, 'البريد الإلكتروني', email),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: _agri, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          ),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _healthCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('مؤشر صحة الحقول العامة',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.9,
              minHeight: 10,
              color: _agri,
              backgroundColor: Color(0xFFE2E8F0),
            ),
          ),
          const SizedBox(height: 6),
          const Text('لا توجد بؤر إصابة نشطة حرجة',
              style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String label, String sub, VoidCallback onTap,
      {bool danger = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Icon(icon, color: danger ? const Color(0xFFDC2626) : _agri),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: danger ? const Color(0xFFDC2626) : Colors.black87)),
                  Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                ],
              ),
            ),
            const Icon(Icons.chevron_left, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _Stat(this.icon, this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: _agri, size: 20),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _green)),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
      ],
    );
  }
}