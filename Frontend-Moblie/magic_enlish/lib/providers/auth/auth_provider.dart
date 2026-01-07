import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magic_enlish/data/repositories/auth/auth_repository.dart';
import 'package:magic_enlish/data/models/auth/ResponseLogin.dart';
import 'package:magic_enlish/data/services/user_service.dart';

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
    if (user.refreshToken != null) {
      await prefs.setString('refresh_token', user.refreshToken!);
    }

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
    print('🔐 ========== LOADING USER FROM STORAGE ==========');
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');
    final avatarUrl = prefs.getString('avatarUrl');

    print('🔐 user_id: $userId');
    print('🔐 user_name: $userName');
    print('🔐 user_email: $userEmail');
    print('🔐 access_token exists: ${accessToken != null}');
    if (accessToken != null && accessToken.length > 20) {
      debugPrint(
        '🔐 access_token (first 20 chars): ${accessToken.substring(0, 20)}...',
      );
    }
    print('🔐 refresh_token exists: ${refreshToken != null}');
    if (refreshToken != null && refreshToken.length > 20) {
      debugPrint(
        '🔐 refresh_token (first 20 chars): ${refreshToken.substring(0, 20)}...',
      );
    }

    if (userId != null &&
        userName != null &&
        userEmail != null &&
        accessToken != null) {
      _user = ResponseLogin(
        id: userId,
        name: userName,
        email: userEmail,
        accessToken: accessToken,
        refreshToken: refreshToken,
        avatarUrl: avatarUrl,
      );
      // ---------------------------------------------------------
      // [FIX]: Sync latest profile from backend to ensure data consistency
      // ---------------------------------------------------------
      if (userId != null && accessToken != null) {
        try {
          // Create a UserService instance (assuming it doesn't need constructor params)
          // If you need DI, pass it via constructor, but here we instantiate directly for brevity
          // or use the repository if available.
          final userService = UserService();
          final userResponse = await userService.getUserById(
            accessToken,
            userId,
          );

          if (userResponse.data != null) {
            final updatedUser = userResponse.data!;
            print('🔄 Syncing user profile from backend: ${updatedUser.name}');

            // Create new ResponseLogin with updated fields but keeping secrets
            final freshUser = ResponseLogin(
              id: updatedUser.id,
              name: updatedUser.name,
              email: updatedUser.email,
              accessToken: _user!.accessToken, // keep existing token
              refreshToken: _user!.refreshToken,
              avatarUrl: updatedUser.avatarUrl,
            );

            // Update state and persistence
            await setUser(freshUser);
            print('✅ User profile synced successfully');
          }
        } catch (e) {
          print('⚠️ Failed to sync user profile: $e');
          // Ignore error, keep using cached data
        }
      }
      // ---------------------------------------------------------

      print('✅ USER LOADED SUCCESSFULLY - isLoggedIn: true');
      notifyListeners();
    } else {
      print('❌ USER NOT LOADED - Missing required fields');
      print('❌ isLoggedIn: false');
    }
    print('🔐 ================================================');
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

    // Xóa dữ liệu user nhưng GIỮ LẠI onboarding_completed
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('avatarUrl');
    await prefs.remove('onboarding_completed'); // Reset onboarding khi logout
  }
}
