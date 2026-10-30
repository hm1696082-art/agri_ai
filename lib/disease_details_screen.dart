import 'package:flutter/material.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);

class DiseaseDetailsScreen extends StatefulWidget {
  const DiseaseDetailsScreen({super.key});

  @override
  State<DiseaseDetailsScreen> createState() => _DiseaseDetailsScreenState();
}

class _DiseaseDetailsScreenState extends State<DiseaseDetailsScreen> {
  int _tab = 2;

  final List<String> _tabs = const ['الأعراض', 'الأسباب والظروف', 'الفروق والوقاية'];

  final List<List<String>> _rows = const [
    ['الميزة', 'صدأ أصفر (شريطي)', 'صدأ بني (أوراق)'],
    ['لون البقع', 'أصفر ليموني إلى برتقالي زاهٍ', 'بني محمر داكن إلى كستنائي'],
    ['المكان الرئيسي', 'نصل الورقة، السنابل، والأغماد', 'السطح العلوي لنصل الأوراق غالباً'],
    ['شكل البقع', 'خطوط وأشرطة طولية متوازية', 'بثرات دائرية أو بيضاوية مبعثرة'],
    ['توقيت الظهور', 'بداية الربيع والطقس البارد', 'أواخر الموسم والطقس الدافئ'],
  ];

  final List<List<String>> _measures = const [
    ['الأصناف المقاومة', 'زراعة تقاوي معتمدة ومقاومة وراثياً لسلالات الصدأ الأصفر السائدة في المنطقة.'],
    ['مراقبة المحصول والفحص الدوري', 'تتبع الحقول بانتظام وتفقد البؤر الأولى خاصة في حواف الحقل والرياح السائدة.'],
    ['الرش الفطري الموجه', 'استخدام المبيدات الفطرية الجهازية المعتمدة فور رصد أول بؤرة وفق تعليمات الإرشاد الزراعي.'],
    ['تقليل الظروف المشجعة للمرض', 'تجنب الكثافة النباتية الزائدة، والاعتدال في التسميد النيتروجيني، وإدارة مياه الري للحد من الرطوبة.'],
  ];

  final List<String> _sources = const [
    'منظمة الأغذية والزراعة (FAO) - الشبكة الدولية للصدأ',
    'مركز الزراعة والعلوم البيولوجية الدولي (CABI)',
    'وزارة الزراعة واستصلاح الأراضي - مركز البحوث الزراعية بمصر',
  ];

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
                    child: Column(
                      children: [
                        Text('معلومات المرض',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text('صدأ القمح الأصفر (المخطط)',
                            style: TextStyle(color: Color(0xFFA7F3D0), fontSize: 10)),
                      ],
                    ),
                  ),
                  _circleIcon(Icons.share, () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF6F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: List.generate(_tabs.length, (i) {
                    final active = _tab == i;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tab = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: active ? _green : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _tabs[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: active ? Colors.white : const Color(0xFF5A6E63),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: _tab == 2 ? _compareAndPrevention() : _placeholder(),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                  icon: const Icon(Icons.camera_alt_outlined, size: 18),
                  label: const Text('إجراء فحص نبات جديد',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Text(
        'محتوى هذا التبويب سيُضاف لاحقاً.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
      ),
    );
  }

  Widget _compareAndPrevention() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _card(
          title: 'الفرق بينه وبين أمراض مشابهة',
          subtitle: 'مقارنة حقلية دقيقة للتفريق بين صدأ القمح الأصفر وصدأ الأوراق البني.',
          child: Column(
            children: List.generate(_rows.length, (r) {
              final row = _rows[r];
              final isHeader = r == 0;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: isHeader ? const Color(0xFFEAF6F0) : Colors.transparent,
                  border: r == 0
                      ? null
                      : const Border(top: BorderSide(color: Color(0xFFF1F5F9))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(row[0],
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isHeader ? _green : const Color(0xFF374151))),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(row[1],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: isHeader ? FontWeight.w800 : FontWeight.w500,
                              color: isHeader ? _green : _agri)),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(row[2],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: isHeader ? FontWeight.w800 : FontWeight.w500,
                              color: isHeader ? _green : const Color(0xFF6B7280))),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14),
        _card(
          title: 'طرق الوقاية والإدارة',
          subtitle: 'إرشادات عملية موصى بها لحماية المحصول',
          child: Column(
            children: _measures
                .map((m) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 11,
                    backgroundColor: _agri,
                    child: Icon(Icons.check, size: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m[0],
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(m[1],
                            style: const TextStyle(
                                fontSize: 11, height: 1.6, color: Color(0xFF5A6E63))),
                      ],
                    ),
                  ),
                ],
              ),
            ))
                .toList(),
          ),
        ),
        const SizedBox(height: 14),
        _card(
          title: 'المصادر والمراجع المعتمدة',
          subtitle: 'تم التحقق من هذه التوصيات عبر مراكز بحوث زراعية دولية ومحلية:',
          bg: const Color(0xFFEAF6F0),
          child: Column(
            children: _sources
                .map((s) => Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified, size: 14, color: _agri),
                  const SizedBox(width: 8),
                  Expanded(child: Text(s, style: const TextStyle(fontSize: 11))),
                ],
              ),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required String subtitle,
    required Widget child,
    Color bg = Colors.white,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EDE9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _green)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
          const SizedBox(height: 12),
          child,
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