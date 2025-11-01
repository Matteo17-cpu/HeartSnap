import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _healthReminders = true;
  bool _checkupReminders = true;
  bool _resultsNotifications = true;
  bool _promotions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D120B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pengaturan Notifikasi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // General Notifications Section
              _buildSectionTitle("Notifikasi Umum"),
              const SizedBox(height: 12),

              _buildNotificationTile(
                icon: Icons.notifications_active_rounded,
                title: "Push Notifications",
                subtitle: "Terima notifikasi di perangkat",
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() => _pushNotifications = value);
                },
              ),

              const SizedBox(height: 10),

              _buildNotificationTile(
                icon: Icons.email_rounded,
                title: "Email Notifications",
                subtitle: "Terima notifikasi via email",
                value: _emailNotifications,
                onChanged: (value) {
                  setState(() => _emailNotifications = value);
                },
              ),

              const SizedBox(height: 24),

              // Health Notifications Section
              _buildSectionTitle("Notifikasi Kesehatan"),
              const SizedBox(height: 12),

              _buildNotificationTile(
                icon: Icons.favorite_rounded,
                title: "Pengingat Kesehatan",
                subtitle: "Tips kesehatan harian",
                value: _healthReminders,
                onChanged: (value) {
                  setState(() => _healthReminders = value);
                },
              ),

              const SizedBox(height: 10),

              _buildNotificationTile(
                icon: Icons.calendar_today_rounded,
                title: "Pengingat Pemeriksaan",
                subtitle: "Ingatkan waktu pemeriksaan rutin",
                value: _checkupReminders,
                onChanged: (value) {
                  setState(() => _checkupReminders = value);
                },
              ),

              const SizedBox(height: 10),

              _buildNotificationTile(
                icon: Icons.assessment_rounded,
                title: "Hasil Pemeriksaan",
                subtitle: "Notifikasi hasil tersedia",
                value: _resultsNotifications,
                onChanged: (value) {
                  setState(() => _resultsNotifications = value);
                },
              ),

              const SizedBox(height: 24),

              // Marketing Section
              _buildSectionTitle("Lainnya"),
              const SizedBox(height: 12),

              _buildNotificationTile(
                icon: Icons.local_offer_rounded,
                title: "Promosi & Penawaran",
                subtitle: "Info promo dan diskon",
                value: _promotions,
                onChanged: (value) {
                  setState(() => _promotions = value);
                },
              ),

              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D120B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Simpan Pengaturan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF6D120B),
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6D120B).withOpacity(0.1),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF6D120B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6D120B),
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
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF333333),
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
            // Switch
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF6D120B),
              activeTrackColor: const Color(0xFF6D120B).withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSettings() {
    // Save settings to local storage or backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text(
              "Pengaturan berhasil disimpan",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    Navigator.pop(context);
  }
}