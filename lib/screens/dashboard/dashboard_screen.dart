import 'package:flutter/material.dart';
import 'package:superapp/theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _balanceHidden = false;
  bool _showWelcome = true;
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showWelcome = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── هدر ───
              _buildHeader(),
              
              // ─── نوتیفیکیشن خوش‌آمدگویی ───
              if (_showWelcome) _buildWelcomeToast(),
              
              // ─── باکس موجودی ───
              _buildBalanceCard(),
              
              // ─── نوار سرویس‌ها ───
              _buildServiceStrip(),
              
              // ─── پیام روزانه ───
              _buildDailyMessage(),
              
              // ─── بخش خدمات ───
              _buildServicesSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  //  هدر
  // ═══════════════════════════════════
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // آواتار
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
            ),
            child: const Center(
              child: Text('👤', style: TextStyle(fontSize: 20)),
            ),
          ),
          
          // آیکون‌ها
          Row(
            children: [
              _buildIconBtn('🔔', hasBadge: true),
              const SizedBox(width: 10),
              _buildIconBtn('📱'),
              const SizedBox(width: 10),
              _buildIconBtn(_balanceHidden ? '☀️' : '🌙'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconBtn(String icon, {bool hasBadge = false}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppTheme.glassBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          if (hasBadge)
            Positioned(
              top: 6,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════
  //  نوتیفیکیشن خوش‌آمدگویی
  // ═══════════════════════════════════
  Widget _buildWelcomeToast() {
    return AnimatedOpacity(
      opacity: _showWelcome ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: AppTheme.successGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.success.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text('👋', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Text(
              'سلام پدرام! خوش آمدید',
              style: AppTheme.body.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  //  باکس موجودی
  // ═══════════════════════════════════
  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.glassBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'موجودی کیف پول',
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // مبلغ
              Expanded(
                child: Text(
                  _balanceHidden ? '••••••••' : '۱۲,۵۰۰,۰۰۰',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.text,
                  ),
                ),
              ),
              Text(
                'تومان',
                style: AppTheme.caption.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => _balanceHidden = !_balanceHidden),
                child: Text(
                  _balanceHidden ? '🙈' : '👁️',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // دکمه‌ها
          Row(
            children: [
              Expanded(
                child: _buildGlassButton('💳 شارژ حساب'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildGlassButton('📤 انتقال وجه'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTheme.body.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  //  نوار سرویس‌ها
  // ═══════════════════════════════════
  Widget _buildServiceStrip() {
    final items = [
      _StripItem('🚕', 'تاکسی'),
      _StripItem('🛍️', 'فروشگاه'),
      _StripItem('🏦', 'مالی'),
      _StripItem('🚗', 'خودرو'),
    ];

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.card.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.glassBorder),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(item.icon, style: const TextStyle(fontSize: 26)),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ═══════════════════════════════════
  //  پیام روزانه
  // ═══════════════════════════════════
  Widget _buildDailyMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.glassBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.glassBorder),
        borderRight: const BorderSide(color: AppTheme.primary, width: 4),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(child: Text('📢', style: TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'اطلاع‌رسانی امروز',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  'با دعوت دوستان خود ۱۰٪ کمیسیون دریافت کنید!',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════
  //  بخش خدمات
  // ═══════════════════════════════════
  Widget _buildServicesSection() {
    final services = [
      _ServiceItem('📄', 'پرداخت قبض', const Color(0x1F8B5CF6)),
      _ServiceItem('🚗', 'خلافی', const Color(0x1FF87171)),
      _ServiceItem('📱', 'شارژ', const Color(0x1F34D399)),
      _ServiceItem('📶', 'اینترنت', const Color(0x1FFBBF24)),
      _ServiceItem('🎫', 'بلیط', const Color(0x1F60A5FA)),
      _ServiceItem('🎁', 'دعوت', const Color(0x1FF472B8)),
      _ServiceItem('🛡️', 'بیمه', const Color(0x1F34D399)),
      _ServiceItem('💰', 'حواله', const Color(0x1FFF97316)),
      _ServiceItem('📋', 'استعلام', const Color(0x1FA78BFA)),
      _ServiceItem('🤖', 'AI', const Color(0x1F60A5FA)),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard,
      child: Column(
        children: [
          // هدر
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('خدمات', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              Text(
                'مشاهده همه ←',
                style: TextStyle(fontSize: 12, color: AppTheme.primaryLight, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // گرید
          Wrap(
            spacing: 12,
            runSpacing: 16,
            children: services.map((s) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 96) / 5,
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: s.color,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppTheme.glassBorder),
                      ),
                      child: Center(
                        child: Text(s.icon, style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      s.label,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─── مدل‌های کمکی ───
class _StripItem {
  final String icon;
  final String label;
  _StripItem(this.icon, this.label);
}

class _ServiceItem {
  final String icon;
  final String label;
  final Color color;
  _ServiceItem(this.icon, this.label, this.color);
}
