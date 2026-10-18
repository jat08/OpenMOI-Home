import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const OpenMOIHomeApp());
}

class OpenMOIHomeApp extends StatelessWidget {
  const OpenMOIHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenMOI-Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0381FE),
          primary: const Color(0xFF0381FE),
          surface: const Color(0xFFFFFFFF),
          surfaceContainerLowest: const Color(0xFFFFFFFF),
          surfaceContainerLow: const Color(0xFFF8FAFC),
        ),
        fontFamily: 'Roboto',
      ),
      home: const OneUIHomeScreen(),
    );
  }
}

class OneUIHomeScreen extends StatefulWidget {
  const OneUIHomeScreen({super.key});

  @override
  State<OneUIHomeScreen> createState() => _OneUIHomeScreenState();
}

class _OneUIHomeScreenState extends State<OneUIHomeScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    'OpenMOI Overview',
    'Android Version',
    'Online Version',
  ];

  final List<String> _subtitles = [
    'Moment of Inertia, Swing Weight & Twist Weight Measurement',
    'Maximized Hardware Performance & Offline Capability',
    'Instant Cross-Platform Web Browser Access',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // One UI Top Header
            _buildOneUIHeader(),

            // Page Content Area
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: SingleChildScrollView(
                  key: ValueKey<int>(_selectedIndex),
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? screenWidth * 0.12 : 16.0,
                    vertical: 16.0,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: _buildPageContent(_selectedIndex),
                    ),
                  ),
                ),
              ),
            ),

            // One UI 9.0 Floating Pill Navigation Bar
            _buildOneUINavigationBar(isWide),
          ],
        ),
      ),
    );
  }

  Widget _buildOneUIHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF4F6F8),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0EDFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0381FE),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'OpenMOI Portal',
                          style: TextStyle(
                            color: Color(0xFF0381FE),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _titles[_selectedIndex],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF191C1E),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _subtitles[_selectedIndex],
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5F6368),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOneUINavigationBar(bool isWide) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: const Color(0xFFE5E8EB), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.dashboard_rounded, 'Overview'),
              _buildNavItem(1, Icons.android_rounded, 'Android'),
              _buildNavItem(2, Icons.language_rounded, 'Online Web'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0381FE) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : const Color(0xFF5F6368),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF5F6368),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const OverviewPage();
      case 1:
        return const AndroidPage();
      case 2:
        return const OnlineVersionPage();
      default:
        return const OverviewPage();
    }
  }
}

