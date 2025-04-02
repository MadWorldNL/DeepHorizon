import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Horizon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Deep Horizon',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              _buildMenuButton(
                context,
                'Start Game',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                ),
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Settings',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                ),
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Credits',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreditsScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.blue.withOpacity(0.7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'Settings Screen',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Deep Horizon',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Created by',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Oscar Veldman',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Repository',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // You can add URL launcher functionality here if needed
                },
                child: const Text(
                  'github.com/MadWorldNL/DeepHorizon',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Built with Flutter',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer? _gameTimer;
  int _score = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _isPlaying = true;
    });

    _gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _score++;
      });
    });
  }

  void _pauseGame() {
    setState(() {
      _isPlaying = false;
    });
    _gameTimer?.cancel();
  }

  void _resumeGame() {
    setState(() {
      _isPlaying = true;
    });
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: $_score',
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (_isPlaying)
                ElevatedButton(
                  onPressed: _pauseGame,
                  child: const Text('Pause'),
                )
              else
                ElevatedButton(
                  onPressed: _resumeGame,
                  child: const Text('Resume'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
