import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const OpenMOIHomeApp());
}

class OpenMOIHomeApp extends StatelessWidget {
  const OpenMOIHomeApp({super.key});

  static const Color accentBlue = Color.fromRGBO(52, 165, 235, 1.0); // #34A5EB
  static const Color accentLightBg = Color(0xFFE8F5FD);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenMOI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Web light gray
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentBlue,
          primary: accentBlue,
        ),
        fontFamily: 'Inter', // Assuming Inter or standard system font
      ),
      home: const WebMainScreen(),
    );
  }
}

class WebMainScreen extends StatefulWidget {
  const WebMainScreen({super.key});

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  // 0 = Overview, 1 = Android, 2 = Online
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 850;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? screenWidth * 0.1 : 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo / Brand
                  Row(
                    children: [
                      Image.asset('assets/images/logo.png', width: 44, height: 44, fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.sports_tennis_rounded, color: OpenMOIHomeApp.accentBlue, size: 28)),
                      const SizedBox(width: 10),
                      const Text(
                        'OpenMOI',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),

                  // Desktop Navigation Links
                  if (isDesktop)
                    Row(
                      children: [
                        _buildNavTextBtn(0, 'Overview'),
                        const SizedBox(width: 24),
                        _buildNavTextBtn(1, 'Android Native'),
                        const SizedBox(width: 24),
                        _buildNavTextBtn(2, 'Online Web App'),
                      ],
                    )
                  else
                    // Mobile Menu Icon
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, color: Color(0xFF334155)),
                      onPressed: () {
                        _showMobileMenu(context);
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section (Always visible on Overview, hidden or condensed on others)
            if (_selectedIndex == 0) _buildHeroSection(isDesktop),

            // Main Content Area
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? screenWidth * 0.1 : 20.0,
                vertical: 40.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildPageContent(_selectedIndex, isDesktop),
                  ),
                ),
              ),
            ),

            // Footer
            _buildFooter(isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTextBtn(int index, String text) {
    final isSelected = _selectedIndex == index;
    return TextButton(
      onPressed: () => _navigateTo(index),
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? OpenMOIHomeApp.accentBlue : const Color(0xFF475569),
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(text),
    );
  }


  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMobileNavBtn(0, 'Overview', Icons.home_rounded),
            _buildMobileNavBtn(1, 'Android Native App', Icons.android_rounded),
            _buildMobileNavBtn(2, 'Online Web App', Icons.language_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavBtn(int index, String text, IconData icon) {
    final isSelected = _selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSelected ? OpenMOIHomeApp.accentBlue : const Color(0xFF64748B)),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? OpenMOIHomeApp.accentBlue : const Color(0xFF334155),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _navigateTo(index);
      },
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.1 : 20.0,
        vertical: isDesktop ? 80.0 : 50.0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: OpenMOIHomeApp.accentLightBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Physics Companion App',
                  style: TextStyle(color: OpenMOIHomeApp.accentBlue, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Measure Paddle & Racquet Physics with the OpenMOI Oscillator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isDesktop ? 48 : 32,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'OpenMOI is the official companion app for the physical paddle/racquet oscillator device. It uses smartphone motion sensors mounted on the device to calculate Moment of Inertia (MOI), Swing Weight (SW), and Twist Weight (TW). It can also be used as a standalone app to estimate these values.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 16,
                  color: const Color(0xFF475569),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),
              if (isDesktop)
                Image.asset(
                  'assets/images/device.png',
                  height: 300,
                  errorBuilder: (c, e, s) => const SizedBox(),
                )
              else
                Image.asset(
                  'assets/images/device.png',
                  height: 200,
                  errorBuilder: (c, e, s) => const SizedBox(),
                ),
              const SizedBox(height: 30),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _navigateTo(1),
                    icon: const Icon(Icons.download_rounded, size: 20),
                    label: const Text('Download Android App'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: OpenMOIHomeApp.accentBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _navigateTo(2),
                    icon: const Icon(Icons.language_rounded, size: 20),
                    label: const Text('Launch Web App'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

  Widget _buildFooter(bool isDesktop) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.1 : 20.0,
        vertical: 40.0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 20,
                        height: 20,
                        errorBuilder: (c, e, s) => const Icon(Icons.sports_tennis_rounded, color: Color(0xFF94A3B8), size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '2026 OpenMOI Project.',
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(int index, bool isDesktop) {
    if (index == 0) return _OverviewContent(isDesktop: isDesktop);
    if (index == 1) return _AndroidContent(isDesktop: isDesktop, onBack: () => _navigateTo(0));
    if (index == 2) return _OnlineContent(isDesktop: isDesktop, onBack: () => _navigateTo(0));
    return const SizedBox();
  }
}

// ============================================================================
// OVERVIEW CONTENT
// ============================================================================
class _OverviewContent extends StatelessWidget {
  final bool isDesktop;
  const _OverviewContent({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Features Grid
        const Text(
          'Core Capabilities',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            int columns = constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 500 ? 2 : 1);
            double aspectRatio = constraints.maxWidth > 800 ? 1.4 : (constraints.maxWidth > 500 ? 1.3 : 1.8);
            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: aspectRatio,
              children: [
                _WebFeatureCard(
                  icon: Icons.scale_rounded,
                  title: 'Swing & Twist Weight',
                  description: 'Calculate MOI about the handle axis (SW) and center axis (TW) to assess paddle maneuverability and sweet-spot power.',
                  iconBg: const Color(0xFFEFF6FF),
                  iconColor: OpenMOIHomeApp.accentBlue,
                ),
                _WebFeatureCard(
                  icon: Icons.sensors_rounded,
                  title: 'Oscillator Timer',
                  description: 'Turn your smartphone into a high-precision oscillator timer utilizing high-frequency Gyro & Accelerometer APIs when mounted on the hardware device.',
                  iconBg: const Color(0xFFFAF5FF),
                  iconColor: const Color(0xFF9333EA),
                ),
                _WebFeatureCard(
                  icon: Icons.analytics_rounded,
                  title: 'Sine-Wave Fitting',
                  description: 'Performs non-linear curve fitting on raw motion data with automated Fit Residual Score exclusion for accuracy.',
                  iconBg: const Color(0xFFFEF2F2),
                  iconColor: const Color(0xFFDC2626),
                ),
                _WebFeatureCard(
                  icon: Icons.tune_rounded,
                  title: 'Rig Zeroing & Calibrating',
                  description: 'Two-object calibration workflow to determine spring constant (κ) and Tare adapter inertia isolation.',
                  iconBg: const Color(0xFFF8FAFC),
                  iconColor: const Color(0xFF475569),
                ),
                _WebFeatureCard(
                  icon: Icons.functions_rounded,
                  title: 'Physics-Informed Engine',
                  description: 'Leverages a physics-informed, empirically developed estimation engine to model and calculate complex racquet dynamics.',
                  iconBg: const Color(0xFFECFEFF),
                  iconColor: const Color(0xFF0891B2),
                ),
                _WebFeatureCard(
                  icon: Icons.lightbulb_outline_rounded,
                  title: 'Intuitive & User-Friendly',
                  description: 'Designed with a clean, accessible interface that makes capturing complex physics measurements simple and straightforward.',
                  iconBg: const Color(0xFFFFFBEB),
                  iconColor: const Color(0xFFD97706),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ============================================================================
// ANDROID NATIVE CONTENT
// ============================================================================
class _AndroidContent extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onBack;
  const _AndroidContent({required this.isDesktop, required this.onBack});

  Future<void> _downloadApk() async {
    final Uri url = Uri.parse('OpenMOI.apk');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF64748B)),
              onPressed: onBack,
              tooltip: 'Back to Overview',
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: OpenMOIHomeApp.accentLightBg, borderRadius: BorderRadius.circular(8)),
              child: const Text('RECOMMENDED PLATFORM FOR ANDROID USERS', style: TextStyle(color: OpenMOIHomeApp.accentBlue, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Native Android Application',
          style: TextStyle(fontSize: isDesktop ? 40 : 28, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A), height: 1.1),
        ),
        const SizedBox(height: 16),
        const Text(
          'The Android native build is engineered for maximum precision. By bypassing web browser restrictions, it accesses the device\'s SensorManager directly to deliver uncompromised measurement stability.',
          style: TextStyle(fontSize: 18, color: Color(0xFF475569), height: 1.6),
        ),
        const SizedBox(height: 40),

        // Split Layout for Desktop
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isDesktop ? 1 : 0,
              child: Column(
                children: [
                  _WebBenefitRow(
                    icon: Icons.memory_rounded,
                    title: 'Better Hardware Utilization',
                    description: 'Direct low-level Android API access enables unthrottled 100Hz–200Hz sensor polling, minimal latency, and zero browser frame jitter for higher sine-wave fit scores.',
                  ),
                  const SizedBox(height: 30),
                  _WebBenefitRow(
                    icon: Icons.wifi_off_rounded,
                    title: '100% Offline Functionality',
                    description: 'Measure equipment on the court, in the workshop, or in the lab without needing Wi-Fi or cellular connections to load web scripts.',
                  ),
                ],
              ),
            ),
            if (isDesktop) const SizedBox(width: 60),
            if (!isDesktop) const SizedBox(height: 40),
            
            // Download Card
            Expanded(
              flex: isDesktop ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Download Package', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    const SizedBox(height: 12),
                    const Text('Install the standalone APK directly onto your Android phone.', style: TextStyle(color: Color(0xFF475569), height: 1.5)),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _downloadApk,
                        icon: const Icon(Icons.file_download_rounded, size: 22),
                        label: const Text('Download OpenMOI.apk (~54 MB)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: OpenMOIHomeApp.accentBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 16),
                    const Text('Installation Instructions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    _buildTextStep('1. Tap download to save the APK to your device.'),
                    _buildTextStep('2. Open the downloaded file from notifications.'),
                    _buildTextStep('3. Navigate to Settings > Security and Privacy and disable "Auto Blocker" (Samsung devices).'),
                    _buildTextStep('4. Allow "Install from Unknown Sources" if prompted.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
    );
  }
}

// ============================================================================
// ONLINE WEB CONTENT
// ============================================================================
class _OnlineContent extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onBack;
  const _OnlineContent({required this.isDesktop, required this.onBack});

  Future<void> _launchOnlineTool() async {
    final Uri url = Uri.parse('https://jat08.github.io/open_moi_pwa/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF64748B)),
              onPressed: onBack,
              tooltip: 'Back to Overview',
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
              child: const Text('UNIVERSAL ACCESS', style: TextStyle(color: Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Online Web Version',
          style: TextStyle(fontSize: isDesktop ? 40 : 28, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A), height: 1.1),
        ),
        const SizedBox(height: 16),
        const Text(
          'The PWA version allows users on Android and iPhones to quickly run measurements and make estimations directly inside a web browser without installing native packages.',
          style: TextStyle(fontSize: 18, color: Color(0xFF475569), height: 1.6),
        ),
        const SizedBox(height: 32),

        Center(
          child: ElevatedButton.icon(
            onPressed: _launchOnlineTool,
            icon: const Icon(Icons.open_in_new_rounded, size: 22),
            label: const Text('Launch Online Web App (GitHub Pages)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: OpenMOIHomeApp.accentBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 40),

        // PWA Installation & Offline Support Card
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.install_mobile_rounded, color: OpenMOIHomeApp.accentBlue, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'PWA Installation & Offline Functionality',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.wifi_off_rounded, color: Color(0xFF16A34A), size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Offline Caching: Once opened or installed, the web app caches all required application files locally on your device. You can run measurements completely offline on subsequent uses without an internet connection.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF166534), height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Optional Installation Instructions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
              const SizedBox(height: 16),
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.android_rounded, color: Color(0xFF3DDC84), size: 20),
                            SizedBox(width: 8),
                            Text('Android (Chrome / Edge)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1E293B))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildTextStep('1. Open the web app link in Chrome.'),
                        _buildTextStep('2. Tap the Menu icon (3 vertical dots) in the top right.'),
                        _buildTextStep('3. Select "Add to Home screen" or "Install app".'),
                      ],
                    ),
                  ),
                  if (isDesktop) const SizedBox(width: 32),
                  if (!isDesktop) const SizedBox(height: 20),
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.apple_rounded, color: Color(0xFF000000), size: 20),
                            SizedBox(width: 8),
                            Text('iOS (Safari)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1E293B))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildTextStep('1. Open the web app link in Safari.'),
                        _buildTextStep('2. Tap the Share button (square with arrow pointing up).'),
                        _buildTextStep('3. Scroll down and select "Add to Home Screen".'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: OpenMOIHomeApp.accentLightBg,
            border: Border.all(color: OpenMOIHomeApp.accentBlue.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded, color: OpenMOIHomeApp.accentBlue, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Browser Limitations to Consider', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: OpenMOIHomeApp.accentBlue)),
                    const SizedBox(height: 12),
                    _buildWarningItem('Initial Connection:', 'Requires an initial web connection to load and cache application files; works fully offline afterwards.'),
                    const SizedBox(height: 12),
                    _buildWarningItem('Apple iOS Hardware Limits:', 'Web APIs introduce polling overhead. On iOS browsers, strict sensor permission policies and throttled sample rates (30Hz–60Hz) can cause sampling jitter during high-frequency physical oscillations.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF475569))),
    );
  }

  Widget _buildWarningItem(String bold, String desc) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 15, color: OpenMOIHomeApp.accentBlue, height: 1.5, fontFamily: 'Inter'),
        children: [
          TextSpan(text: '$bold ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: desc),
        ],
      ),
    );
  }
}

// ============================================================================
// REUSABLE WEB WIDGETS
// ============================================================================
class _WebFeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color iconBg;
  final Color iconColor;

  const _WebFeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconBg,
    required this.iconColor,
  });

  @override
  State<_WebFeatureCard> createState() => _WebFeatureCardState();
}

class _WebFeatureCardState extends State<_WebFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _isHovered ? OpenMOIHomeApp.accentBlue.withValues(alpha: 0.3) : const Color(0xFFE2E8F0), width: 1),
          boxShadow: _isHovered
              ? [BoxShadow(color: OpenMOIHomeApp.accentBlue.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10))]
              : [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.02), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: widget.iconBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(widget.icon, color: widget.iconColor, size: 24),
            ),
            const Spacer(),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebBenefitRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _WebBenefitRow({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: const Color(0xFF475569), size: 24),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(fontSize: 15, color: Color(0xFF64748B), height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
