import 'package:flutter/material.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);

class GuidelinesScreen extends StatelessWidget {
  const GuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      'تفقد الحقل أسبوعياً، وخاصة حواف الحقل والمناطق الرطبة.',
      'اختر أصنافاً مقاومة للأمراض المنتشرة في منطقتك.',
      'تجنب الري المسائي، لأن الرطوبة الليلية تساعد على انتشار الفطريات.',
      'لا تستخدم المبيدات دون مراجعة خبير زراعي أو الإرشاد الزراعي.',
      'سجّل كل فحص في السجل لتتابع تطور الإصابة.',
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
                    child: Text('الإرشادات',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: tips.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: _agri, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(tips[i],
                            style: const TextStyle(fontSize: 13, height: 1.6)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}