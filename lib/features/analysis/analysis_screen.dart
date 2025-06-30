import 'package:flutter/material.dart';
import 'package:aiforexam/base_scaffold.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Week';
  String _selectedSubject = 'All Subjects';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 2,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade600, Colors.purple.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.analytics, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      'Performance Analysis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.trending_up, color: Colors.green.shade300, size: 28),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedPeriod,
                          dropdownColor: Colors.purple.shade700,
                          underline: const SizedBox(),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          isExpanded: true,
                          items: ['Today', 'This Week', 'This Month', 'Last 3 Months', 'All Time']
                              .map((period) => DropdownMenuItem(value: period, child: Text(period)))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedPeriod = value!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedSubject,
                          dropdownColor: Colors.purple.shade700,
                          underline: const SizedBox(),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          isExpanded: true,
                          items: ['All Subjects', 'Physics', 'Chemistry', 'Mathematics', 'Biology']
                              .map((subject) => DropdownMenuItem(value: subject, child: Text(subject)))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedSubject = value!),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Overview Cards
          _buildOverviewCards(),

          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.purple,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Overview', icon: Icon(Icons.dashboard, size: 20)),
                Tab(text: 'Subject Wise', icon: Icon(Icons.subject, size: 20)),
                Tab(text: 'Test History', icon: Icon(Icons.history, size: 20)),
                Tab(text: 'Insights', icon: Icon(Icons.lightbulb, size: 20)),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildSubjectWiseTab(),
                _buildTestHistoryTab(),
                _buildInsightsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: _buildOverviewCard('Tests Taken', '47', Icons.quiz, Colors.blue)),
          const SizedBox(width: 12),
          Expanded(child: _buildOverviewCard('Avg Score', '78%', Icons.grade, Colors.green)),
          const SizedBox(width: 12),
          Expanded(child: _buildOverviewCard('Study Time', '12h', Icons.schedule, Colors.orange)),
          const SizedBox(width: 12),
          Expanded(child: _buildOverviewCard('Rank', '#234', Icons.leaderboard, Colors.red)),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceTrendChart(),
          const SizedBox(height: 20),
          _buildAccuracyBreakdown(),
          const SizedBox(height: 20),
          _buildTimeAnalysis(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTrendChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Trend',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: CustomPaint(
                painter: LineChartPainter(),
                size: const Size(double.infinity, 200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccuracyBreakdown() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accuracy Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAccuracyItem('Correct Answers', 78, Colors.green),
            _buildAccuracyItem('Wrong Answers', 15, Colors.red),
            _buildAccuracyItem('Unattempted', 7, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAccuracyItem(String label, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(width: 8),
          Text('$percentage%', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildTimeAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTimeStatCard('Avg Time/Question', '1.8 min', Icons.timer, Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTimeStatCard('Fastest Answer', '0.3 min', Icons.speed, Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTimeStatCard('Slowest Answer', '4.2 min', Icons.slow_motion_video, Colors.orange),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTimeStatCard('Time Saved', '12 min', Icons.save_alt, Colors.purple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectWiseTab() {
    final subjects = [
      SubjectAnalysis('Physics', 82, 45, Colors.blue),
      SubjectAnalysis('Chemistry', 75, 38, Colors.green),
      SubjectAnalysis('Mathematics', 88, 52, Colors.red),
      SubjectAnalysis('Biology', 71, 32, Colors.teal),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: subject.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.subject, color: subject.color),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      subject.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '${subject.accuracy}%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: subject.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: subject.accuracy / 100,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(subject.color),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildSubjectStat('Questions Solved', '${subject.questionsSolved}'),
                    const Spacer(),
                    _buildSubjectStat('Weak Areas', _getWeakAreas(subject.name)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubjectStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  String _getWeakAreas(String subject) {
    final weakAreas = {
      'Physics': 'Optics, Waves',
      'Chemistry': 'Organic Chemistry',
      'Mathematics': 'Calculus',
      'Biology': 'Genetics',
    };
    return weakAreas[subject] ?? 'None';
  }

  Widget _buildTestHistoryTab() {
    final testHistory = [
      TestHistory('Full Length Mock Test #3', DateTime.now().subtract(const Duration(days: 1)), 85, 'Good'),
      TestHistory('Physics Chapter Test', DateTime.now().subtract(const Duration(days: 3)), 78, 'Average'),
      TestHistory('Chemistry Quick Test', DateTime.now().subtract(const Duration(days: 5)), 92, 'Excellent'),
      TestHistory('Mathematics Practice', DateTime.now().subtract(const Duration(days: 7)), 69, 'Needs Improvement'),
      TestHistory('Biology Mock Test', DateTime.now().subtract(const Duration(days: 10)), 88, 'Good'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: testHistory.length,
      itemBuilder: (context, index) {
        final test = testHistory[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getPerformanceColor(test.performance).withOpacity(0.2),
              child: Text(
                '${test.score}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getPerformanceColor(test.performance),
                ),
              ),
            ),
            title: Text(test.testName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(_formatDate(test.date)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getPerformanceColor(test.performance).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                test.performance,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _getPerformanceColor(test.performance),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInsightCard(
            'Strengths',
            'You excel in Mathematics and show consistent improvement in problem-solving speed.',
            Icons.trending_up,
            Colors.green,
          ),
          _buildInsightCard(
            'Areas to Improve',
            'Focus more on Physics concepts, especially Optics and Wave mechanics.',
            Icons.warning,
            Colors.orange,
          ),
          _buildInsightCard(
            'Study Recommendation',
            'Increase daily practice time by 30 minutes and focus on weak topics.',
            Icons.school,
            Colors.blue,
          ),
          _buildInsightCard(
            'Goal Progress',
            'You are 78% towards your target score. Keep up the good work!',
            Icons.flag,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPerformanceColor(String performance) {
    switch (performance) {
      case 'Excellent':
        return Colors.green;
      case 'Good':
        return Colors.blue;
      case 'Average':
        return Colors.orange;
      case 'Needs Improvement':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

// Data Models
class SubjectAnalysis {
  final String name;
  final int accuracy;
  final int questionsSolved;
  final Color color;

  SubjectAnalysis(this.name, this.accuracy, this.questionsSolved, this.color);
}

class TestHistory {
  final String testName;
  final DateTime date;
  final int score;
  final String performance;

  TestHistory(this.testName, this.date, this.score, this.performance);
}

// Custom Chart Painter
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.1),
    ];

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw points
    final pointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}