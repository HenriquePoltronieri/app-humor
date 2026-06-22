import 'package:flutter/material.dart';

void main() {
  runApp(const MoodApp());
}

class MoodApp extends StatelessWidget {
  const MoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MoodHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MoodData {
  final String name;
  final Color color;
  final IconData icon;
  final String message;
  final String emoji;

  MoodData({
    required this.name,
    required this.color,
    required this.icon,
    required this.message,
    required this.emoji,
  });
}

class MoodHomePage extends StatefulWidget {
  const MoodHomePage({super.key});

  @override
  State<MoodHomePage> createState() => _MoodHomePageState();
}

class _MoodHomePageState extends State<MoodHomePage> {
  String selectedMood = 'Feliz';
  bool showMessage = false;

  final Map<String, MoodData> moods = {
    'Feliz': MoodData(
      name: 'Feliz',
      color: const Color(0xFFFFD700),
      icon: Icons.sentiment_very_satisfied,
      message: 'Que bom ver essa energia positiva!',
      emoji: '',
    ),
    'Triste': MoodData(
      name: 'Triste',
      color: const Color(0xFF4A90E2),
      icon: Icons.sentiment_very_dissatisfied,
      message: 'Tudo vai ficar bem, voce consegue!',
      emoji: '',
    ),
    'Animado': MoodData(
      name: 'Animado',
      color: const Color(0xFFFF8C00),
      icon: Icons.bolt,
      message: 'Que energia incrivel! Continue assim!',
      emoji: '',
    ),
    'Calmo': MoodData(
      name: 'Calmo',
      color: const Color(0xFF87CEEB),
      icon: Icons.cloud,
      message: 'Momento perfeito pra relaxar...',
      emoji: '',
    ),
    'Bravo': MoodData(
      name: 'Bravo',
      color: const Color(0xFFDC143C),
      icon: Icons.whatshot,
      message: 'Faça algo que te relaxe!',
      emoji: '',
    ),
  };

  void changeMood(String mood) {
    setState(() {
      selectedMood = mood;
      showMessage = false;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        showMessage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMood = moods[selectedMood]!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF5F5F5),
                Color(0xFFE0E0E0),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      SizedBox(height: 20),
                      Text(
                        '🎭 Mood App',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Como você está se sentindo hoje?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: currentMood.color,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: currentMood.color.withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          currentMood.icon,
                          size: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 20),

                        Text(
                          currentMood.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          currentMood.emoji,
                          style: const TextStyle(fontSize: 60),
                        ),
                      ],
                    ),
                  ),

                  AnimatedOpacity(
                    opacity: showMessage ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: currentMood.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: currentMood.color.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Color(0xFFE91E63),
                            size: 24,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentMood.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: currentMood.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Escolha um humor:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: moods.keys.map((mood) {
                          final isSelected = selectedMood == mood;
                          return AnimatedScale(
                            scale: isSelected ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: ElevatedButton(
                              onPressed: () => changeMood(mood),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: moods[mood]!.color,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                elevation: isSelected ? 8 : 2,
                                shadowColor: moods[mood]!.color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: isSelected
                                      ? const BorderSide(
                                          color: Colors.white,
                                          width: 3,
                                        )
                                      : BorderSide.none,
                                ),
                              ),
                              child: Text(
                                mood,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
