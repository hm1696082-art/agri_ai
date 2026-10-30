import 'package:flutter/material.dart';
import 'disease_info_screen.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);
const Color _mint = Color(0xFFEAF6F0);

class ResultScreen extends StatelessWidget {
  final String cropName;
  final String cropImage;

  const ResultScreen({super.key, required this.cropName, required this.cropImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: _green,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  _circleIcon(Icons.arrow_forward_ios, () => Navigator.pop(context)),
                  const Expanded(
                    child: Column(
                      children: [
                        Text('نتيجة التشخيص',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text('اكتمل الفحص بواسطة الذكاء الاصطناعي',
                            style: TextStyle(color: Color(0xFFA7F3D0), fontSize: 10)),
                      ],
                    ),
                  ),
                  _circleIcon(Icons.share, () {}),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _resultCard(),
                    const SizedBox(height: 14),
                    _alternatives(),
                    const SizedBox(height: 14),
                    _disclaimer(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DiseaseInfoScreen()),
                      ),
                      icon: const Icon(Icons.info_outline, size: 18),
                      label: const Text('عرض معلومات المرض',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextButton.icon(
                    onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                    icon: const Icon(Icons.refresh, size: 16, color: _agri),
                    label: const Text('إجراء فحص نبات جديد',
                        style: TextStyle(
                            color: _agri, fontSize: 12, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _resultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _mint,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD5EDDF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(cropImage, width: 90, height: 90, fit: BoxFit.cover),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('$cropName | ${_englishName(cropName)}',
                          style: const TextStyle(
                              fontSize: 11, color: _green, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 8),
                    const Text('صدأ الأوراق الأصفر',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800, color: _green)),
                    const Text('Yellow Rust (Stripe Rust)',
                        style: TextStyle(
                            fontSize: 12, color: _agri, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    const Text('⚠ إصابة فطرية نشطة (Puccinia striiformis)',
                        style: TextStyle(fontSize: 11, color: Color(0xFFD97706))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 52,
                  height: 52,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircularProgressIndicator(
                        value: 0.78,
                        strokeWidth: 5,
                        color: _green,
                        backgroundColor: Color(0xFFD5EDDF),
                      ),
                      const Text('78%',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700, color: _green)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('درجة الثقة (تقديرية)',
                        style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    SizedBox(height: 2),
                    Text('78%',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w900, color: _green)),
                    Text('تطابق مرتفع جداً',
                        style: TextStyle(
                            fontSize: 11, color: _agri, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _englishName(String ar) {
    switch (ar) {
      case 'الأرز':
        return 'Rice';
      case 'الطماطم':
        return 'Tomato';
      default:
        return 'Wheat';
    }
  }

  Widget _alternatives() {
    final items = [
      {'name': 'صدأ الأوراق البني', 'en': 'Brown Rust', 'p': 0.12},
      {'name': 'تبقع أوراق السبتوريا', 'en': 'Septoria', 'p': 0.06},
      {'name': 'سليم (خالي من المرض)', 'en': 'Healthy', 'p': 0.04},
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('الاحتمالات الأخرى',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              Spacer(),
              Text('3 تشخيصات بديلة',
                  style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((e) {
            final p = e['p'] as double;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('${(p * 100).round()}%',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      const Spacer(),
                      Text(e['name'] as String,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 6),
                      Text(e['en'] as String,
                          style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: p,
                      minHeight: 8,
                      color: _agri,
                      backgroundColor: const Color(0xFFE2E8F0),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _disclaimer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FAF7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _green, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'تنويه إرشادي: النتائج المعروضة هي تقديرات قائمة على خوارزميات الذكاء الاصطناعي، ويُرجى التحقق الميداني واستشارة خبير زراعي عند الضرورة قبل تطبيق المعالجة.',
              style: TextStyle(fontSize: 11, height: 1.6, color: Color(0xFF475569)),
            ),
          ),
        ],
      ),
    );
  }
}