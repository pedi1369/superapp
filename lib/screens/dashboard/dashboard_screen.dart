import 'package:flutter/material.dart';
import 'package:superapp/theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _balanceHidden = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: Stack(
        children: [
          // ─── هدر گرادیانت ───
          _buildGradientHeader(),
          
          // ─── محتوا ───
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  // فاصله برای هدر
                  const SizedBox(height: 200),
                  
                  // ─── بخش خدمات ───
                  _buildServicesSection(),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          
          // ─── دکمه‌های شناور ───
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  // ═══════════════════════════════════
  //  هدر گرادیانت بنفش-آبی
  // ═══════════════════════════════════
  Widget _buildGradientHeader() {
    return Container(
      height: 280,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2D1B69),  // بنفش تیره
            Color(0xFF1E3A5F),  // آبی تیره
            Color(0xFF1A237E),  // نیلی
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
          child: Column(
            children: [
              // ─── نوار بالا ───
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // برند
                  Row(
                    children: [
                      const Text(
                        '🚀',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'SuperApp',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  
                  // آیکون‌ها
                  Row(
                    children: [
                      _buildTopIcon(Icons.notifications_none_rounded),
                      const SizedBox(width: 8),
                      _buildTopIcon(Icons.grid_view_rounded),
                      const SizedBox(width: 8),
                      _buildAvatarBtn(),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // ─── موجودی ───
              Column(
                children: [
                  // لیبل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined,
                          color: Colors.white70, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'موجودی کیف پول',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // مخفی کردن
                  GestureDetector(
                    onTap: () => setState(() => _balanceHidden = !_balanceHidden),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _balanceHidden ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white70,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _balanceHidden ? 'نمایش' : 'مخفی',
                            style: const TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // مبلغ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        _balanceHidden ? '••••••••' : '۵۰۰,۰۰۰',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'تومان',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // کد دعوت
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🎁', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          'کد دعوت: ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const Text(
                          'RF12345',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopIcon(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildAvatarBtn() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 20),
    );
  }

  // ═══════════════════════════════════
  //  ۴ دکمه دایره‌ای اصلی
  // ═══════════════════════════════════
  Widget _buildFloatingButtons() {
    return Positioned(
      top: 230,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCircleBtn('💳', 'کیف پول', const Color(0xFF2196F3)),
            _buildCircleBtn('📤', 'انتقال', const Color(0xFF7C4DFF)),
            _buildCircleBtn('📱', 'QR', const Color(0xFF4CAF50)),
            _buildCircleBtn('🎁', 'دعوت', const Color(0xFFFF5252)),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleBtn(String icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 24)),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════
  //  پیام خوش‌آمدگویی
  // ═══════════════════════════════════
  Widget _buildWelcomeBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF7C4DFF)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('👋', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'خوش آمدید! امروز روز جدیدی برای موفقیتهای بزرگ است.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.95),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════
  //  بخش خدمات (پس‌زمینه سفید)
  // ═══════════════════════════════════
  Widget _buildServicesSection() {
    final services = [
      _ServiceItem('💳', 'شارژ', const Color(0xFF2196F3)),
      _ServiceItem('📄', 'پرداخت قبض', const Color(0xFF4CAF50)),
      _ServiceItem('📱', 'شارژ موبایل', const Color(0xFFFF9800)),
      _ServiceItem('🚗', 'راننده', const Color(0xFF2196F3)),
      _ServiceItem('🏪', 'کسب‌وکار', const Color(0xFFE91E63)),
      _ServiceItem('🎁', 'پاداش', const Color(0xFFFF9800)),
      _ServiceItem('📊', 'آمارها', const Color(0xFF00BCD4)),
      _ServiceItem('🎧', 'پشتیبانی', const Color(0xFF9E9E9E)),
      _ServiceItem('📱', 'اسکن QR', const Color(0xFF2196F3)),
      _ServiceItem('💰', 'کیف پول', const Color(0xFF4CAF50)),
      _ServiceItem('👥', 'دعوت', const Color(0xFF7C4DFF)),
      _ServiceItem('🔔', 'اعلانات', const Color(0xFFFFC107)),
      _ServiceItem('📋', 'رسیدها', const Color(0xFF9E9E9E)),
      _ServiceItem('📋', 'اسناد', const Color(0xFF607D8B)),
      _ServiceItem('ℹ️', 'اطلاعات', const Color(0xFF2196F3)),
      _ServiceItem('⚙️', 'تنظیمات', const Color(0xFF795548)),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // هدر
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '۱۶ سرویس',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'خدمات SuperApp',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.grid_view_rounded, size: 18, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          
          // گرید
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.95,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final s = services[index];
                return _buildServiceCard(s);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(_ServiceItem item) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: item.color.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF555555),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ServiceItem {
  final String icon;
  final String label;
  final Color color;
  _ServiceItem(this.icon, this.label, this.color);
}
