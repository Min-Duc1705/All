import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magic_enlish/data/repositories/auth/auth_repository.dart';
import 'package:magic_enlish/data/models/auth/ResponseLogin.dart';

class AuthProvider with ChangeNotifier {
  ResponseLogin? _user;

  ResponseLogin? get user => _user;
  bool get isLoggedIn => _user != null;

  // Lưu thông tin user sau khi đăng nhập
  Future<void> setUser(ResponseLogin user) async {
    _user = user;
    notifyListeners();

    // Lưu vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
    await prefs.setString('access_token', user.accessToken);

    // chỉ persist avatar khi có giá trị thực
    if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
      await prefs.setString('avatarUrl', user.avatarUrl!);
    } else {
      await prefs.remove('avatarUrl');
    }

    // (tuỳ chọn) debug
    debugPrint('AUTH_PROVIDER: setUser avatarUrl=${user.avatarUrl}');
  }

  // Load thông tin user từ SharedPreferences khi mở app
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');
    final accessToken = prefs.getString('access_token');
    final avatarUrl = prefs.getString('avatarUrl');

    if (userId != null &&
        userName != null &&
        userEmail != null &&
        accessToken != null) {
      _user = ResponseLogin(
        id: userId,
        name: userName,
        email: userEmail,
        accessToken: accessToken,
        avatarUrl: avatarUrl,
      );
      notifyListeners();
    }
  }

  final AuthRepository _authRepository = AuthRepository();

  // Đăng xuất
  Future<void> logout() async {
    try {
      final token = _user?.accessToken ?? '';
      if (token.isNotEmpty) {
        // Call backend logout
        await _authRepository.logout(token);
      }
    } catch (e) {
      // ignore errors on logout request
    }

    _user = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
