import 'package:flutter/material.dart';
import 'scan_screen.dart';

class InspectionDetailsScreen extends StatelessWidget {
  final String cropName;
  final String cropImage;
  final String diseaseName;
  final String diseaseEnglish;
  final int confidence;
  final String severity;
  final String inspectionDate;
  final String location;

  const InspectionDetailsScreen({
    super.key,
    this.cropName = 'القمح',
    this.cropImage = 'assets/wheat.jpeg',
    this.diseaseName = 'صدأ الأوراق الأصفر',
    this.diseaseEnglish =
    'Yellow Rust (Puccinia striiformis)',
    this.confidence = 78,
    this.severity = 'متوسطة إلى مرتفعة',
    this.inspectionDate = '2026/10/29',
    this.location = 'الحقل الشمالي - قطاع 4',
  });

  static const forest = Color(0xFF064E36);
  static const green = Color(0xFF087B55);
  static const mint = Color(0xFFEAF6F0);
  static const pageBg = Color(0xFFF7FAF8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: forest,
        foregroundColor: Colors.white,
        title: const Text(
          'تفاصيل الفحص',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: mint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified, color: green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'فحص ميداني موثق',
                    style: TextStyle(
                      color: forest,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('AI v2.4'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              cropImage,
              height: 210,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 210,
                color: mint,
                child: const Icon(
                  Icons.eco,
                  size: 70,
                  color: green,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    _tag('$cropName | Crop'),
                    _tag('الثقة $confidence%'),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  diseaseName,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: forest,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  diseaseEnglish,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'مستوى الخطورة: $severity',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'بيانات الفحص والتسجيل',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: forest,
                  ),
                ),
                const SizedBox(height: 18),
                _info(
                  Icons.calendar_month,
                  'التاريخ والوقت',
                  inspectionDate,
                ),
                const Divider(height: 24),
                _info(
                  Icons.location_on_outlined,
                  'الموقع الميداني',
                  location,
                ),
                const Divider(height: 24),
                _info(
                  Icons.image_outlined,
                  'صورة المحصول',
                  cropImage.split('/').last,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _card(
            color: mint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.shield_outlined, color: green),
                    SizedBox(width: 8),
                    Text(
                      'التوصيات السريعة',
                      style: TextStyle(
                        color: forest,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                _Advice(
                  text:
                  'افحص النباتات المجاورة بانتظام لرصد أي إصابات جديدة.',
                ),
                _Advice(
                  text:
                  'استشر مهندسًا زراعيًا لتحديد العلاج المناسب بعد تأكيد التشخيص.',
                ),
                _Advice(
                  text:
                  'استخدم المبيدات الفطرية المعتمدة فقط، واتبع تعليمات الملصق.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: forest,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('معلومات المرض'),
                    content: Text(
                      '$diseaseName\n\n'
                          'الاسم العلمي: $diseaseEnglish\n\n'
                          'درجة الثقة: $confidence%\n\n'
                          'استشر مختصًا زراعيًا قبل اختيار العلاج.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text('إغلاق'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text(
                'عرض معلومات المرض والبروتوكول الكامل',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تصدير PDF يحتاج إضافة مكتبة PDF للمشروع.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('تصدير تقرير PDF'),
          ),
          const SizedBox(height: 10),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScanScreen(
                    cropName: cropName,
                    cropImage: cropImage,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text('فحص نبات جديد'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static Widget _card({
    required Widget child,
    Color color = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5EFE9)),
      ),
      child: child,
    );
  }

  static Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: mint,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: forest,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  static Widget _info(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      children: [
        Icon(icon, color: green, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Advice extends StatelessWidget {
  final String text;

  const _Advice({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.circle,
            size: 8,
            color: InspectionDetailsScreen.green,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}