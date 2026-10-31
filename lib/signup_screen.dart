import 'package:flutter/material.dart';
import 'user_store.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);
const Color _mint = Color(0xFFEAF6F0);

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _terms = false;
  bool _loading = false;

  String? _nameErr, _emailErr, _phoneErr, _passErr, _confirmErr, _termsErr;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _name.text.trim();
    final email = _email.text.trim();
    final phone = _phone.text.replaceAll(' ', '').trim();
    final pass = _password.text;

    setState(() {
      _nameErr = name.split(' ').length < 2 ? 'يرجى إدخال اسمك الثنائي على الأقل للمتابعة.' : null;
      _emailErr = RegExp(r'^[\w.-]+@[\w-]+\.[a-zA-Z]{2,}$').hasMatch(email)
          ? null
          : 'يرجى إدخال عنوان بريد إلكتروني صالح وصحيح.';
      _phoneErr = RegExp(r'^01[0-9]{9}$').hasMatch(phone)
          ? null
          : 'يرجى إدخال رقم هاتف مصري صحيح (11 رقم يبدأ بـ 01).';
      _passErr = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(pass)
          ? null
          : 'كلمة المرور لازم تكون 8 أحرف على الأقل، وتحتوي على حرف كبير، وحرف صغير، ورقم، ورمز (@\$!%*?&).';
      _confirmErr= RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(pass)
          ? null
          : 'كلمة المرور لازم تكون 8 أحرف على الأقل، وتحتوي على حرف كبير، وحرف صغير، ورقم، ورمز (@\$!%*?&).';
      _confirmErr = _confirm.text == pass ? null : 'كلمتا المرور غير متطابقتين.';
      _termsErr = _terms ? null : 'يجب الموافقة على الشروط والأحكام لإنشاء الحساب.';
    });

    final hasError = [_nameErr, _emailErr, _phoneErr, _passErr, _confirmErr, _termsErr]
        .any((e) => e != null);
    if (hasError) return;

    setState(() => _loading = true);
    final ok = await UserStore.register(
      name: name,
      email: email,
      phone: phone,
      password: pass,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('هذا البريد مسجل بالفعل')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إنشاء حسابك بنجاح! سجّل دخولك الآن')),
    );
    Navigator.pop(context);
  }

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
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text('إنشاء حساب',
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [_green, Color(0xFF033524)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('انضم إلى AgriAI',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                          SizedBox(height: 4),
                          Text(
                              'أنشئ حسابك لمتابعة محاصيلك وتشخيص الأمراض النباتية بدقة الذكاء الاصطناعي حقلياً.',
                              style: TextStyle(color: Color(0xFFD1FAE5), fontSize: 12, height: 1.6)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF3F4F6)),
                      ),
                      child: Column(
                        children: [
                          _field('الاسم بالكامل', 'مطلوب', _name, 'أدخل اسمك بالكامل',
                              Icons.person_outline, _nameErr),
                          _field('البريد الإلكتروني', 'مطلوب', _email, 'farmer@delta-agri.eg',
                              Icons.mail_outline, _emailErr,
                              type: TextInputType.emailAddress, ltr: true),
                          _field('رقم الهاتف المحمول', 'لتنبيهات الحقل', _phone, '010 1234 5678',
                              Icons.phone_outlined, _phoneErr,
                              type: TextInputType.phone, ltr: true),
                          _field('كلمة المرور', '8 أحرف + حرف كبير ورقم ورمز', _password, 'أنشئ كلمة مرور قوية',
                              Icons.lock_outline, _passErr,
                              obscure: _obscure1,
                              onToggle: () => setState(() => _obscure1 = !_obscure1)),
                          _field('تأكيد كلمة المرور', '', _confirm, 'أعد إدخال كلمة المرور',
                              Icons.lock_reset, _confirmErr,
                              obscure: _obscure2,
                              onToggle: () => setState(() => _obscure2 = !_obscure2)),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _terms,
                                activeColor: _agri,
                                onChanged: (v) => setState(() => _terms = v ?? false),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                      'أوافق على الشروط والأحكام وسياسة الخصوصية الخاصة بنظام AgriAI.',
                                      style: TextStyle(
                                          fontSize: 11, height: 1.5, color: Color(0xFF4B5563))),
                                ),
                              ),
                            ],
                          ),
                          if (_termsErr != null) _err(_termsErr!),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                              ),
                              onPressed: _loading ? null : _submit,
                              child: _loading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                                  : const Text('إنشاء حساب',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('لديك حساب بالفعل؟',
                              style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('تسجيل الدخول',
                                style: TextStyle(
                                    color: _agri, fontSize: 13, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, String tag, TextEditingController c, String hint, IconData icon,
      String? error,
      {TextInputType? type,
        bool ltr = false,
        bool obscure = false,
        VoidCallback? onToggle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
              const Spacer(),
              if (tag.isNotEmpty) Text(tag, style: const TextStyle(fontSize: 10, color: _agri)),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: c,
            keyboardType: type,
            obscureText: obscure,
            textDirection: ltr ? TextDirection.ltr : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
              prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF)),
              suffixIcon: onToggle != null
                  ? IconButton(
                icon: Icon(obscure ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF9CA3AF)),
                onPressed: onToggle,
              )
                  : null,
              filled: true,
              fillColor: _mint.withValues(alpha: 0.35),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: error != null ? const Color(0xFFDC2626) : const Color(0xFFE5E7EB))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _agri, width: 1.5)),
            ),
          ),
          if (error != null) _err(error),
        ],
      ),
    );
  }

  Widget _err(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(text, style: const TextStyle(fontSize: 11, color: Color(0xFFDC2626))),
    );
  }
}