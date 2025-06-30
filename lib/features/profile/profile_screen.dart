import 'dart:io';

import 'package:flutter/material.dart';
import 'package:aiforexam/base_scaffold.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
      // TODO: Upload to server
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 4,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header Section
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // Account Settings
            _buildSectionTitle("Account Settings"),
            _buildAccountSettings(),
            const SizedBox(height: 24),

            // Study Features
            _buildSectionTitle("Study Features"),
            _buildStudyFeatures(),
            const SizedBox(height: 24),

            // Subscription
            _buildSectionTitle("Subscription"),
            _buildSubscriptionCard(),
            const SizedBox(height: 24),

            // App Settings
            _buildSectionTitle("App Settings"),
            _buildAppSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _profileImage != null
                  ? FileImage(File(_profileImage!.path))
                  : const AssetImage('assets/default_avatar.png') as ImageProvider,
              child: _profileImage == null
                  ? const Icon(Icons.person, size: 50, color: Colors.white)
                  : null,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                onPressed: _pickImage,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Rahul Sharma",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          "UPSC Aspirant • New Delhi",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            const Text(
              "4.8 Rating",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.verified, color: Colors.blue, size: 16),
            const SizedBox(width: 4),
            const Text(
              "Verified",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: const Text("View All"),
        ),
      ],
    );
  }

  Widget _buildAccountSettings() {
    return Card(
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.person_outline,
            title: "Edit Profile",
            onTap: () => _navigateToEditProfile(),
          ),
          _buildListTile(
            icon: Icons.school_outlined,
            title: "My Exams",
            subtitle: "UPSC, SSC",
            onTap: () => _navigateToMyExams(),
          ),
          _buildListTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () => _navigateToChangePassword(),
          ),
          _buildListTile(
            icon: Icons.notifications_outlined,
            title: "Notification Settings",
            onTap: () => _navigateToNotificationSettings(),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyFeatures() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        _buildFeatureCard(
          icon: Icons.note_alt_outlined,
          title: "My Notes",
          count: "128",
          color: Colors.blue,
          onTap: () => _navigateToNotes(),
        ),
        _buildFeatureCard(
          icon: Icons.article_outlined,
          title: "Current Affairs",
          count: "Daily",
          color: Colors.green,
          onTap: () => _navigateToCurrentAffairs(),
        ),
        _buildFeatureCard(
          icon: Icons.assignment_outlined,
          title: "Test Series",
          count: "12 Active",
          color: Colors.orange,
          onTap: () => _navigateToTestSeries(),
        ),
        _buildFeatureCard(
          icon: Icons.bookmark_outline,
          title: "Bookmarks",
          count: "56",
          color: Colors.purple,
          onTap: () => _navigateToBookmarks(),
        ),
      ],
    );
  }

  Widget _buildSubscriptionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.indigo.shade700],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stars, color: Colors.amber, size: 28),
              const SizedBox(width: 12),
              const Text(
                "Pro Version",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "FREE TRIAL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Unlock all premium features for better preparation:",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              _buildProFeature("Unlimited Test Series"),
              _buildProFeature("Advanced Analytics"),
              _buildProFeature("Personalized AI Mentor"),
              _buildProFeature("Priority Support"),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade800,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _navigateToSubscription(),
              child: const Text(
                "Upgrade Now - ₹499/month",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Card(
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.language_outlined,
            title: "Language",
            subtitle: "English",
            onTap: () => _changeLanguage(),
          ),
          _buildListTile(
            icon: Icons.dark_mode_outlined,
            title: "Dark Mode",
            trailing: Switch(value: false, onChanged: (v) {}), onTap: () {  },
          ),
          _buildListTile(
            icon: Icons.storage_outlined,
            title: "Storage",
            subtitle: "1.2 GB used",
            onTap: () => _manageStorage(),
          ),
          _buildListTile(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () => _navigateToHelp(),
          ),
          _buildListTile(
            icon: Icons.logout_outlined,
            title: "Logout",
            color: Colors.red,
            onTap: () => _logout(),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blue),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String count,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Text(
            feature,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Navigation Methods
  void _navigateToEditProfile() {
    // Navigate to edit profile
  }

  void _navigateToMyExams() {
    // Navigate to my exams
  }

  void _navigateToChangePassword() {
    // Navigate to change password
  }

  void _navigateToNotificationSettings() {
    // Navigate to notification settings
  }

  void _navigateToNotes() {
    // Navigate to notes
  }

  void _navigateToCurrentAffairs() {
    // Navigate to current affairs
  }

  void _navigateToTestSeries() {
    // Navigate to test series
  }

  void _navigateToBookmarks() {
    // Navigate to bookmarks
  }

  void _navigateToSubscription() {
    // Navigate to subscription
  }

  void _changeLanguage() {
    // Change language
  }

  void _manageStorage() {
    // Manage storage
  }

  void _navigateToHelp() {
    // Navigate to help
  }

  void _logout() {
    // Logout
  }
}