// ============================================================================
// OVERVIEW PAGE
// ============================================================================
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Intro Banner Card
        _OneUICard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.sports_tennis_rounded, color: Color(0xFF0381FE), size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Open-Source Precision Equipment Analysis',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'OpenMOI is an open-source, cross-platform application and Progressive Web App (PWA) designed to measure Moment of Inertia (MOI), Swing Weight (SW), and Twist Weight (TW) of sports equipment—specifically pickleball paddles, tennis racquets, and custom athletic gear—using smartphone motion sensors.',
                style: TextStyle(fontSize: 14, color: Color(0xFF42474E), height: 1.5),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTag('Pickleball Paddles'),
                  _buildTag('Tennis Racquets'),
                  _buildTag('Zero-Hardware Sensors'),
                  _buildTag('Sine-Wave Fitting'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Quick Metrics Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 650 ? 4 : 2;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: constraints.maxWidth > 650 ? 1.4 : 1.3,
              children: [
                _buildMetricCard(
                  'Swing Weight',
                  'Handle Axis',
                  'Higher Inertia',
                  Icons.scale_rounded,
                  const Color(0xFFE0EDFF),
                  const Color(0xFF0381FE),
                ),
                _buildMetricCard(
                  'Twist Weight',
                  'Center Axis',
                  'Stability & Power',
                  Icons.rotate_right_rounded,
                  const Color(0xFFE2F7ED),
                  const Color(0xFF0F9D58),
                ),
                _buildMetricCard(
                  'Rig Constant',
                  'Kappa (κ)',
                  '2-Object Calibration',
                  Icons.tune_rounded,
                  const Color(0xFFFFF3E0),
                  const Color(0xFFE65100),
                ),
                _buildMetricCard(
                  'Sensor Timer',
                  'Zero Hardware',
                  'Gyro & Accel',
                  Icons.sensors_rounded,
                  const Color(0xFFF3E5F5),
                  const Color(0xFF7B1FA2),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Primary Use Cases
        const _OneUISectionTitle(title: 'Primary Use Cases', icon: Icons.center_focus_strong_rounded),
        const SizedBox(height: 12),
        _OneUICard(
          child: Column(
            children: [
              _buildFeatureTile(
                icon: Icons.sports_handball_rounded,
                title: 'Paddle & Racquet Measurement',
                description: 'Measure Swing Weight (SW) and Twist Weight (TW) to accurately assess power, maneuverability, and sweet-spot stability characteristics.',
              ),
              const Divider(height: 24, color: Color(0xFFE5E8EB)),
              _buildFeatureTile(
                icon: Icons.build_circle_rounded,
                title: 'Customization & Weight Tuning',
                description: 'Assist players, customizers, and equipment technicians in strategic lead tape placement to hit exact target MOI specifications.',
              ),
              const Divider(height: 24, color: Color(0xFFE5E8EB)),
              _buildFeatureTile(
                icon: Icons.fact_check_rounded,
                title: 'Quality Control & Batch Testing',
                description: 'Measure and log production samples to assess manufacturing consistency and verify commercial product specifications.',
              ),
              const Divider(height: 24, color: Color(0xFFE5E8EB)),
              _buildFeatureTile(
                icon: Icons.phonelink_setup_rounded,
                title: 'Zero-Hardware Sensor Timing',
                description: 'Turn any smartphone into a high-precision oscillation period timer without requiring external specialized lab hardware.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Key Functionalities & Features
        const _OneUISectionTitle(title: 'Key Functionalities & Features', icon: Icons.stars_rounded),
        const SizedBox(height: 12),
        _OneUICard(
          child: Column(
            children: [
              _buildDetailTile(
                number: '1',
                title: 'High-Precision Oscillation Period Measurement',
                subtitle: 'Utilizes high-frequency gyroscopes and accelerometers via Native APIs, Generic Sensor API, and Safari DeviceMotion interop. Features non-linear sine-wave curve fitting to calculate oscillation period (T) with automated Fit Residual Score exclusion.',
              ),
              const Divider(height: 24, color: Color(0xFFE5E8EB)),
              _buildDetailTile(
                number: '2',
                title: 'Swing Weight (SW) & Twist Weight (TW) Calculation',
                subtitle: 'Converts raw oscillation periods into physical Moment of Inertia values (kg·cm²) based on calibrated rig parameters: SW about the handle grip axis and TW about the longitudinal center axis.',
              ),
              const Divider(height: 24, color: Color(0xFFE5E8EB)),
              _buildDetailTile(
                number: '3',
                title: 'Calibration & Rig Zeroing Workflow',
                subtitle: 'Includes a two-object calibration system using known reference inertia standards (Object A & B) to determine the exact spring constant (κ), alongside Tare Adapter zeroing (Tare PB, TW, SW).',
              ),
              const Divider(height: 24, color: Color(0xFFE5E8EB)),
              _buildDetailTile(
                number: '4',
                title: 'Statistical Filtering & Outlier Management',
                subtitle: 'Applies Low Margin Exclusion (0.3%) for Swing Weight and High Margin Exclusion (1.0%) for Twist Weight, combined with initial/final cycle trimming.',
              ),
              const Divider(height: 24, color: Color(0xFFE5E8EB)),
              _buildDetailTile(
                number: '5',
                title: 'Group Data Management & CSV/JSON Export',
                subtitle: 'Organize measurements into session groups by model or player, calculate aggregate statistics (averages, std dev, min/max), and export full sensor data.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String subtitle,
    String badge,
    IconData icon,
    Color bg,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E8EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Color(0xFF70777F)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile({required IconData icon, required String title, required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF5FE),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: const Color(0xFF0381FE), size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Color(0xFF5F6368), height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailTile({required String number, required String title, required String subtitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF0381FE),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: Color(0xFF5F6368), height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// ANDROID PAGE
// ============================================================================
class AndroidPage extends StatelessWidget {
  const AndroidPage({super.key});

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
        // Primary Highlights Hero Banner
        _OneUICard(
          bgColor: const Color(0xFFEBF3FE),
          borderColor: const Color(0xFFC7DCFC),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0381FE),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.android_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OpenMOI Native Android App',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0381FE),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Direct Hardware Access & Unthrottled Sampling',
                          style: TextStyle(fontSize: 13, color: Color(0xFF334155)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'The Android version of OpenMOI is engineered for maximum precision, accessing device motion sensors directly through native Android APIs to deliver uncompromised measurement stability.',
                style: TextStyle(fontSize: 14, color: Color(0xFF334155), height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 2 Key Advantages Tiles
        Row(
          children: [
            Expanded(
              child: _buildBenefitCard(
                icon: Icons.memory_rounded,
                title: 'Better Hardware Utilization',
                description: 'Direct low-level Android SensorManager access enables unthrottled 100Hz–200Hz sensor polling, minimal latency, and zero browser frame jitter for higher fit scores.',
                badgeColor: const Color(0xFFE0EDFF),
                iconColor: const Color(0xFF0381FE),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildBenefitCard(
                icon: Icons.wifi_off_rounded,
                title: 'No Internet Dependency',
                description: '100% offline functionality. Measure equipment on court, in the workshop, or in the lab without needing Wi-Fi or cellular connections.',
                badgeColor: const Color(0xFFE2F7ED),
                iconColor: const Color(0xFF0F9D58),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Download Action Card
        _OneUICard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Download Application Package',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
              ),
              const SizedBox(height: 6),
              const Text(
                'Download the standalone APK to install OpenMOI directly on your Android phone or tablet.',
                style: TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
              ),
              const SizedBox(height: 16),

              // Prominent One UI Download Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _downloadApk,
                  icon: const Icon(Icons.file_download_rounded, size: 24),
                  label: const Text(
                    'Download OpenMOI.apk (~54 MB)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0381FE),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Installation Guide
        const _OneUISectionTitle(title: 'Installation Instructions', icon: Icons.help_outline_rounded),
        const SizedBox(height: 12),
        _OneUICard(
          child: Column(
            children: [
              _buildStepTile('1', 'Download the APK', 'Tap the Download button above to save OpenMOI.apk to your device downloads.'),
              const Divider(height: 20, color: Color(0xFFE5E8EB)),
              _buildStepTile('2', 'Open Downloaded File', 'Locate OpenMOI.apk in your Downloads folder or notification bar and tap to open.'),
              const Divider(height: 20, color: Color(0xFFE5E8EB)),
              _buildStepTile('3', 'Allow Installation', 'If prompted, enable "Install from Unknown Sources" in Android settings to complete setup.'),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required Color badgeColor,
    required Color iconColor,
  }) {
    return _OneUICard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF5F6368), height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTile(String step, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// ONLINE VERSION PAGE
// ============================================================================
class OnlineVersionPage extends StatelessWidget {
  const OnlineVersionPage({super.key});

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
        // Banner
        _OneUICard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0EDFF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.language_rounded, color: Color(0xFF0381FE), size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OpenMOI Web Application',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF191C1E),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Cross-Platform Universal Web Access',
                          style: TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'The Online Version of OpenMOI allows users on any device—including Android, iOS (iPhones & iPads), laptops, and desktop computers—to quickly run measurements directly inside a modern web browser without downloading or installing any native packages.',
                style: TextStyle(fontSize: 14, color: Color(0xFF42474E), height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Disadvantages & Browser Limitations Section
        const _OneUISectionTitle(title: 'Browser Limitations & Disadvantages', icon: Icons.warning_amber_rounded),
        const SizedBox(height: 12),

        // Warning Tile 1: Internet Dependency
        _OneUICard(
          bgColor: const Color(0xFFFFF8E1),
          borderColor: const Color(0xFFFFE082),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB300),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.wifi_off_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Internet Dependency',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Requires an active web connection to access and load the Progressive Web App files and scripts, unlike the fully offline native Android app.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6D4C41), height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Warning Tile 2: Slower Hardware & iOS Limitations
        _OneUICard(
          bgColor: const Color(0xFFFFEBEE),
          borderColor: const Color(0xFFFFCDD2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.speed_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slower Hardware Utilization & Apple iOS Limitations',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFB71C1C)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Web browser APIs introduce polling execution overhead compared to native code. On Apple iOS devices (Safari), strict motion sensor permission policies and throttled sensor sample rates (30Hz–60Hz) can cause sampling jitter during high-frequency oscillations.',
                      style: TextStyle(fontSize: 13, color: Color(0xFFC62828), height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // CTA Tile
        _OneUICard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Launch Online Tool',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
              ),
              const SizedBox(height: 6),
              const Text(
                'Redirect to the official OpenMOI web app running on GitHub Pages.',
                style: TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
              ),
              const SizedBox(height: 16),

              // Launch Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _launchOnlineTool,
                  icon: const Icon(Icons.open_in_new_rounded, size: 22),
                  label: const Text(
                    'Open Online Web App',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0381FE),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ============================================================================
// ONE UI 9.0 REUSABLE WIDGETS
// ============================================================================
class _OneUICard extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final Color? borderColor;

  const _OneUICard({
    required this.child,
    this.bgColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor ?? const Color(0xFFE5E8EB),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _OneUISectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _OneUISectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF0381FE)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF191C1E),
          ),
        ),
      ],
    );
  }
}
