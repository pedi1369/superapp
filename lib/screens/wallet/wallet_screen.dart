import 'package:flutter/material.dart';
import 'package:superapp/theme/app_theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _activeTab = 0; // 0=charge, 1=transfer
  String _selectedAmount = '۵۰,۰۰۰';
  final TextEditingController _amountController = TextEditingController(text: '۵۰,۰۰۰');
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final List<String> _quickAmounts = ['۵۰,۰۰۰', '۱۰۰,۰۰۰', '۱۵۰,۰۰۰', '۲۰۰,۰۰۰', '۳۰۰,۰۰۰', '۵۰۰,۰۰۰'];

  // تاریخچه تراکنش‌ها
  final List<_Transaction> _transactions = [
    _Transaction('💳', 'شارژ حساب', '۲ ساعت پیش', '+۲۰۰,۰۰۰', true, const Color(0x2610B981)),
    _Transaction('📤', 'انتقال وجه', 'دیروز', '-۵۰,۰۰۰', false, const Color(0x26F87171)),
    _Transaction('📄', 'پرداخت قبض', '۳ روز پیش', '-۱۲۰,۰۰۰', false, const Color(0x268B5CF6)),
    _Transaction('🎁', 'پاداش دعوت', '۵ روز پیش', '+۲۵,۰۰۰', true, const Color(0x26FBBF24)),
    _Transaction('🚗', 'خلافی', '۱ هفته پیش', '-۳۵۰,۰۰۰', false, const Color(0x26F87171)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              // ─── هدر ───
              _buildHeader(),
              
              // ─── موجودی ───
              _buildBalance(),
              
              // ─── تب‌ها ───
              _buildTabs(),
              
              // ─── فرم ───
              if (_activeTab == 0) _buildChargeForm(),
              if (_activeTab == 1) _buildTransferForm(),
              
              // ─── تراکنش‌ها ───
              _buildTransactions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Text('➡️', style: TextStyle(fontSize: 22)),
          ),
          const Text(
            '💳 کیف پول',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildBalance() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            'موجودی',
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '۱۲,۵۰۰,۰۰۰',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [AppTheme.success, Color(0xFF34D399)],
                    ).createShader(const Rect.fromLTWH(0, 0, 250, 50)),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'تومان',
                style: AppTheme.caption.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(child: _buildTab(0, '💳 شارژ حساب')),
          const SizedBox(width: 8),
          Expanded(child: _buildTab(1, '📤 انتقال وجه')),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String text) {
    final isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primary.withOpacity(0.2) : AppTheme.glassBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? AppTheme.primary.withOpacity(0.4) : AppTheme.glassBorder,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? AppTheme.text : AppTheme.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  //  فرم شارژ
  // ═══════════════════════════════════
  Widget _buildChargeForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      child: Column(
        children: [
          // مبالغ آماده
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _quickAmounts.map((amt) {
              final isActive = _selectedAmount == amt;
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedAmount = amt;
                  _amountController.text = amt;
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: (MediaQuery.of(context).size.width - 56) / 3,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: isActive ? AppTheme.primary.withOpacity(0.2) : AppTheme.glassBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isActive ? AppTheme.primary : AppTheme.glassBorder,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      amt,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isActive ? AppTheme.text : AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 14),
          
          // فیلد مبلغ
          _buildInputField('مبلغ را وارد کنید (تومان)', _amountController, center: true),
          
          // خلاصه
          _buildSummary(),
          
          // دکمه شارژ
          _buildActionButton('💰 شارژ حساب'),
        ],
      ),
    );
  }

  // ═══════════════════════════════════
  //  فرم انتقال
  // ═══════════════════════════════════
  Widget _buildTransferForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      child: Column(
        children: [
          _buildInputField('📱 شماره موبایل گیرنده', _mobileController),
          _buildInputField('مبلغ (تومان)', _amountController, center: true),
          _buildInputField('توضیح (اختیاری)', _descController),
          
          // محدودیت‌ها
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('📋 محدودیت‌ها', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('حداقل: ۲۰,۰۰۰ | حداکثر: ۵۰۰,۰۰۰', style: AppTheme.caption),
                Text('سقف روزانه: ۲۰۰,۰۰۰ تومان', style: AppTheme.caption),
              ],
            ),
          ),
          
          _buildActionButton('📤 انتقال وجه'),
        ],
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController ctrl, {bool center = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        textAlign: center ? TextAlign.center : TextAlign.right,
        style: AppTheme.body.copyWith(fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppTheme.textMuted),
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
            borderSide: const BorderSide(color: AppTheme.primary),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          _summaryRow('مبلغ شارژ', '۵۰,۰۰۰ تومان'),
          _summaryRow('مالیات (۹٪)', '۴,۵۰۰ تومان'),
          const Divider(color: AppTheme.divider, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('جمع کل', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              Text(
                '۵۴,۵۰۰ تومان',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.caption),
          Text(value, style: AppTheme.body.copyWith(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: AppTheme.primaryButton,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  //  تراکنش‌ها
  // ═══════════════════════════════════
  Widget _buildTransactions() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('آخرین تراکنش‌ها', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          ..._transactions.map((tx) => _buildTransactionItem(tx)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(_Transaction tx) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
      ),
      child: Row(
        children: [
          // آیکون
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tx.bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(tx.icon, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          
          // اطلاعات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(tx.date, style: AppTheme.caption.copyWith(color: AppTheme.textMuted)),
              ],
            ),
          ),
          
          // مبلغ
          Text(
            tx.amount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: tx.isIncome ? AppTheme.income : AppTheme.expense,
            ),
          ),
        ],
      ),
    );
  }
}

class _Transaction {
  final String icon;
  final String title;
  final String date;
  final String amount;
  final bool isIncome;
  final Color bgColor;
  _Transaction(this.icon, this.title, this.date, this.amount, this.isIncome, this.bgColor);
}
