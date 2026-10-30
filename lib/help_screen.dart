import 'package:flutter/material.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {'q': 'كيف أفحص محصولي؟', 'a': 'من الشاشة الرئيسية اختار المحصول، واضغط "افحص محصولك الآن"، ثم التقط صورة واضحة لورقة النبات.'},
      {'q': 'هل النتائج دقيقة 100%؟', 'a': 'النتائج تقديرية قائمة على الذكاء الاصطناعي، ويُنصح بالتحقق الميداني واستشارة خبير زراعي قبل تطبيق المعالجة.'},
      {'q': 'كيف أعدّل بياناتي؟', 'a': 'من تبويب حسابي اختار "تعديل البيانات" وعدّل الاسم أو البريد أو الرقم ثم أكّد التعديل.'},
      {'q': 'نسيت كلمة المرور، ماذا أفعل؟', 'a': 'من شاشة تسجيل الدخول اضغط "نسيت كلمة المرور؟"، وسيتم التواصل معك على بريدك المسجل.'},
    ];

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
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text('المساعدة والدعم الزراعي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF6F0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.support_agent, color: _green, size: 28),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'تواصل مع المرشدين الزراعيين في منطقتك، أو راسلنا وسنرد عليك في أقرب وقت.',
                            style: TextStyle(fontSize: 12, height: 1.5, color: _green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...faqs.map((f) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(f['q']!,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w700, color: _green)),
                        const SizedBox(height: 6),
                        Text(f['a']!,
                            style: const TextStyle(
                                fontSize: 12, height: 1.6, color: Color(0xFF5A6E63))),
                      ],
                    ),
                  )),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _agri,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إرسال طلب الدعم، سنتواصل معك قريباً')),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline, size: 18),
                      label: const Text('راسل الدعم',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}