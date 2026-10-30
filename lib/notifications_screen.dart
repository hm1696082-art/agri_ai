import 'package:flutter/material.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.warning_amber_rounded, 'color': const Color(0xFFDC2626), 'title': 'تنبيه آفة', 'body': 'رصد صدأ القمح الأصفر في القطاع الشرقي، تابع الحقل خلال 48 ساعة.', 'time': 'اليوم، 10:30 ص'},
      {'icon': Icons.cloud_outlined, 'color': const Color(0xFFD97706), 'title': 'تنبيه طقس', 'body': 'رطوبة مرتفعة متوقعة الليلة، وهذا يزيد خطر انتشار الفطريات.', 'time': 'اليوم، 08:00 ص'},
      {'icon': Icons.check_circle_outline, 'color': _agri, 'title': 'تم حفظ الفحص', 'body': 'تم حفظ نتيجة فحص الطماطم في سجل الفحوصات.', 'time': 'أمس، 04:15 م'},
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
                    child: Text('الإشعارات والتنبيهات',
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
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final n = items[i];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(n['icon'] as IconData, color: n['color'] as Color, size: 26),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n['title'] as String,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              Text(n['body'] as String,
                                  style: const TextStyle(
                                      fontSize: 12, height: 1.5, color: Color(0xFF5A6E63))),
                              const SizedBox(height: 6),
                              Text(n['time'] as String,
                                  style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}