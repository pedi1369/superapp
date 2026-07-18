import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/wallet/wallet_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppTheme.background,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const SuperApp());
}

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppTheme.background,
        primaryColor: AppTheme.primary,
        textTheme: GoogleFonts.vazirmatnTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppTheme.primary,
          surface: AppTheme.surface,
        ),
      ),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const DashboardScreen(),
    const _PlaceholderScreen(title: '🛍️ فروشگاه'),
    const WalletScreen(),
    const _PlaceholderScreen(title: '👤 پروفایل'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface.withOpacity(0.95),
          border: const Border(
            top: BorderSide(color: AppTheme.glassBorder, width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, '🏠', 'خانه'),
                _buildNavItem(1, '🛍️', 'فروشگاه'),
                _buildNavItem(2, '💳', 'کیف پول'),
                _buildNavItem(3, '👤', 'پروفایل'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String icon, String label) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primary.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: TextStyle(fontSize: isActive ? 22 : 20)),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isActive ? AppTheme.primaryLight : AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: AppTheme.heading),
    );
  }
}
