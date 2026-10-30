import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserStore {
  static const _key = 'users_list';
  static const _currentKey = 'current_user';

  static Future<List<Map<String, dynamic>>> _all() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  static Future<void> _saveAll(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(users));
  }

  static Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final users = await _all();
    if (users.any((u) => u['email'] == email)) return false;
    users.add({'name': name, 'email': email, 'phone': phone, 'password': password});
    await _saveAll(users);
    return true;
  }

  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final users = await _all();
    for (final u in users) {
      if (u['email'] == email && u['password'] == password) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_currentKey, jsonEncode(u));
        return u;
      }
    }
    return null;
  }

  static Future<Map<String, dynamic>?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_currentKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentKey);
  }
  static Future<void> updateCurrent({
    required String name,
    required String email,
    required String phone,
  }) async {
    final cur = await currentUser();
    if (cur == null) return;
    final users = await _all();
    for (final u in users) {
      if (u['email'] == cur['email']) {
        u['name'] = name;
        u['email'] = email;
        u['phone'] = phone;
      }
    }
    await _saveAll(users);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _currentKey,
      jsonEncode({...cur, 'name': name, 'email': email, 'phone': phone}),
    );
  }
}