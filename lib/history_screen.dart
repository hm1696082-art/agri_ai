import 'package:flutter/material.dart';
import 'inspection_details_screen.dart';
import 'history_screen.dart';
import 'guidelines_screen.dart';
const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);
const Color _mint = Color(0xFFEAF6F0);

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _filter = 'all';
  String _query = '';

  final List<Map<String, String>> _items = const [
    {
      'crop': 'tomato',
      'cropAr': 'الطماطم',
      'cropEn': 'Tomato',
      'img': 'assets/tomato.jpeg',
      'place': 'حقل #4',
      'time': 'اليوم، 10:30 ص',
      'title': 'لفحة مبكرة',
      'sub': 'Early Blight (Alternaria solani)',
      'status': 'إصابة فطرية نشطة',
      'acc': '72%',
    },
    {
      'crop': 'rice',
      'cropAr': 'الأرز',
      'cropEn': 'Rice',
      'img': 'assets/rice.jpg',
      'place': 'حوض #12',
      'time': 'أمس، 04:15 م',
      'title': 'تبقع بني',
      'sub': 'Brown Spot (Bipolaris oryzae)',
      'status': 'مرحلة متوسطة',
      'acc': '68%',
    },
    {
      'crop': 'wheat',
      'cropAr': 'القمح',
      'cropEn': 'Wheat',
      'img': 'assets/wheat.jpeg',
      'place': 'القطاع الشرقي',
      'time': '24 أكتوبر، 09:10 ص',
      'title': 'صدأ الأوراق الأصفر',
      'sub': 'Yellow Rust (Puccinia striiformis)',
      'status': 'إصابة موثقة',
      'acc': '78%',
    },
    {
      'crop': 'tomato',
      'cropAr': 'الطماطم',
      'cropEn': 'Tomato',
      'img': 'assets/tomato.jpeg',
      'place': 'بيت محمي 2',
      'time': '22 أكتوبر، 02:40 م',
      'title': 'نبات سليم - خالي من الإصابة',
      'sub': 'Healthy Plant (No Infection)',
      'status': 'حالة ممتازة',
      'acc': '95%',
    },
  ];

  List<Map<String, String>> get _visible {
    return _items.where((e) {
      final matchCrop = _filter == 'all' || e['crop'] == _filter;
      final q = _query.trim();
      final matchQuery = q.isEmpty ||
          e['title']!.contains(q) ||
          e['sub']!.toLowerCase().contains(q.toLowerCase()) ||
          e['cropAr']!.contains(q);
      return matchCrop && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _visible;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: _green,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Row(
                children: [
                  _circleIcon(Icons.arrow_forward_ios, () => Navigator.pop(context)),
                  const Expanded(
                    child: Text('سجل الفحوصات',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  _circleIcon(Icons.calendar_today, () {}),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: const Color(0xFFD5EDDF),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CircleAvatar(radius: 4, backgroundColor: _agri),
                              SizedBox(width: 6),
                              Text('إجمالي الفحوصات: 12 فحص',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w700, color: _green)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text('مُصنّف حسب الأحدث',
                            style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      onChanged: (v) => setState(() => _query = v),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن محصول أو مرض...',
                        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _chip('all', 'الكل', 12, Icons.apps),
                          _chip('wheat', 'القمح', 4, Icons.grain),
                          _chip('rice', 'الأرز', 3, Icons.grass),
                          _chip('tomato', 'الطماطم', 5, Icons.eco),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (list.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        child: const Column(
                          children: [
                            Icon(Icons.filter_list_off, size: 40, color: Color(0xFF9CA3AF)),
                            SizedBox(height: 8),
                            Text('لم يتم العثور على تشخيصات',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      )
                    else
                      ...list.map(_card),
                    const SizedBox(height: 16),
                    _weeklyChart(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String key, String label, int count, IconData icon) {
    final active = _filter == key;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: () => setState(() => _filter = key),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: active ? _green : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: active ? Colors.white : _agri),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : const Color(0xFF374151))),
              const SizedBox(width: 6),
              Text('$count',
                  style: TextStyle(
                      fontSize: 10, color: active ? Colors.white70 : const Color(0xFF6B7280))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(Map<String, String> e) {
    final isHealthy = e['crop'] == 'tomato' && e['acc'] == '95%';
    final accColor = isHealthy ? _agri : const Color(0xFFDC2626);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InspectionDetailsScreen(),
            ),
          );
        },
        child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(e['img']!, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('${e['cropAr']} | ${e['cropEn']}',
                          style: const TextStyle(
                              fontSize: 11, color: _agri, fontWeight: FontWeight.w700)),
                    ),
                    Text(e['time']!,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                  ],
                ),
                const SizedBox(height: 4),
                Text(e['title']!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isHealthy ? _agri : const Color(0xFF18241D))),
                Text(e['sub']!,
                    style: const TextStyle(
                        fontSize: 10, fontStyle: FontStyle.italic, color: Color(0xFF6B7280))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: accColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text('دقة ${e['acc']}',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700, color: accColor)),
                    ),
                    const Spacer(),
                    Text(e['status']!,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600, color: accColor)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
        ),
    );
  }

  Widget _weeklyChart() {
    final days = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];
    final values = [0.1, 0.2, 0.5, 0.9, 0.3, 0.15, 0.05];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('معدل الفحص الميداني',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: _mint, borderRadius: BorderRadius.circular(10)),
                child: const Text('هذا الأسبوع',
                    style: TextStyle(fontSize: 10, color: _green, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(days.length, (i) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 70 * values[i],
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: values[i] > 0.6 ? _green : (values[i] > 0.2 ? const Color(0xFF6EE7B7) : _mint),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(days[i], style: const TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}