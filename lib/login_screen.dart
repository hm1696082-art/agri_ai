import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'user_store.dart';

const Color _green = Color(0xFF064E36);
const Color _agri = Color(0xFF087B55);
const Color _mint = Color(0xFFEAF6F0);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _remember = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    final user = await UserStore.login(_email.text.trim(), _password.text);
    if (!mounted) return;
    setState(() => _loading = false);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('البريد أو كلمة المرور غير صحيحة، أو الحساب غير مسجل')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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
                    child: Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                    ),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF3F4F6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _mint,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.eco, color: _green, size: 20),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('AgriAI',
                                      style: TextStyle(
                                          color: _green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)),
                                  Text('المنظومة الزراعية الذكية',
                                      style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _mint,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('مصر',
                                    style: TextStyle(
                                        fontSize: 11, fontWeight: FontWeight.w700, color: _agri)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('أهلاً بعودتك!',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF111827))),
                          const SizedBox(height: 4),
                          const Text('سجّل دخولك للوصول إلى خدمات AgriAI.',
                              style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                          const SizedBox(height: 20),
                          _label('البريد الإلكتروني'),
                          TextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.left,
                            decoration: _inputDeco('أدخل بريدك الإلكتروني', Icons.mail_outline),
                          ),
                          const SizedBox(height: 14),
                          _label('كلمة المرور'),
                          TextField(
                            controller: _password,
                            obscureText: _obscure,
                            textAlign: TextAlign.left,
                            decoration: _inputDeco('أدخل كلمة المرور', Icons.lock_outline).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure ? Icons.visibility : Icons.visibility_off,
                                  color: const Color(0xFF9CA3AF),
                                ),
                                onPressed: () => setState(() => _obscure = !_obscure),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('نسيت كلمة المرور؟',
                                    style: TextStyle(
                                        color: _agri, fontSize: 12, fontWeight: FontWeight.w600)),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _remember,
                                activeColor: _green,
                                onChanged: (v) => setState(() => _remember = v ?? false),
                              ),
                              const Text('تذكرني',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: _loading ? null : _login,
                              child: _loading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                                  : const Text('تسجيل الدخول',
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ليس لديك حساب؟',
                            style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignupScreen()),
                          ),
                          child: const Text('إنشاء حساب جديد',
                              style: TextStyle(
                                  color: _agri, fontSize: 13, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _mint,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD2EDE0)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified_user, color: _green, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'منظومة معتمدة للأمن الغذائي والتشخيص الذكي لمحاصيل القمح والأرز والطماطم',
                              style: TextStyle(fontSize: 11, height: 1.6, color: _green),
                            ),
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
    );
  }

  InputDecoration _inputDeco(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
      prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _agri, width: 1.5),
      ),
    );
  }
}