import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:magic_enlish/features/home/home_screen.dart';
import 'package:magic_enlish/features/auth/register_screen.dart';
import 'package:magic_enlish/data/services/auth_service.dart';
import 'package:magic_enlish/data/models/auth/ResponseLogin.dart';
import 'package:magic_enlish/core/theme/app_colors.dart';
import 'package:magic_enlish/core/theme/app_text_styles.dart';
import 'package:magic_enlish/core/widgets/common/app_logo.dart';
import 'package:magic_enlish/core/widgets/form/custom_text_field.dart';
import 'package:magic_enlish/core/widgets/common/custom_button.dart';
import 'package:magic_enlish/core/utils/snackbar_utils.dart';
import 'package:provider/provider.dart';
import 'package:magic_enlish/providers/auth/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final authService = AuthService();
  bool isLoading = false;

  // Validation errors
  String? emailError;
  String? passwordError;

  bool _validateInputs() {
    bool isValid = true;

    setState(() {
      // Validate email
      if (emailCtrl.text.trim().isEmpty) {
        emailError = 'Please enter your email';
        isValid = false;
      } else if (!emailCtrl.text.contains('@') &&
          !emailCtrl.text.contains('.')) {
        emailError = 'Please enter a valid email';
        isValid = false;
      } else {
        emailError = null;
      }

      // Validate password
      if (passCtrl.text.isEmpty) {
        passwordError = 'Please enter your password';
        isValid = false;
      } else if (passCtrl.text.length < 6) {
        passwordError = 'Password must be at least 6 characters';
        isValid = false;
      } else {
        passwordError = null;
      }
    });

    return isValid;
  }

  Future<void> handleLogin() async {
    if (!_validateInputs()) {
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await authService.login(
        emailCtrl.text.trim(),
        passCtrl.text.trim(),
      );

      if (result.statusCode == 200 && result.data != null) {
        ResponseLogin responseLogin = result.data!;
        if (mounted) {
          // Lưu thông tin user vào AuthProvider
          await Provider.of<AuthProvider>(
            context,
            listen: false,
          ).setUser(responseLogin);
          // DEBUG: show avatar value returned by backend
          debugPrint(
            'LOGIN: responseLogin.avatarUrl=${responseLogin.avatarUrl}',
          );

          SnackBarUtils.showSuccess(
            context,
            'Welcome back, ${responseLogin.name}!',
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      } else {
        if (mounted) {
          SnackBarUtils.showError(context, result.message);
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'An error occurred: $e');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const AppLogo(),
                const SizedBox(height: 32),

                // LOGIN CARD BOX
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Welcome Back!",
                              style: AppTextStyles.screenTitle(),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Log in to continue your journey.",
                              style: AppTextStyles.subtitle(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // EMAIL FIELD
                      CustomTextField(
                        controller: emailCtrl,
                        hint: "Enter your email",
                        label: "Email or Username",
                        keyboardType: TextInputType.emailAddress,
                        errorText: emailError,
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD FIELD
                      Row(
                        children: [
                          Text("Password", style: AppTextStyles.label()),
                          const Spacer(),
                          Text("Forgot Password?", style: AppTextStyles.link()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: passCtrl,
                        hint: "Enter your password",
                        isPassword: true,
                        errorText: passwordError,
                      ),

                      const SizedBox(height: 24),

                      // LOGIN BUTTON
                      CustomButton(
                        text: "Login",
                        onPressed: handleLogin,
                        isLoading: isLoading,
                      ),
                      const SizedBox(height: 20),

                      // OR DIVIDER
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.borderColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text("or", style: AppTextStyles.body()),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.borderColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // GOOGLE BUTTON
                      CustomButton(
                        text: "Continue with Google",
                        onPressed: () {},
                        isOutlined: true,
                        icon: Image.network(
                          '${dotenv.env['Backend_URL']}/storage/google.png',
                          width: 24,
                          height: 24,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.g_mobiledata,
                                size: 28,
                                color: Colors.red,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // SIGN UP TEXT
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: AppTextStyles.body(),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text("Sign Up", style: AppTextStyles.link()),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
