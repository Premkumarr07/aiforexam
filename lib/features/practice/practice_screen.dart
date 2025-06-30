import 'package:flutter/material.dart';
import 'package:aiforexam/base_scaffold.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedExam = 'JEE Main';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 1,
      body: Column(
        children: [
          // Header with exam selection
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.quiz, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      'Practice Arena',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.emoji_events, color: Colors.amber.shade300, size: 28),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedExam,
                    dropdownColor: Colors.blue.shade700,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    items: _examTypes.map((exam) {
                      return DropdownMenuItem(
                        value: exam,
                        child: Text(exam),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedExam = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Test Series', icon: Icon(Icons.assignment)),
                Tab(text: 'Practice Papers', icon: Icon(Icons.description)),
                Tab(text: 'Quick MCQs', icon: Icon(Icons.quiz)),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTestSeriesTab(),
                _buildPracticePapersTab(),
                _buildQuickMCQsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestSeriesTab() {
    final testSeries = _getTestSeriesForExam(_selectedExam);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: testSeries.length,
      itemBuilder: (context, index) {
        final test = testSeries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          child: InkWell(
            onTap: () => _startTest(test),
            borderRadius: BorderRadius.circular(8),
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
                          color: test.difficulty == 'Easy'
                              ? Colors.green.withOpacity(0.2)
                              : test.difficulty == 'Medium'
                              ? Colors.orange.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.assessment,
                          color: test.difficulty == 'Easy'
                              ? Colors.green
                              : test.difficulty == 'Medium'
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              test.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              test.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip(Icons.quiz, '${test.questions} Questions'),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.timer, '${test.duration} min'),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.star, test.difficulty),
                    ],
                  ),
                  if (test.isAttempted) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Last Score: ${test.lastScore}%',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPracticePapersTab() {
    final papers = _getPracticePapersForExam(_selectedExam);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: papers.length,
      itemBuilder: (context, index) {
        final paper = papers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          child: InkWell(
            onTap: () => _startPracticePaper(paper),
            borderRadius: BorderRadius.circular(8),
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
                          color: Colors.purple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.description, color: Colors.purple),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              paper.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              paper.year,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip(Icons.quiz, '${paper.questions} Questions'),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.timer, '${paper.duration} min'),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.score, '${paper.maxMarks} Marks'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickMCQsTab() {
    final subjects = _getSubjectsForExam(_selectedExam);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Card(
          elevation: 3,
          child: InkWell(
            onTap: () => _startQuickMCQ(subject),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: subject.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      subject.icon,
                      color: subject.color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    subject.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${subject.questionCount} Questions',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _startTest(TestSeries test) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestScreen(
          testSeries: test,
          examType: _selectedExam,
        ),
      ),
    );
  }

  void _startPracticePaper(PracticePaper paper) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PracticeTestScreen(
          practicePaper: paper,
          examType: _selectedExam,
        ),
      ),
    );
  }

  void _startQuickMCQ(Subject subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuickMCQScreen(
          subject: subject,
          examType: _selectedExam,
        ),
      ),
    );
  }

  // Data methods
  List<String> get _examTypes => [
    'JEE Main', 'JEE Advanced', 'NEET', 'BITSAT', 'COMEDK',
    'MHT CET', 'KCET', 'WBJEE', 'KEAM', 'EAMCET',
    'CBSE Class 12', 'CBSE Class 11', 'CBSE Class 10'
  ];

  List<TestSeries> _getTestSeriesForExam(String exam) {
    // Sample data - replace with actual data source
    return [
      TestSeries(
        title: 'Full Length Mock Test #1',
        description: 'Complete syllabus coverage with latest pattern',
        questions: 90,
        duration: 180,
        difficulty: 'Medium',
        isAttempted: true,
        lastScore: 85,
      ),
      TestSeries(
        title: 'Chapter-wise Test: Physics',
        description: 'Mechanics and Thermodynamics',
        questions: 30,
        duration: 60,
        difficulty: 'Hard',
        isAttempted: false,
        lastScore: 0,
      ),
      TestSeries(
        title: 'Quick Revision Test',
        description: 'Important topics and formulas',
        questions: 50,
        duration: 90,
        difficulty: 'Easy',
        isAttempted: true,
        lastScore: 92,
      ),
    ];
  }

  List<PracticePaper> _getPracticePapersForExam(String exam) {
    return [
      PracticePaper(
        title: '$exam Previous Year Paper',
        year: '2023',
        questions: 90,
        duration: 180,
        maxMarks: 300,
      ),
      PracticePaper(
        title: '$exam Previous Year Paper',
        year: '2022',
        questions: 90,
        duration: 180,
        maxMarks: 300,
      ),
      PracticePaper(
        title: '$exam Sample Paper',
        year: '2024',
        questions: 90,
        duration: 180,
        maxMarks: 300,
      ),
    ];
  }

  List<Subject> _getSubjectsForExam(String exam) {
    if (exam.contains('JEE') || exam.contains('BITSAT')) {
      return [
        Subject('Physics', Icons.science, Colors.blue, 500),
        Subject('Chemistry', Icons.biotech, Colors.green, 450),
        Subject('Mathematics', Icons.calculate, Colors.red, 400),
      ];
    } else if (exam.contains('NEET')) {
      return [
        Subject('Physics', Icons.science, Colors.blue, 350),
        Subject('Chemistry', Icons.biotech, Colors.green, 400),
        Subject('Biology', Icons.eco, Colors.teal, 500),
      ];
    } else {
      return [
        Subject('Physics', Icons.science, Colors.blue, 300),
        Subject('Chemistry', Icons.biotech, Colors.green, 300),
        Subject('Mathematics', Icons.calculate, Colors.red, 300),
        Subject('Biology', Icons.eco, Colors.teal, 300),
      ];
    }
  }
}

// Data Models
class TestSeries {
  final String title;
  final String description;
  final int questions;
  final int duration;
  final String difficulty;
  final bool isAttempted;
  final int lastScore;

  TestSeries({
    required this.title,
    required this.description,
    required this.questions,
    required this.duration,
    required this.difficulty,
    required this.isAttempted,
    required this.lastScore,
  });
}

class PracticePaper {
  final String title;
  final String year;
  final int questions;
  final int duration;
  final int maxMarks;

  PracticePaper({
    required this.title,
    required this.year,
    required this.questions,
    required this.duration,
    required this.maxMarks,
  });
}

class Subject {
  final String name;
  final IconData icon;
  final Color color;
  final int questionCount;

  Subject(this.name, this.icon, this.color, this.questionCount);
}

// Test Screens (You'll need to implement these)
class TestScreen extends StatelessWidget {
  final TestSeries testSeries;
  final String examType;

  const TestScreen({
    super.key,
    required this.testSeries,
    required this.examType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(testSeries.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Test Screen - Implement MCQ interface here'),
      ),
    );
  }
}

class PracticeTestScreen extends StatelessWidget {
  final PracticePaper practicePaper;
  final String examType;

  const PracticeTestScreen({
    super.key,
    required this.practicePaper,
    required this.examType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(practicePaper.title),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Practice Test Screen - Implement here'),
      ),
    );
  }
}

class QuickMCQScreen extends StatelessWidget {
  final Subject subject;
  final String examType;

  const QuickMCQScreen({
    super.key,
    required this.subject,
    required this.examType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${subject.name} MCQs'),
        backgroundColor: subject.color,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Quick MCQ Screen - Implement here'),
      ),
    );
  }
}