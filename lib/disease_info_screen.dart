import 'package:flutter/material.dart';
import 'disease_details_screen.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);
const Color _mint = Color(0xFFEAF6F0);

class DiseaseInfoScreen extends StatelessWidget {
  const DiseaseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: Text(
                      'معلومات المرض',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _mint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: Icon(Icons.grass, size: 60, color: _agri)),
                    ),
                    const SizedBox(height: 14),
                    const Text('صدأ الأوراق الأصفر',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800, color: _green)),
                    const Text('Yellow Rust (Stripe Rust) — Puccinia striiformis',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _chip(Icons.grass, 'محصول القمح', _mint, _green),
                        _chip(Icons.bug_report, 'مُسبب فطري', const Color(0xFFF1F5F9),
                            const Color(0xFF374151)),
                        _chip(Icons.timer, 'سريع الانتشار', const Color(0xFFF1F5F9),
                            const Color(0xFF374151)),
                        _chip(Icons.warning_amber_rounded, 'شديد الخطورة',
                            const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _section('الأعراض الحقلية المميزة', [
                      'ظهور بثور دائرية إلى بيضاوية بلون أصفر أو برتقالي فاقع على النصل العلوي للأوراق.',
                      'انتظام البثور الفطرية في خطوط أو أشرطة طولية متوازية تمتد بمحاذاة عروق الورقة.',
                      'تطاير غبار بوغي برتقالي ناعم عند ملامسة الأوراق أو هبوب الرياح.',
                      'جفاف مبكر وموت أنسجة الورقة الحاملة للسنبلة مما يؤدي لنقص حاد في المحصول.',
                    ]),
                    const SizedBox(height: 14),
                    _section('أسباب المرض والظروف الحيوية', [
                      'المسبب: فطر Puccinia striiformis f. sp. tritici، طفيلي إجباري متخصص بأنسجة القمح.',
                      'الحرارة المثالية: بين 10 و15 درجة مئوية، ويتوقف النمو النشط فوق 23 درجة.',
                      'الرطوبة: تحتاج غشاء رطب أو ندى مع رطوبة نسبية أكثر من 85% لمدة 3 إلى 4 ساعات.',
                      'الانتشار: تنتقل الجراثيم مع الرياح لعشرات الكيلومترات مسببة بؤر عدوى سريعة.',
                    ]),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified_user, color: Colors.white, size: 22),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('هل ترغب في البدء بالمكافحة؟',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text('راجع خيارات المبيدات المعتمدة وجدول المعالجة الميدانية',
                                    style: TextStyle(color: Color(0xFFD1FAE5), fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DiseaseDetailsScreen()),
                      ),
                      child: const Text('عرض معلومات المرض',
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

  Widget _chip(IconData icon, String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _section(String title, List<String> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w700, color: _green)),
          const SizedBox(height: 10),
          ...items.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: _agri, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(s,
                      style: const TextStyle(
                          fontSize: 12, height: 1.6, color: Color(0xFF374151))),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}