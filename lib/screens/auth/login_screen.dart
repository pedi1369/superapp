import 'package:flutter/material.dart';
import 'package:superapp/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                
                // ─── لوگو ───
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('🚀', style: TextStyle(fontSize: 36)),
                  ),
                ),
                
                const SizedBox(height: 24),
                const Text(
                  'SuperApp',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'اپلیکیشن هوشمند چندمنظوره',
                  style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
                ),
                
                const SizedBox(height: 50),
                
                // ─── فرم ورود ───
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: AppTheme.glassCard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ورود / ثبت‌نام',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'شماره موبایل خود را وارد کنید',
                        style: AppTheme.caption,
                      ),
                      const SizedBox(height: 20),
                      
                      // فیلد شماره موبایل
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                        decoration: InputDecoration(
                          hintText: '۰۹۱۲۳۴۵۶۷۸۹',
                          hintStyle: TextStyle(color: AppTheme.textMuted),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.phone_android, color: AppTheme.primaryLight),
                          ),
                          filled: true,
                          fillColor: AppTheme.glassBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: AppTheme.glassBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: AppTheme.glassBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: AppTheme.primary, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // دکمه ارسال
                      GestureDetector(
                        onTap: () {
                          setState(() => _isLoading = true);
                          // TODO: API call
                          Future.delayed(const Duration(seconds: 2), () {
                            if (mounted) setState(() => _isLoading = false);
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: AppTheme.primaryButton,
                          child: Center(
                            child: _isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    '🔑 ارسال کد تایید',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // ─── متن قوانین ───
                Text(
                  'با ورود، قوانین و حریم خصوصی را می‌پذیرید',
                  style: AppTheme.caption.copyWith(fontSize: 11),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),
                
                // ─── ویژگی‌ها ───
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFeature('💳', 'کیف پول'),
                    _buildFeature('🚕', 'تاکسی'),
                    _buildFeature('🛍️', 'فروشگاه'),
                    _buildFeature('🏦', 'خدمات'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String icon, String label) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppTheme.glassBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.glassBorder),
          ),
          child: Center(child: Text(icon, style: const TextStyle(fontSize: 24))),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}
