import 'package:flutter/material.dart';
import 'package:aiforexam/base_scaffold.dart';
import 'package:aiforexam/core/widgets/custom_app_bar.dart'; // your custom app bar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int _notificationCount = 5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSearchBottomSheet(),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildNotificationBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0, // Home index
      appBar: CustomAppBar(
        notificationCount: _notificationCount,
        onMenuPressed: () {
          // Handle drawer
        },
        onSearchPressed: _showSearchBottomSheet,
        onNotificationPressed: _showNotifications,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Colors.white,
              Color(0xFFFFF3E0),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEnhancedBanner(),
                    const SizedBox(height: 20),
                    _buildMotivationalHeader(),
                    const SizedBox(height: 20),
                    _buildSmartExamCountdown(),
                    const SizedBox(height: 20),
                    _buildLivePerformanceDashboard(),
                    const SizedBox(height: 24),
                    _buildGovernmentExamCategories(),
                    const SizedBox(height: 24),
                    _buildAIStudyAssistant(),
                    const SizedBox(height: 24),
                    _buildSmartDailyPractice(),
                    const SizedBox(height: 20),
                    _buildSuccessStories(),
                    const SizedBox(height: 20),
                    _buildQuickActions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1976D2),
              Color(0xFF303F9F),
            ],
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Handle menu action
            },
          ),
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AI For Exam",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Your Success Partner 🎯",
            style: TextStyle(
              color: Color(0xE6FFFFFF),
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        // Search Icon
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _showSearchBottomSheet,
          ),
        ),

        // Notification Icon with Badge
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(
                    Icons.notifications_outlined, color: Colors.white),
                onPressed: _showNotifications,
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD32F2F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      _notificationCount > 99 ? '99+' : _notificationCount
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7B1FA2),
            Color(0xFFE91E63),
            Color(0xFFFF9800),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x4D7B1FA2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0x1AFFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0x1AFFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0x4DFFFFFF)),
                        ),
                        child: const Text(
                          "🚀 SPECIAL OFFER",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Get 50% OFF on\nPremium Courses!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Limited time offer ends in 2 days",
                        style: TextStyle(
                          color: Color(0xE6FFFFFF),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF7B1FA2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Claim Now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBottomSheet() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Search header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Search Courses",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search for UPSC, SSC, Banking...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF1976D2)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Popular searches
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Popular Searches",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _searchChip("UPSC Prelims", Icons.book),
                      _searchChip("SSC CGL", Icons.assignment),
                      _searchChip("Banking PO", Icons.account_balance),
                      _searchChip("Railway NTPC", Icons.train),
                      _searchChip("Current Affairs", Icons.newspaper),
                      _searchChip("Mock Tests", Icons.quiz),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Recent Searches",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _recentSearchItem("Ancient History", "2 hours ago"),
                  _recentSearchItem("Polity Questions", "Yesterday"),
                  _recentSearchItem("Geography Notes", "3 days ago"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchChip(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        // Handle search selection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFBBDEFB)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF1976D2)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentSearchItem(String search, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.history, color: Color(0xFF757575)),
      title: Text(search),
      subtitle: Text(
          time, style: const TextStyle(color: Color(0xFF757575), fontSize: 12)),
      trailing: const Icon(Icons.arrow_outward, color: Color(0xFFBDBDBD)),
      onTap: () {
        Navigator.pop(context);
        // Handle recent search selection
      },
    );
  }

  Widget _buildNotificationBottomSheet() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.7,
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _notificationCount = 0;
                    });
                  },
                  child: const Text("Mark all read"),
                ),
              ],
            ),
          ),

          // Notifications list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _notificationItem(
                  "🎉 Congratulations!",
                  "You've completed 10 days study streak!",
                  "2 hours ago",
                  true,
                ),
                _notificationItem(
                  "📚 New Mock Test Available",
                  "UPSC Prelims Mock Test 15 is now live",
                  "5 hours ago",
                  true,
                ),
                _notificationItem(
                  "⚡ Speed Challenge",
                  "Beat your previous record in today's quiz",
                  "1 day ago",
                  false,
                ),
                _notificationItem(
                  "🏆 Rank Update",
                  "You've moved up 15 positions in leaderboard",
                  "2 days ago",
                  false,
                ),
                _notificationItem(
                  "📖 Study Reminder",
                  "Don't forget your daily practice session",
                  "3 days ago",
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationItem(String title, String subtitle, String time,
      bool isUnread) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFE3F2FD) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnread ? const Color(0xFFBBDEFB) : const Color(0xFFE0E0E0),
        ),
      ),
      child: Row(
        children: [
          if (isUnread)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF1976D2),
                shape: BoxShape.circle,
              ),
            ),
          if (isUnread) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationalHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFFF9800), Color(0xFF4CAF50), Color(0xFF2196F3)],
            stops: [0.0, 0.5, 1.0]
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x4DFF9800),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("🇮🇳", style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        "सपने वो नहीं जो आप सोते समय देखते हैं\nसपने वो हैं जो आपको सोने नहीं देते! 💪",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.3,
                        )
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "UPSC Prelims • 72 days to go",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0x4DFFFFFF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.68,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x80FFFFFF),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "68% preparation complete • You're ahead of 78% aspirants! 🎯",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartExamCountdown() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3F51B5), Color(0xFF9C27B0)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x4D3F51B5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                    Icons.psychology, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "AI Study Planner",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)
                    ),
                    Text(
                        "Personalized for UPSC success",
                        style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 14)
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF66BB6A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "AI ACTIVE",
                  style: TextStyle(color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _countdownCard("72", "Days Left"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _countdownCard("1,847", "Questions\nPracticed"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _countdownCard("78%", "Success\nProbability"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "🤖 AI suggests: Focus on Current Affairs today",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _countdownCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x26FFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x4DFFFFFF)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xE6FFFFFF),
              fontSize: 10,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLivePerformanceDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.analytics, color: Colors.blue, size: 24),
            const SizedBox(width: 8),
            const Text(
              "Live Performance Analytics",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.trending_up, color: Color(0xFF388E3C), size: 12),
                  SizedBox(width: 4),
                  Text("Improving",
                      style: TextStyle(color: Color(0xFF388E3C), fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            _performanceCard(
                Icons.speed,
                "Accuracy Rate",
                "84.2%",
                "+6.5% this week",
                Colors.green,
                "🎯"
            ),
            _performanceCard(
                Icons.timer,
                "Avg Speed",
                "35 sec",
                "Target: 30 sec",
                Colors.orange,
                "⚡"
            ),
            _performanceCard(
                Icons.emoji_events,
                "Rank Position",
                "#342",
                "↑48 positions",
                Colors.purple,
                "🏆"
            ),
            _performanceCard(
                Icons.local_fire_department,
                "Study Streak",
                "12 Days",
                "Personal best!",
                Colors.red,
                "🔥"
            ),
          ],
        ),
      ],
    );
  }

  Widget _performanceCard(IconData icon, String title, String value,
      String subtitle, Color color, String emoji) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Icon(icon, size: 18, color: color),
            ],
          ),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildGovernmentExamCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🏛️ Government Exams",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _examCategoryCard(
                  "UPSC", "Union Public Service Commission", "📚", true,
                  Colors.blue),
              _examCategoryCard(
                  "SSC", "Staff Selection Commission", "✍️", false,
                  Colors.green),
              _examCategoryCard(
                  "Banking", "IBPS, SBI, RBI", "🏦", false, Colors.purple),
              _examCategoryCard(
                  "Railway", "RRB NTPC, Group D", "🚂", false, Colors.orange),
              _examCategoryCard(
                  "Defense", "NDA, CDS, AFCAT", "⚔️", false, Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _examCategoryCard(String title, String subtitle, String emoji,
      bool active, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: active
            ? LinearGradient(colors: [color, color.withOpacity(0.7)])
            : LinearGradient(colors: [
          Colors.grey.shade100,
          Colors.grey.shade50
        ]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: active ? [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const Spacer(),
              if (active)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: active ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: active ? Colors.white.withOpacity(0.9) : Colors.grey
                  .shade600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIStudyAssistant() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade400, Colors.cyan.shade300],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("🤖", style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "AI Study Assistant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "24/7 Available",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _aiFeatureCard(Icons.auto_awesome, "Smart Analysis",
                  "Personalized insights"),
              _aiFeatureCard(
                  Icons.chat_bubble, "Doubt Solver", "Instant solutions"),
              _aiFeatureCard(
                  Icons.trending_up, "Weak Areas", "AI-detected gaps"),
              _aiFeatureCard(Icons.lightbulb, "Study Tips", "Expert guidance"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aiFeatureCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 8),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartDailyPractice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.amber.shade400],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("🏆", style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Today's Smart Challenge",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "25 Questions",
                  style: TextStyle(color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📖 Focus Area: Ancient Indian History",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Mauryan Empire • Gupta Period • Art & Culture",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "12",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "Day Streak 🔥",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "#342",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "All India Rank",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow),
                  SizedBox(width: 8),
                  Text("Start Challenge",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "💪 Success Stories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          height: 120,
          child: PageView(
            children: [
              _successStoryCard(
                "Priya Sharma cleared UPSC in 2nd attempt",
                "Used AI doubt solver daily • Improved from 45% to 87% accuracy",
                "assets/success1.jpg",
                Colors.blue,
              ),
              _successStoryCard(
                "Rahul Kumar cracked SSC CGL",
                "AI study plan helped focus on weak areas • Scored 98.2%",
                "assets/success2.jpg",
                Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _successStoryCard(String title, String subtitle, String imagePath,
      Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.quiz),
            label: const Text("Quick Test"),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue.shade600,
              side: BorderSide(color: Colors.blue.shade600),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.chat),
            label: const Text("Ask AI"),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
