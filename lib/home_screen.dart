import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'guidelines_screen.dart';
class AppColors {
  static const forest = Color(0xFF064E36);
  static const forestDark = Color(0xFF043826);
  static const agriGreen = Color(0xFF087B55);
  static const mintBg = Color(0xFFEAF6F0);
  static const mintLight = Color(0xFFF3FAF6);
  static const darkText = Color(0xFF18241D);
  static const subText = Color(0xFF5A6E63);
  static const pageBg = Color(0xFFF7FAF8);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 0;
  int _navIndex = 0;

  final List<Map<String, String>> _crops = [
    {'ar': 'القمح', 'en': 'Wheat', 'img': 'assets/wheat.jpeg'},
    {'ar': 'الأرز', 'en': 'Rice', 'img': 'assets/rice.jpg'},
    {'ar': 'الطماطم', 'en': 'Tomato', 'img': 'assets/tomato.jpeg'},
  ];

  void _openScan() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScanScreen(
          cropName: _crops[_selected]['ar']!,
          cropImage: _crops[_selected]['img']!,
        ),
      ),
    );
  }

  void _onNavTap(int i) {
    if (i == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
    } else if (i == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const GuidelinesScreen()));
    } else if (i == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
    } else {
      setState(() => _navIndex = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        _buildCropCard(),
                        const SizedBox(height: 16),
                        _buildScanCard(),
                        const SizedBox(height: 16),
                        _buildHistoryCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      height: 225,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/field.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x80000000), Color(0x99064E36), AppColors.pageBg],
            stops: [0, 0.6, 1],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 48,
              left: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white.withValues(alpha: 0.85),
                child: const Icon(Icons.notifications_none, size: 18, color: AppColors.forest),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.eco, color: AppColors.agriGreen, size: 30),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'AgriAI',
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Healthy Crops, Brighter Future',
                    style: TextStyle(color: Color(0xFFD1FAE5), fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'محاصيل سليمة.. مستقبل أفضل',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCropCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECF5F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.agriGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'اختر المحصول',
                    style: TextStyle(color: AppColors.darkText, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Text(
                'عرض الكل',
                style: TextStyle(color: AppColors.agriGreen, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_crops.length, (i) {
              final crop = _crops[i];
              final selected = _selected == i;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => _selected = i),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.mintLight : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected ? AppColors.agriGreen : const Color(0xFFF1F5F9),
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              crop['img']!,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            crop['ar']!,
                            style: const TextStyle(color: AppColors.darkText, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            crop['en']!,
                            style: const TextStyle(color: AppColors.subText, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildScanCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.forest, Color(0xFF07593D), AppColors.forestDark],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تشخيص فوري مدعوم بالذكاء الاصطناعي',
            style: TextStyle(color: Color(0xFFA7F3D0), fontSize: 12, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'التقط صورة واضحة لورقة النبات المصابة أو حمّلها من المعرض للحصول على تحليل فوري وعلاج موثوق.',
            style: TextStyle(color: Color(0xE6D1FAE5), fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.forest,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _openScan,
              icon: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.forest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
              ),
              label: const Text(
                'افحص محصولك الآن',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard() {
    return GestureDetector(
      onTap: () => _onNavTap(1),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD1FAE5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.mintBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.history, color: AppColors.agriGreen, size: 20),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('سجل الفحوص',
                            style: TextStyle(color: AppColors.darkText, fontSize: 12, fontWeight: FontWeight.w700)),
                        SizedBox(width: 8),
                        Text('12 فحص',
                            style: TextStyle(color: AppColors.agriGreen, fontSize: 10, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text('التقارير السابقة والنتائج',
                        style: TextStyle(color: AppColors.subText, fontSize: 10)),
                  ],
                ),
              ],
            ),
            const Text(
              'عرض السجل ‹',
              style: TextStyle(color: AppColors.agriGreen, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'label': 'الرئيسية', 'icon': Icons.home_rounded, 'i': 0},
      {'label': 'السجل', 'icon': Icons.history_rounded, 'i': 1},
      {'label': 'فحص', 'icon': Icons.camera_alt, 'i': 2},
      {'label': 'الإرشادات', 'icon': Icons.menu_book_rounded, 'i': 3},
      {'label': 'حسابي', 'icon': Icons.person_outline_rounded, 'i': 4},
    ];
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: List.generate(items.length, (idx) {
          final it = items[idx];
          final i = it['i'] as int;
          if (i == 2) {
            return Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: _openScan,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.agriGreen, AppColors.forest],
                      ),
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: const [
                        BoxShadow(color: Color(0x4D064E36), blurRadius: 12, offset: Offset(0, 4)),
                      ],
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 26),
                  ),
                ),
              ),
            );
          }
          final active = _navIndex == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => _onNavTap(i),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    it['icon'] as IconData,
                    size: 22,
                    color: active ? AppColors.agriGreen : const Color(0xFF94A3B8),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    it['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      color: active ? AppColors.agriGreen : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}