import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heartsnap/view/login/login_view.dart';
import 'package:heartsnap/view/profile/profile_detail_page.dart';
import 'package:heartsnap/view/profile/history_page.dart';
import 'package:heartsnap/view/profile/notification_settings_page.dart';
import 'package:heartsnap/view/profile/language_settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;
  bool isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<void> logout() async {
    // Konfirmasi logout dengan styling yang lebih menarik
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: const Color(0xFFFFF8F0),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE91A18).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: Color(0xFFE91A18),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Konfirmasi Logout",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6D120B),
              ),
            ),
          ],
        ),
        content: const Text(
          "Apakah Anda yakin ingin keluar dari akun?",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF666666),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              "Batal",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE91A18),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isLoggingOut = true);

    try {
      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                "Logout berhasil",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 1),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logout gagal: $e"),
          backgroundColor: const Color(0xFFE91A18),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
        ),
      );

      setState(() => isLoggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0), // Cream background
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Header dengan Avatar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6D120B), Color(0xFF8B1A10)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6D120B).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFF8F0),
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          currentUser?.displayName?.substring(0, 1).toUpperCase() ?? "U",
                          style: const TextStyle(
                            color: Color(0xFF6D120B),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser?.displayName ?? "User",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentUser?.email ?? "email@example.com",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Verification Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: currentUser?.emailVerified == true
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFFF9800),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  currentUser?.emailVerified == true
                                      ? Icons.verified
                                      : Icons.warning_amber_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  currentUser?.emailVerified == true
                                      ? "Verified"
                                      : "Unverified",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Pengaturan Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pengaturan",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6D120B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildMenuItem(
                      icon: Icons.person_rounded,
                      title: "Profile",
                      subtitle: "Edit informasi pribadi",
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileDetailPage(),
                          ),
                        );
                        // Refresh data if profile was updated
                        if (result == true) {
                          setState(() {
                            currentUser = FirebaseAuth.instance.currentUser;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),

                    _buildMenuItem(
                      icon: Icons.history_rounded,
                      title: "Riwayat",
                      subtitle: "Lihat riwayat kesehatan",
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryPage(),
                          ),
                        );
                        // Refresh profile after returning from history
                        setState(() {
                          currentUser = FirebaseAuth.instance.currentUser;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    _buildMenuItem(
                      icon: Icons.notifications_rounded,
                      title: "Notifikasi",
                      subtitle: "Atur notifikasi aplikasi",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationSettingsPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    _buildMenuItem(
                      icon: Icons.language_rounded,
                      title: "Bahasa",
                      subtitle: "Pilih bahasa aplikasi",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguageSettingsPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Logout Button
                    _buildMenuItem(
                      icon: Icons.logout_rounded,
                      title: isLoggingOut ? "Logging out..." : "Logout",
                      subtitle: "Keluar dari akun",
                      onTap: isLoggingOut ? null : logout,
                      isLogout: true,
                    ),

                    const SizedBox(height: 24),

                    // Lainnya Section
                    const Text(
                      "Lainnya",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6D120B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildMenuItem(
                      icon: Icons.star_rounded,
                      title: "Beri Rating",
                      subtitle: "Beri nilai aplikasi kami",
                      onTap: () {
                        // Navigate to rating
                      },
                    ),
                    const SizedBox(height: 10),

                    _buildMenuItem(
                      icon: Icons.privacy_tip_rounded,
                      title: "Kebijakan Privasi",
                      subtitle: "Baca kebijakan privasi",
                      onTap: () {
                        // Navigate to privacy policy
                      },
                    ),
                    const SizedBox(height: 10),

                    _buildMenuItem(
                      icon: Icons.info_rounded,
                      title: "Version 1.0.0",
                      subtitle: "Informasi aplikasi",
                      onTap: null, // Not clickable
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isLogout
                ? const Color(0xFFE91A18).withOpacity(0.3)
                : const Color(0xFF6D120B).withOpacity(0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isLogout
                    ? const Color(0xFFE91A18).withOpacity(0.1)
                    : const Color(0xFF6D120B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isLoggingOut && isLogout
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFE91A18),
                          ),
                        ),
                      ),
                    )
                  : Icon(
                      icon,
                      color: isLogout
                          ? const Color(0xFFE91A18)
                          : const Color(0xFF6D120B),
                      size: 24,
                    ),
            ),
            const SizedBox(width: 14),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: isLogout && isLoggingOut
                          ? Colors.grey
                          : const Color(0xFF333333),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow Icon
            if (onTap != null && !isLoggingOut)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }
}